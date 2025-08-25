#ifndef DISASSEMBLER_COLOR_HPP
#define DISASSEMBLER_COLOR_HPP

#include <ostream>

namespace vb {
namespace disassembler {

extern bool useColor;

enum class TtyControl { Reset, Dim, UnderLine, Green, Blue };

std::ostream &operator<<(std::ostream &os, const TtyControl color);

} // namespace disassembler
} // namespace vb

#endif // DISASSEMBLER_COLOR_HPP
