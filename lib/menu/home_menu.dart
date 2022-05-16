import 'dart:io';
import 'package:chess_shaxmat/menu/play_type_menu.dart';
import 'package:chess_shaxmat/menu/settings_menu.dart';
import 'package:chess_shaxmat/services/ext_service.dart';
import 'package:chess_shaxmat/services/io_service.dart';
import 'package:chess_shaxmat/services/navigation_service.dart';
import '../models/menu_model.dart';

class HomeMenu extends Menu {
  static const String id = '/home_menu';

  Future<void> homeMenu() async {
    writeln(printIsColor(
        text: ('\n                   -<< ' + '<= Chess_app =>'.tr + ' >>-'),
        penColor: 226));
    writeln(printIsColor(text: ' I.   ' + 'Play'.tr, penColor: 46));
    writeln(printIsColor(text: ' II.  ' + 'SETTINGS'.tr, penColor: 123));
    writeln(printIsColor(text: ' III. ' + 'Exit_the_application'.tr, penColor: 196));
    write(printIsColor(text: '\n ' + 'Enter_the_command:'.tr, penColor: 226));
    String selectMenu = read;
    await selectPlayMenu(selectMenu);
  }

  Future<void> selectPlayMenu(String selectMenu) async {
    switch (selectMenu) {
      case 'I':
        await Navigator.push(PlayMenu());
        break;
      case 'II':
        await Navigator.push(SettingsMenu());
        break;
      case 'III':
        exit(0);
      default:
        {
          writeln(
              printIsColor(text: 'Wrong_Command_Entered!'.tr, penColor: 196));
        }
    }
  }

  @override
  Future<void> build() async {
    await homeMenu();
  }
}
