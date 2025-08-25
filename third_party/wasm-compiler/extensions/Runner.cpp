#include <cassert>
#include <initializer_list>

#include "Runner.hpp"

#include "src/core/common/util.hpp"

namespace vb {
namespace extension {

ThreadRunner::ThreadRunner(std::function<void()> task) : task_(std::move(task)), currentState_(State::Finished), targetState_(State::Finished) {
}

ThreadRunner::~ThreadRunner() {
  assert(!thread_.joinable() && "thread leak");
}

void ThreadRunner::start() {
  assert(!thread_.joinable() && "duplicate start");
  targetState_.store(State::Running);
  thread_ = std::thread(&ThreadRunner::threadFunction, this);
}

void ThreadRunner::finish(std::initializer_list<std::condition_variable *> cvs) {
  targetState_.store(State::Finished);
  targetState_.notify_all();
  for (auto &cv : cvs) {
    cv->notify_all();
  }
  if (thread_.joinable()) {
    thread_.join();
  }
}

void ThreadRunner::pause(std::initializer_list<std::condition_variable *> cvs) {
  targetState_.store(State::Paused);
  for (auto &cv : cvs) {
    cv->notify_all();
  }
  currentState_.wait(State::Running);
}

void ThreadRunner::resume() {
  targetState_.store(State::Running);
  targetState_.notify_all(); // notify the thread function
}

void ThreadRunner::threadFunction() {
  while (true) {
    State const targetState = targetState_.load();
    State const currentState = currentState_.load();
    switch (targetState) {
    case State::Finished:
      if (currentState != targetState) {
        currentState_.store(targetState);
      }
      return;
    case State::Running:
      if (currentState != targetState) {
        currentState_.store(targetState);
      }
      task_();
      break;
    case State::Paused:
      if (currentState != targetState) {
        currentState_.store(targetState);
      }
      currentState_.notify_all(); // notify the pause request
      targetState_.wait(State::Paused);
      continue;
    default:
      UNREACHABLE(break, "impossible state")
    }
    std::this_thread::yield();
  }
}

} // namespace extension
} // namespace vb
