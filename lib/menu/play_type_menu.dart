import 'package:chess_shaxmat/menu/global_menu.dart';
import 'package:chess_shaxmat/services/ext_service.dart';
import 'package:chess_shaxmat/services/io_service.dart';
import 'package:chess_shaxmat/services/navigation_service.dart';
import 'package:chess_shaxmat/menu/local_menu.dart';
import '../models/menu_model.dart';

class PlayMenu extends Menu {
  static const String id = '/play_menu';

  Future<void> playSettings() async {
    writeln(printIsColor(text: ('\n                   -<< ' + 'O`yinni boshlash'.tr + ' >>-'), penColor: 226));
    writeln(printIsColor(text: ' 1. Ikki nafar bo`lib o`ynash', penColor: 46));
    writeln(printIsColor(text: ' 2. Boshqa qurilma bilan o`ynash', penColor: 51));
    writeln(printIsColor(text: ' 3. Bosh menyuga qaytish', penColor: 196));
    write(printIsColor(text: '\n Buyruqni kiriting: ', penColor: 226));
    String selectMenu = read;
    await selectPlay(selectMenu);
  }

  Future<void> selectPlay(String selectMenu) async {
    switch (selectMenu) {
      case '1':
        await Navigator.push(LocalMenu());
        break;
      case '2':
        await Navigator.push(GlobalMenu());
        break;
      case '3':
        await Navigator.pop();
        break;
      default:
        {
          writeln(
              printIsColor(text: ' Noto`g`ri buyruq kiritildi!', penColor: 196));
          await playSettings();
        }
    }
  }

  @override
  Future<void> build() async {
    await playSettings();
  }
}
