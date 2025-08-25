#ifndef TESTS_LOADER_JSON_LOADER
#define TESTS_LOADER_JSON_LOADER

#include <nlohmann/json.hpp>

#include "tests/TestData.hpp"
#include "tests/loader/test_loader.hpp"

namespace vb {

namespace Json {

struct JsonLoader {
  explicit JsonLoader(nlohmann::json &_commandIt) : command_(_commandIt) {
  }

  CommandType getType();
  uint32_t getLine();
  std::string getText();

  nlohmann::json &command_;
};

struct JsonModuleCommand final : public ModuleCommand {
  explicit JsonModuleCommand(nlohmann::json &_commandIt, std::shared_ptr<TestDataMapping> _testDataMapping)
      : jsonLoader_(_commandIt), testDataMapping_(_testDataMapping) {
  }
  Span<const uint8_t> getByteCode() override;

  CommandType getType() override {
    return jsonLoader_.getType();
  }
  uint32_t getLine() override {
    return jsonLoader_.getLine();
  }

private:
  JsonLoader jsonLoader_;
  std::shared_ptr<TestDataMapping> testDataMapping_;
};

struct JsonAssertCommand final : public AssertCommand {
  explicit JsonAssertCommand(nlohmann::json &_commandIt) : jsonLoader_(_commandIt) {
  }

  Action getAction() override;
  std::vector<Data> getExpected() override;
  CommandType getType() override {
    return jsonLoader_.getType();
  }
  uint32_t getLine() override {
    return jsonLoader_.getLine();
  }
  std::string getText() override {
    return jsonLoader_.getText();
  }

private:
  JsonLoader jsonLoader_;
};

struct JsonInvalidCommand final : public InvalidCommand {
  explicit JsonInvalidCommand(nlohmann::json &_commandIt, std::shared_ptr<TestDataMapping> _testDataMapping)
      : jsonLoader_(_commandIt), testDataMapping_(_testDataMapping) {
  }
  Span<const uint8_t> getByteCode() override;
  CommandType getType() override {
    return jsonLoader_.getType();
  }
  uint32_t getLine() override {
    return jsonLoader_.getLine();
  }

private:
  JsonLoader jsonLoader_;
  std::shared_ptr<TestDataMapping> testDataMapping_;
};

class JsonTestLoader final : public TestLoader {
public:
  explicit JsonTestLoader(nlohmann::json const &_testJson, std::shared_ptr<TestDataMapping> _testData) : testDataMapping_(_testData) {
    reorderCommands(_testJson["commands"]);
  }
  JsonTestLoader(JsonTestLoader const &) = delete;
  JsonTestLoader(JsonTestLoader &&) = delete;
  JsonTestLoader &operator=(JsonTestLoader const &) = delete;
  JsonTestLoader &operator=(JsonTestLoader &&) = delete;
  ~JsonTestLoader() override {
  }

  std::unique_ptr<Command> getNextCommand() override;

private:
  void reorderCommands(nlohmann::json const &commandsRef);

  std::vector<nlohmann::json> commandsRef_;
  std::vector<nlohmann::json>::iterator commandsIt_;

  std::shared_ptr<TestDataMapping> testDataMapping_;
};
} // namespace Json
} // namespace vb

#endif
