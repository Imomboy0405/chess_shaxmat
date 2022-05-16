import 'dart:io';
import 'package:chess_shaxmat/services/color_service.dart';

void write<T>(T object) => stdout.write(object);

void writeln<T>(T object) => stdout.writeln(object);

String get read => stdin.readLineSync() ?? '';

String printIsColor(
    {required String text, required int penColor, int bgColor = -1}) {
  final sb = StringBuffer();
  final pen = AnsiPen();
  if (bgColor != -1) {
    pen
      ..reset()
      ..xterm(bgColor, bg: true)
      ..xterm(penColor);
    sb.write(pen(text));
  } else {
    pen
      ..reset()
      ..xterm(penColor);
    sb.write(pen(text));
  }
  return sb.toString();
}
