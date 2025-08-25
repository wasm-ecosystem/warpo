#include <cassert>
#include <ostream>

#include "disassembler/color.hpp"

#if _WIN32
#include <io.h>
#define ISATTY _isatty
#define FILENO _fileno
#else
#include <unistd.h>
#define ISATTY isatty
#define FILENO fileno
#endif

namespace vb {
namespace disassembler {

inline static bool isTty() noexcept {
  static const bool isTty = 0 != ISATTY(FILENO(stdout));
  return isTty;
}

bool useColor = isTty();

std::ostream &operator<<(std::ostream &os, const TtyControl color) {
  if (useColor) {
    constexpr const char *Reset = "\033[0m";
    constexpr const char *Dim = "\033[2m";
    constexpr const char *UnderLine = "\033[4m";
    constexpr const char *ConsoleGreen = "\033[32m";
    constexpr const char *ConsoleBlue = "\033[34m";
    switch (color) {
    case TtyControl::Reset:
      os << Reset;
      break;
    case TtyControl::Dim:
      os << Dim;
      break;
    case TtyControl::UnderLine:
      os << UnderLine;
      break;
    case TtyControl::Green:
      os << ConsoleGreen;
      break;
    case TtyControl::Blue:
      os << ConsoleBlue;
      break;
    default:
      assert(false && "no known");
    }
  }
  return os;
}

} // namespace disassembler
} // namespace vb
