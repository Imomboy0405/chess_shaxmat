import 'lang_services.dart';
import 'local/en_US.dart';
import 'local/ru_RU.dart';
import 'local/uz_UZ.dart';

extension ExtString on String {
  String get tr {
    switch (LangService.getlanguage) {
      case Language.en:
        return enUS[this] ?? this;
      case Language.ru:
        return ruRU[this] ?? this;
      case Language.uz:
        return uzUZ[this] ?? this;
    }
  }

  int get toInt => int.tryParse(this) ?? 0;

  double get toDouble => double.tryParse(this) ?? 0;

  bool get toBool => (this == 'true');
}