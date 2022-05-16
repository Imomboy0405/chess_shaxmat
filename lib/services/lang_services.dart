import 'dart:convert';

import 'package:chess_shaxmat/services/navigation_service.dart';
import '../menu/lang_settings_menu.dart';
import '../models/chess_model.dart';
import 'display_service.dart';
import 'data_service.dart';

enum Language { en, ru, uz }

abstract class LangService {
  static late Language _language;
  static final DataService _fileService = DataService();

  static Future<Language> currentLanguage() async {
    await _fileService.initDirectory();
    await _fileService.initData();
    var resultName = await _fileService.readData("name");
    if (resultName != null) {
      Chess.name = resultName;
    } else {
      Chess.name = "Player";
      await _fileService.writeData("name", Chess.name);
    }

    dynamic resultTheme = await _fileService.readData("theme");
    if (resultTheme != null) {
      Chess.theme = jsonDecode(resultTheme);
      oq = Chess.theme[0];
      qora = Chess.theme[1];
    } else {
      oq = 255;
      qora = 0;
      Chess.theme = [oq, qora];
      await _fileService.writeData("theme", Chess.theme);
    }

    var result = await _fileService.readData("language");
    if (result != null) {
      _language = _stringToLanguage(result);
      return _language;
    }
    await Navigator.push(LangSettings(b: true));
    return _language;
  }

  // setter
  static Future<void> language(Language language) async {
    _language = language;
    await _fileService.writeData("language", _languageToString(language));
  }

  // getter
  static Language get getlanguage => _language;

  static Language _stringToLanguage(String lang) {
    switch (lang) {
      case "en":
        return Language.en;
      case "ru":
        return Language.ru;
      default:
        return Language.uz;
    }
  }

  static String _languageToString(Language lang) {
    switch (lang) {
      case Language.en:
        return "en";
      case Language.ru:
        return "ru";
      default:
        return "uz";
    }
  }
}
