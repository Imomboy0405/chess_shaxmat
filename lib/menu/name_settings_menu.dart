import 'package:chess_shaxmat/services/data_service.dart';
import 'package:chess_shaxmat/services/io_service.dart';
import 'package:chess_shaxmat/services/navigation_service.dart';
import '../models/chess_model.dart';
import '../models/menu_model.dart';

class NameSettings extends Menu {
  static const String id = '/name_settings';

  Future<void> nameSettings() async {
    writeln(printIsColor(text: " Ismni tahrirlash: ", penColor: 226));
    writeln(printIsColor(text: ' Avvalgi ismingiz: ${Chess.name}', penColor: 196));
    write(printIsColor(text: ' Yangi ismni kiriting: ', penColor: 50));
    String? name = read;
    await updateName(name);
  }

  Future<void> updateName(String? name) async {
    if (name != null && name.isNotEmpty) {
      Chess.name = name;
      DataService _fileService = DataService();
      await _fileService.writeData("name", name);
      writeln(printIsColor(
          text: ' Ismingiz muvofaqqiyatli o`zgartirildi!', penColor: 46));
      await Navigator.pop();
    } else {
      await nameSettings();
    }
  }

  @override
  Future<void> build() async {
    await nameSettings();
  }
}