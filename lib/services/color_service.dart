library ansicolor;

import 'package:chess_shaxmat/src/supports_ansi.dart'
    if (dart.library.io) 'package:chess_shaxmat/src/supports_ansi_io.dart'
    if (dart.library.html) 'package:chess_shaxmat/src/supports_ansi_web.dart';

bool ansiColorDisabled = !supportsAnsiColor;

@Deprecated(
    'Will be removed in future releases in favor of [ansiColorDisabled]')
bool get colorDisabled => ansiColorDisabled;

@Deprecated(
    'Will be removed in future releases in favor of [ansiColorDisabled]')
set colorDisabled(bool disabled) => ansiColorDisabled = disabled;

class AnsiPen {
  String call(Object msg) => write(msg);

  @override
  String toString() {
    if (ansiColorDisabled) return '';
    if (!_dirty) return _pen;

    final sb = StringBuffer();
    if (_fcolor != -1) {
      sb.write('${ansiEscape}38;5;${_fcolor}m');
    }

    if (_bcolor != -1) {
      sb.write('${ansiEscape}48;5;${_bcolor}m');
    }

    _dirty = false;
    _pen = sb.toString();
    return _pen;
  }

  /// Returns control codes to change the terminal colors.
  String get down => '${this}';

  /// Resets all pen attributes in the terminal.
  String get up => ansiColorDisabled ? '' : ansiDefault;

  /// Write the [msg.toString()] with the pen's current settings and then
  /// reset all attributes.
  String write(Object msg) => '${this}$msg$up';

  void black({bool bg = false, bool bold = false}) => _std(0, bold, bg);

  void red({bool bg = false, bool bold = false}) => _std(1, bold, bg);

  void green({bool bg = false, bool bold = false}) => _std(2, bold, bg);

  void yellow({bool bg = false, bool bold = false}) => _std(3, bold, bg);

  void blue({bool bg = false, bool bold = false}) => _std(4, bold, bg);

  void magenta({bool bg = false, bool bold = false}) => _std(5, bold, bg);

  void cyan({bool bg = false, bool bold = false}) => _std(6, bold, bg);

  void white({bool bg = false, bool bold = false}) => _std(7, bold, bg);

  /// Sets the pen color to the rgb value between 0.0..1.0.
  void rgb({num r = 1.0, num g = 1.0, num b = 1.0, bool bg = false}) => xterm(
      (r.clamp(0.0, 1.0) * 5).toInt() * 36 +
          (g.clamp(0.0, 1.0) * 5).toInt() * 6 +
          (b.clamp(0.0, 1.0) * 5).toInt() +
          16,
      bg: bg);

  /// Sets the pen color to a grey scale value between 0.0 and 1.0.
  void gray({num level = 1.0, bool bg = false}) =>
      xterm(232 + (level.clamp(0.0, 1.0) * 23).round(), bg: bg);

  void _std(int color, bool bold, bool bg) =>
      xterm(color + (bold ? 8 : 0), bg: bg);

  /// Directly index the xterm 256 color palette.
  void xterm(int color, {bool bg = false}) {
    _dirty = true;
    final c = color < 0
        ? 0
        : color > 255
            ? 255
            : color;
    if (bg) {
      _bcolor = c;
    } else {
      _fcolor = c;
    }
  }

  ///Resets the pen's attributes.
  void reset() {
    _dirty = false;
    _pen = '';
    _bcolor = _fcolor = -1;
  }

  int _fcolor = -1;
  int _bcolor = -1;
  String _pen = '';
  bool _dirty = false;
}

const ansiEscape = '\x1B[';

@Deprecated('Will be removed in future releases')
const ansiEsc = ansiEscape;

const ansiDefault = '${ansiEscape}0m';

@Deprecated('Will be removed in future releases')
const ansiDefault_ = ansiDefault;

const ansiResetForeground = '${ansiEscape}39m';

@Deprecated('Will be removed in future releases')
String resetForeground() => ansiResetForeground;

const ansiResetBackground = '${ansiEscape}49m';

@Deprecated('Will be removed in future releases')
String resetBackground() => ansiResetBackground;
