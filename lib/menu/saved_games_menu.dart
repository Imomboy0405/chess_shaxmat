import 'dart:io';

import 'package:chess_shaxmat/services/ext_service.dart';
import 'package:chess_shaxmat/services/file_service.dart';
import 'package:chess_shaxmat/services/io_service.dart';
import 'package:chess_shaxmat/services/navigation_service.dart';
import '../models/menu_model.dart';

class SavedGames extends Menu {
  static const String id = '/saved_games_menu';

  Future<void> games() async {
    writeln(printIsColor(
        text: ('\n                   -<< ' +
            'Saqlangan o`yinlarni boshqarish'.tr +
            ' >>-'),
        penColor: 226));
    List<FileSystemEntity> files = await FileService.viewAllFiles();
    if (files.isEmpty) {
      writeln(printIsColor(
          text: '\n Hozircha saqlangan o`yinlar mavjud emas!', penColor: 226));
      write(printIsColor(
          text: ' Ortga qaytish uchun enterni bosing.', penColor: 196));
      read;
      await Navigator.pop();
    } else {
      writeln(printIsColor(
          text: ('\n Saqlangan o`yinlar ro`yxati:'), penColor: 226));
      files.removeWhere((element) => element.toString().contains('.txt'));
      for (int i = 0; i < files.length; i++) {
        writeln(printIsColor(text: " ${i + 1}. ${files[i].path.substring(files[i].path.lastIndexOf("\\") + 1).replaceAll('.json', '')}", penColor: 155));
      }
      writeln(printIsColor(text: "\n 1. O`chirish: ", penColor: 196));
      writeln(printIsColor(text: ' 2. Barchasini o`chirish', penColor: 197));
      writeln(printIsColor(text: ' 3. Ortga qaytish', penColor: 51));
      writeln(printIsColor(text: ' 4. Bosh menyuga qaytish', penColor: 46));
      write(printIsColor(text: '\n Buyruqni kiriting: ', penColor: 226));
      String selectMenu = read;
      await selectSettings(selectMenu);
    }
  }

  Future<void> selectSettings(String selectMenu) async {
    switch (selectMenu) {
      case '1':
        {
          write(
              printIsColor(text: ' O`yin raqamini kiriting: ', penColor: 226));
          int gameNumber = read.toInt;
          List<FileSystemEntity> files = await FileService.viewAllFiles();
          files.removeWhere((element) => element.toString().contains('.txt'));
          String oldGameName = files[gameNumber-1].path.substring(files[gameNumber - 1].path.lastIndexOf("\\") + 1).replaceAll('.json', '');
          if (await FileService.deleteFile(oldGameName)) {
            await File(FileService.directory.path + '\\$oldGameName.txt').delete();
            writeln(printIsColor(
                text: ' Muvofaqqiyatli o`chirildi!', penColor: 46));
            write(printIsColor(
                text: ' Ortga qaytish uchun enterni bosing.', penColor: 196));
            read;
            await Navigator.pop();
          } else {
            writeln(printIsColor(
                text: '  Noto`g`ri nom kiritildi!', penColor: 196));
            await selectSettings('1');
          }
        }
        break;
      case '2':
        {
          await FileService.deleteAllFile();
          writeln(printIsColor(
              text: ' Barcha o`yinlar muvofaqqiyatli o`chirildi!',
              penColor: 46));
          write(printIsColor(
              text: ' Ortga qaytish uchun enterni bosing.', penColor: 196));
          read;
          await Navigator.pop();
        }
        break;
      case '3':
        await Navigator.pop();
        break;
      case '4':
        await Navigator.popUntil();
        break;
      default:
        {
          writeln(printIsColor(
              text: ' Noto`g`ri buyruq kiritildi!', penColor: 196));
          await games();
        }
    }
  }

  @override
  Future<void> build() async {
    await games();
  }
}
