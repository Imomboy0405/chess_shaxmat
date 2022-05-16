import 'package:chess_shaxmat/menu/home_menu.dart';
import 'package:chess_shaxmat/services/ext_service.dart';
import 'package:chess_shaxmat/services/io_service.dart';
import 'package:chess_shaxmat/services/lang_services.dart';
import 'package:chess_shaxmat/services/navigation_service.dart';
import '../models/menu_model.dart';

class LangSettings extends Menu {
  static const String id = '/lang_settings';
  bool? b;

  LangSettings({this.b});

  Future<void> langSettings() async {
    writeln(printIsColor(text: "Select_the_program_language:".tr, penColor: 226));
    writeln(printIsColor(text: ' I UZB', penColor: 51));
    writeln(printIsColor(text: ' II ENG', penColor: 196));
    writeln(printIsColor(text: ' III RUS', penColor: 27));
    write(printIsColor(text: 'Enter_the_command:'.tr, penColor: 226));
    String selectMenu = read;
    await selectLang(selectMenu);
  }

  Future<void> selectLang(String selectMenu) async {
    switch (selectMenu) {
      case 'I':
        await LangService.language(Language.uz);
        break;
      case 'II':
        await LangService.language(Language.en);
        break;
      case 'III':
        await LangService.language(Language.ru);
        break;
      default:
        {
          writeln(printIsColor(
              text: 'Wrong_Command_Entered!'.tr, penColor: 196));
          await langSettings();
        }
    }
    if (b != null) {
      b = null;
      writeln(printIsColor(
          text: 'Program_language_successfully_changed!'.tr, penColor:   46));
      await Navigator.pushReplacement(HomeMenu());
    } else {
      writeln(printIsColor(
          text: 'Program_language_successfully_changed!'.tr, penColor: 46));
      await Navigator.pop();
    }
  }

  @override
  Future<void> build() async {
    await langSettings();
  }
}
