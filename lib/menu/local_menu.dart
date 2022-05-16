import 'dart:convert';
import 'dart:io';

import 'package:chess_shaxmat/models/chess_model.dart';
import 'package:chess_shaxmat/models/menu_model.dart';
import 'package:chess_shaxmat/services/attack_service.dart';
import 'package:chess_shaxmat/services/display_service.dart';
import 'package:chess_shaxmat/services/ext_service.dart';
import 'package:chess_shaxmat/services/file_service.dart';
import 'package:chess_shaxmat/services/io_service.dart';

import '../services/io_service.dart';
import '../services/navigation_service.dart';

class LocalMenu extends Menu {
  static const String id = '/local_menu';

  @override
  Future<void> build() async {
    await localMenu();
  }

  Future<void> localMenu() async {
    writeln(printIsColor(
        text: ('\n                   -<< ' +
            'Shu qurilmada ikki nafar bo`lib o`ynash'.tr +
            ' >>-'),
        penColor: 226));
    writeln(printIsColor(text: ' 1.   Yangi o`yin boshlash', penColor: 46));
    writeln(printIsColor(
        text: ' 2.   Avvalgi o`yinni davom ettirish', penColor: 51));
    writeln(printIsColor(text: ' 3.   Ortga qaytish', penColor: 197));
    writeln(printIsColor(text: ' 4.   Bosh menyuga qaytish', penColor: 196));
    write(printIsColor(text: '\n Buyruqni kiriting: ', penColor: 226));
    String selectGame = read;
    await selectPlayGame(selectGame);
  }

