import 'package:chess_shaxmat/menu/saved_games_menu.dart';
import 'package:chess_shaxmat/services/ext_service.dart';
import 'package:chess_shaxmat/services/io_service.dart';
import 'package:chess_shaxmat/services/navigation_service.dart';
import 'package:chess_shaxmat/menu/lang_settings_menu.dart';
import 'package:chess_shaxmat/menu/theme_settings_menu.dart';
import '../models/menu_model.dart';
import 'name_settings_menu.dart';

class SettingsMenu extends Menu {
  static const String id = '/settings_menu';

  Future<void> settings() async {
    writeln(printIsColor(
        text: ('\n                   -<< ' + 'Sozlammalar'.tr + ' >>-'),
        penColor: 226));
    writeln(printIsColor(text: " 1. Tilni o`zgartirish:", penColor: 226));
    writeln(printIsColor(text: ' 2. Mavzuni o`zgartirish', penColor: 197));
    writeln(printIsColor(text: ' 3. Ismni o`zgartirish', penColor: 51));
    writeln(printIsColor(text: ' 4. Saqlangan o`yinlarni boshqarish', penColor: 129));
    writeln(printIsColor(text: ' 5. Bosh menyuga qaytish', penColor: 46));
    write(printIsColor(text: '\n Buyruqni kiriting: ', penColor: 226));
    String selectMenu = read;
    await selectSettings(selectMenu);
  }

  Future<void> selectSettings(String selectMenu) async {
    switch (selectMenu) {
      case '1':
        await Navigator.push((LangSettings()));
        break;
      case '2':
        await Navigator.push(ThemeSettings());
        break;
      case '3':
        await Navigator.push(NameSettings());
        break;
      case '4':
        await Navigator.push(SavedGames());
        break;
      case '5':
        await Navigator.pop();
        break;
      default:
        {
          writeln(
              printIsColor(text: ' Noto`g`ri buyruq kiritildi!', penColor: 196));
          await settings();
        }
    }
  }

  @override
  Future<void> build() async {
    await settings();
  }
}