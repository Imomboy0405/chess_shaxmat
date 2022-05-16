import 'package:chess_shaxmat/services/io_service.dart';
import 'package:chess_shaxmat/services/navigation_service.dart';
import '../models/chess_model.dart';
import '../models/menu_model.dart';
import '../services/display_service.dart';
import '../services/data_service.dart';

class ThemeSettings extends Menu {
  static const String id = '/theme_settings';

  Future<void> themeSettings() async {
    writeln(printIsColor(text: " Mavzu tanlang: ", penColor: 226));
    writeln(printIsColor(text: ' 1 => ', penColor: 255) +
        printIsColor(text: '   ', penColor: 0, bgColor: 255) +
        printIsColor(text: '   ', penColor: 0, bgColor: 0));
    writeln(printIsColor(text: ' 2 => ', penColor: 255) +
        printIsColor(text: '   ', penColor: 0, bgColor: 228) +
        printIsColor(text: '   ', penColor: 0, bgColor: 52));
    writeln(printIsColor(text: ' 3 => ', penColor: 255) +
        printIsColor(text: '   ', penColor: 0, bgColor: 226) +
        printIsColor(text: '   ', penColor: 0, bgColor: 17));
    writeln(printIsColor(text: ' 4 => ', penColor: 255) +
        printIsColor(text: '   ', penColor: 0, bgColor: 51) +
        printIsColor(text: '   ', penColor: 0, bgColor: 196));
    writeln(printIsColor(text: ' 5 => ', penColor: 255) +
        printIsColor(text: '   ', penColor: 0, bgColor: 46) +
        printIsColor(text: '   ', penColor: 0, bgColor: 55));
    write(printIsColor(text: ' Buyruqni kiriting: ', penColor: 226));
    String selectMenu = read;
    await selectTheme(selectMenu);
  }

  Future<void> selectTheme(String selectMenu) async {
    switch (selectMenu) {
      case '1':
        {
          oq = 255;
          qora = 0;
        }
        break;
      case '2':
        {
          oq = 228;
          qora = 52;
        }
        break;
      case '3':
        {
          oq = 226;
          qora = 17;
        }
        break;
      case '4':
        {
          oq = 51;
          qora = 196;
        }
        break;
      case '5':
        {
          oq = 46;
          qora = 55;
        }
        break;
      default:
        {
          await themeSettings();
        }
    }
    Chess.theme = [oq, qora];
    DataService _fileService = DataService();
    await _fileService.writeData("theme", Chess.theme);
    writeln(printIsColor(
        text: ' Mavzu muvofaqqiyatli o`zgartirildi!', penColor: 46));
    await Navigator.pop();
  }

  @override
  Future<void> build() async {
    await themeSettings();
  }
}