  Future<void> selectPlayGame(String selectGame) async {
    switch (selectGame) {
      case '1':
        await newGame();
        break;
      case '2':
        await oldGame();
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
          await localMenu();
        }
    }
  }

  Future<void> oldGame() async {
    writeln(
        printIsColor(text: (' Saqlangan o`yinlar ro`yxati:'), penColor: 226));
    List<FileSystemEntity> files = await FileService.viewAllFiles();
    files.removeWhere((element) => element.toString().contains('.txt'));
    for (int i = 0; i < files.length; i++) {
      writeln(printIsColor(
          text:
              " ${i + 1}. ${files[i].path.substring(files[i].path.lastIndexOf("\\") + 1).replaceAll('.json', '')}",
          penColor: 155));
    }
    write(printIsColor(text: ' O`yin raqamini kiriting: ', penColor: 226));
    int gameNumber = read.toInt;
    List list = [];
    String oldGameName = files[gameNumber - 1]
        .path
        .substring(files[gameNumber - 1].path.lastIndexOf("\\") + 1)
        .replaceAll('.json', '');
    list.addAll(jsonDecode(await FileService.readFile(oldGameName)));

    String katak1, katak2, figura;
    String name1 = Chess.name;
    Chess.navbat = list[3];
    String name2 = list[2];
    Chess.figuralar.clear();
    Chess.figuralar.addAll(list[0]);
    Chess.figuralarR.clear();
    Chess.figuralarR.addAll(list[1]);

    writeln(printIsColor(text: ' Ushbu o`yin tarixi:', penColor: 226));
    writeln(printIsColor(text: await FileService.writeFile(oldGameName, ''), penColor: 51));
    writeln(printIsColor(
        text: (' O`yinni tugatish uchun Exit kalit so`zini kiriting!'.tr +
            '...'),
        penColor: 196));
    sleep(Duration(seconds: 1));
    writeln(printIsColor(text: ('the_game_begins'.tr + '...'), penColor: 46));
    sleep(Duration(seconds: 1));
    Display.oldGameUpdateDoska();

    // -----O'yin boshlandi------
    do {
      // -----Kiritish-----
      if (Chess.navbat) {
        writeln(printIsColor(
            text: ('  -' + name1 + " " + "it's_your_turn".tr), penColor: 255));
        write('figure_is_located'.tr);
        katak1 = read.toUpperCase();
        if (katak1 == 'EXIT') {
          await endOldGame(name2, oldGameName);
          write(printIsColor(
              text: ' Ortga qaytish uchun enterni bosing:', penColor: 196));
          read;
          await Navigator.pop();
        }
        if (!(Display.katakManzil(katak1) && Display.katakOqlardami(katak1))) {
          writeln(printIsColor(
              text: ('  -' + name1 + " " + "entered_an_error".tr),
              penColor: 196));
          continue;
        }

        figura = Attack.nominiAniqla(katak1[0], katak1[1]);
        figura = figura
            .replaceRange(figura.length - 1, figura.length, '')
            .replaceRange(0, 1, '');
        write("   " + figura + " " + "want_to_walk".tr);
        katak2 = read.toUpperCase();
        if (!(Display.katakManzil(katak2) && !Display.katakOqlardami(katak2))) {
          print(name1 + " " + 'entered_an_error'.tr);
          continue;
        }
      } else {
        writeln(printIsColor(
            text: ('  -' + name2 + "it's_your_turn".tr), penColor: 0));
        write("figure_is_located".tr);
        katak1 = read.toUpperCase();
        if (katak1 == 'EXIT') {
          await endOldGame(name2, oldGameName);
          write(printIsColor(
              text: ' Ortga qaytish uchun enterni bosing: ', penColor: 196));
          read;
          await Navigator.pop();
        }
        if (!(Display.katakManzil(katak1) &&
            Display.katakQoralardami(katak1))) {
          writeln(printIsColor(
              text: ('  -' + name2 + " " + "entered_an_error".tr),
              penColor: 196));

          continue;
        }

        figura = Attack.nominiAniqla(katak1[0], katak1[1]);
        figura = figura
            .replaceRange(figura.length - 1, figura.length, '')
            .replaceRange(0, 1, '');
        write("   " + figura + " " + 'want_to_walk'.tr);
        katak2 = read.toUpperCase();
        if (!(Display.katakManzil(katak2) &&
            !Display.katakQoralardami(katak2))) {
          print(name2 + " " + 'entered_an_error'.tr);
          continue;
        }
      }
      // -----Natija-----
      if (Attack.natija(katak1[0], katak1[1], katak2[0], katak2[1])) {
        Display.updateDoska(Display.harfManzil(katak1[0]), int.parse(katak1[1]),
            Display.harfManzil(katak2[0]), int.parse(katak2[1]));
      } else {
        writeln(printIsColor(
            text: ('we'.tr + figura + "can't_walk".tr), penColor: 196));
        continue;
      }

      if (Chess.navbat) {
        await FileService.writeFile(oldGameName, ' $name1: $figura = $katak1 => $katak2');
      } else {
        await FileService.writeFile(oldGameName, ' $name2: $figura = $katak1 => $katak2');
      }

      Chess.navbat = !Chess.navbat; // Navbatni o'zgartirish

      // -----O'yinni tugatish-----
      if (!Chess.figuralar.containsKey('▓SHOH1')) {
        print("congratulations".tr + " " + name2 + " " + "won".tr);
        break;
      }
      if (!Chess.figuralarR.containsKey('░SHOH1')) {
        print("congratulations".tr + " " + name1 + " " + "won".tr);
        break;
      }
    } while (1 > 0);
    print("the_end".tr);
    write(printIsColor(
        text: ' Ortga qaytish uchun enterni bosing: ', penColor: 196));
    await FileService.deleteFile(oldGameName);
    await File(FileService.directory.path + '\\$oldGameName.txt').delete();
    read;
    await localMenu();
  }

  Future<void> newGame() async {
    String katak1, katak2, figura, gameStore = '';
    String name1 = Chess.name;
    Display.newGameUpdates();
    write(printIsColor(
        text: ('\n ' + name1 + ' raqib ishtirokchi ismini kiriting: '.tr),
        penColor: 226));
    String name2 = read;
    writeln(printIsColor(
        text: (' O`yinni tugatish uchun Exit`ni kiriting!'.tr), penColor: 196));
    sleep(Duration(seconds: 1));
    writeln(
        printIsColor(text: (' ' + 'the_game_begins'.tr + '...'), penColor: 46));
    sleep(Duration(seconds: 1));
    Display.updateDoska(null, null, null, null);

    // -----O'yin boshlandi------
    do {
      // -----Kiritish-----
      if (Chess.navbat) {
        writeln(printIsColor(
            text: (" $name1 " + "it's_your_turn".tr), penColor: 226));
        write(
            printIsColor(text: (" " + 'figure_is_located'.tr), penColor: 226));
        katak1 = read.toUpperCase();
        if (katak1 == 'EXIT') {
          await endGame(name2, gameStore);
          write(printIsColor(
              text: ' Ortga qaytish uchun enterni bosing: ', penColor: 196));
          katak1 = read;
          await Navigator.pop();
        }
        if (!(Display.katakManzil(katak1) && Display.katakOqlardami(katak1))) {
          writeln(printIsColor(
              text: (' ' + name1 + " " + "entered_an_error".tr),
              penColor: 196));
          continue;
        }

        figura = Attack.nominiAniqla(katak1[0], katak1[1]);
        figura = figura
            .replaceRange(figura.length - 1, figura.length, '')
            .replaceRange(0, 1, '');
        write(printIsColor(text: " $figura " + "want_to_walk".tr, penColor: 46));
        katak2 = read.toUpperCase();
        if (!(Display.katakManzil(katak2) && !Display.katakOqlardami(katak2))) {
          writeln(printIsColor(text: ' $name1 ' + 'entered_an_error'.tr, penColor: 196));
          continue;
        }
      } else {
        writeln(printIsColor(
            text: ('  $name2 ' + "it's_your_turn".tr), penColor: 226));
        write("figure_is_located".tr);
        katak1 = read.toUpperCase();
        if (katak1 == 'EXIT') {
          await endGame(name2, gameStore);
          write(printIsColor(
              text: ' Ortga qaytish uchun enterni bosing: ', penColor: 196));
          katak1 = read;
          await Navigator.pop();
        }
        if (!(Display.katakManzil(katak1) &&
            Display.katakQoralardami(katak1))) {
          writeln(printIsColor(
              text: (' $name2 ' + "entered_an_error".tr),
              penColor: 196));

          continue;
        }

        figura = Attack.nominiAniqla(katak1[0], katak1[1]);
        figura = figura
            .replaceRange(figura.length - 1, figura.length, '')
            .replaceRange(0, 1, '');
        write("   " + figura + " " + 'want_to_walk'.tr);
        katak2 = read.toUpperCase();
        if (!(Display.katakManzil(katak2) &&
            !Display.katakQoralardami(katak2))) {
          print(name2 + " " + 'entered_an_error'.tr);
          continue;
        }
      }
      // -----Natija-----
      if (Attack.natija(katak1[0], katak1[1], katak2[0], katak2[1])) {
        Display.updateDoska(Display.harfManzil(katak1[0]), int.parse(katak1[1]),
            Display.harfManzil(katak2[0]), int.parse(katak2[1]));
      } else {
        writeln(printIsColor(
            text: ('we'.tr + figura + "can't_walk".tr), penColor: 196));
        continue;
      }

      if (Chess.navbat) {
        gameStore += ' $name1: $figura\t = $katak1 => $katak2\n';
      } else {
        gameStore += ' $name2: $figura\t = $katak1 => $katak2\n';
      }

      //shox berilgani tekshirish
      if (Attack.shohBerdi()) {
        if (Chess.navbat) {
          writeln(printIsColor(text: ' $name2 sizga shox berildi!', penColor: 196));
        } else {
          writeln(printIsColor(text: ' $name1 sizga shox berildi!', penColor: 196));
        }
        writeln(printIsColor(text: ' O`yinni davob ettirish uchun Enter`ni bosing', penColor: 46));
        read;
      }

      Chess.navbat = !Chess.navbat; // Navbatni o'zgartirish

      // -----O'yinni tugatish-----
      if (!Chess.figuralar.containsKey('▓SHOH1')) {
        print("congratulations".tr + " " + name2 + " " + "won".tr);
        break;
      }
      if (!Chess.figuralarR.containsKey('░SHOH1')) {
        print("congratulations".tr + " " + name1 + " " + "won".tr);
        break;
      }
    } while (1 > 0);
    print("the_end".tr);
    write(printIsColor(
        text: ' Bosh menyuga qaytish uchun enterni bosing.', penColor: 196));
    read;
    await Navigator.popUntil();
  }

  Future<void> endGame(String name, String gameStore) async {
    writeln(printIsColor(text: ' O`yin saqlab qo`yilsinmi?(True/False): ', penColor: 46));
    bool isGameSave = read.toBool;
    if (isGameSave) {
      await saveGame(name, gameStore);
    } else {
      writeln(printIsColor(
          text: ' O`yin muvofaqqiyatli tugatildi!', penColor: 196));
    }
  }

  Future<void> endOldGame(String name, String fileName) async {
    String text = '[' +
        jsonEncode(Chess.figuralar) +
        ',' +
        jsonEncode(Chess.figuralarR) +
        ',' +
        jsonEncode(name) +
        ',' +
        jsonEncode(Chess.navbat) +
        ']';
    if (await FileService.reWriteFile(fileName, text)) {
      writeln(
          printIsColor(text: ' O`yin muvofaqqiyatli saqlandi!', penColor: 46));
    } else {

      writeln(printIsColor(
          text: ' O`yinni saqlashda texnik nosozlik!', penColor: 196));
    }
  }

  Future<void> saveGame(String name, String gameStore) async {
    writeln(printIsColor(text: ' O`yinga nom bering: ', penColor: 226));
    String fileName = read;
    if (await FileService.createFile(fileName)) {
      String text = '[' +
          jsonEncode(Chess.figuralar) +
          ',' +
          jsonEncode(Chess.figuralarR) +
          ',' +
          jsonEncode(name) +
          ',' +
          jsonEncode(Chess.navbat) +
          ']';
      if (await FileService.reWriteFile(fileName, text)) {
        await FileService.writeFile(fileName, gameStore);
        writeln(printIsColor(
            text: ' O`yin muvofaqqiyatli saqlandi!', penColor: 46));
      } else {
        writeln(printIsColor(
            text: ' O`yinni saqlashda texnik nosozlik!', penColor: 196));
      }
    } else {
      writeln(' Bunday nomdagi o`yin avvaldan mavjud!');
      await saveGame(name, gameStore);
    }
  }
}
