import 'dart:convert';
import 'dart:io';

import 'package:chess_shaxmat/models/attack_model.dart';
import 'package:chess_shaxmat/models/chess_model.dart';
import 'package:chess_shaxmat/models/menu_model.dart';
import 'package:chess_shaxmat/services/attack_service.dart';
import 'package:chess_shaxmat/services/display_service.dart';
import 'package:chess_shaxmat/services/ext_service.dart';
import 'package:chess_shaxmat/services/io_service.dart';
import 'package:chess_shaxmat/services/navigation_service.dart';
import 'package:chess_shaxmat/services/network_service.dart';

class GlobalMenu extends Menu {
  static const String id = '/global_menu';

  @override
  Future<void> build() async {
    String katak1 = '', katak2 = '', figura;
    writeln(printIsColor(
        text: ('\n                   -<< '
                    'Boshqa qurilma bilan bog`lanib o`ynash'
                .tr +
            ' >>-'),
        penColor: 226));
    String name1 = Chess.name;
    Display.newGameUpdates();
    write(printIsColor(
        text: (' $name1 ' 'boshqa qurilma o`yinchisi ismini kiriting: '.tr),
        penColor: 51));
    String name2 = read;

    write(printIsColor(
        text: ' Oq yoki Qora rangni tanlang(Oq = true / Qora = false): ',
        penColor: 255));
    bool color = read.toBool;
    Chess.navbat = color;

    writeln(printIsColor(
        text: (' O`yinni tugatish uchun Exit`ni kiriting!'.tr + '...'),
        penColor: 196));
    sleep(Duration(seconds: 1));
    writeln(
        printIsColor(text: (' ' + 'the_game_begins'.tr + '...'), penColor: 46));
    sleep(Duration(seconds: 1));
    if (color) {
      Display.updateDoska(null, null, null, null);
    } else {
      Display.updateDoskaBlack(null, null, null, null);
    }

    // -----O'yin boshlandi------
    do {
      String index = '';
      // -----Kiritish-----
      if (color) {
        if (Chess.navbat) {
          writeln(printIsColor(
              text: (' $name1 ' "it's_your_turn".tr), penColor: 255));
          write(printIsColor(text: ' ' 'figure_is_located'.tr, penColor: 226));
          katak1 = read.toUpperCase();
          if (katak1 == 'EXIT') {
            katak2 = 'EXIT';
            List s = [katak1, katak2];
            await NetworkService.POST(
                NetworkService.apiChes,
                NetworkService.headers,
                {"from": name1, "to": name2, "location": s, "color": color});
            writeln(printIsColor(text: ' O`yin tugatildi!', penColor: 196));
            await Navigator.pop();
          } else {
            if (!(Display.katakManzil(katak1) &&
                Display.katakOqlardami(katak1))) {
              writeln(printIsColor(
                  text: (" $name1 " "entered_an_error".tr), penColor: 196));
              continue;
            }

            figura = Attack.nominiAniqla(katak1[0], katak1[1]);
            figura = figura
                .replaceRange(figura.length - 1, figura.length, '')
                .replaceRange(0, 1, '');
            write(printIsColor(
                text: " $figura " + "want_to_walk".tr, penColor: 46));
            katak2 = read.toUpperCase();
            if (!(Display.katakManzil(katak2) &&
                !Display.katakOqlardami(katak2))) {
              writeln(printIsColor(
                  text: " $name1 " 'entered_an_error'.tr, penColor: 196));
              continue;
            }

            // -----Natija-----
            if (Attack.natija(katak1[0], katak1[1], katak2[0], katak2[1])) {
              List s = [katak1, katak2];
              await NetworkService.POST(
                  NetworkService.apiChes,
                  NetworkService.headers,
                  {"from": name1, "to": name2, "location": s, "color": color});
              Display.updateDoska(
                  Display.harfManzil(katak1[0]),
                  int.parse(katak1[1]),
                  Display.harfManzil(katak2[0]),
                  int.parse(katak2[1]));
            } else {
              writeln(printIsColor(
                  text: ('we'.tr + " $figura " "can't_walk".tr),
                  penColor: 196));
              continue;
            }
          }
        } else {
          write(printIsColor(
              text: ' ${name2}ning navbati kutilmoqda...', penColor: 46));
          bool res = true;
          while (res) {
            index = '';
            String source = await NetworkService.GET(
                NetworkService.apiChes, NetworkService.headers);

            List list = jsonDecode(source);

            List<AttackModel> loc =
                list.map((e) => AttackModel.fromJson(e)).toList();

            for (var item in loc) {
              if (item.to == name1) {
                katak1 = item.location[0];
                katak2 = item.location[1];
                index = item.id!;
                if (item.location[0] == 'EXIT') {
                  writeln(printIsColor(
                      text: ' $name2 o`yinni yakunladi!', penColor: 196));
                  write(printIsColor(
                      text: ' Ortga qaytish uchun enterni bosing: ',
                      penColor: 196));
                  read;
                  await Navigator.pop();
                }
              }
            }
            if (index != "") {
              res = false;
            }
            await waiting();
          }
          await NetworkService.DELETE(
              NetworkService.apiChes + "/$index", NetworkService.headers);
          // -----Natija-----
          Attack.natija(katak1[0], katak1[1], katak2[0], katak2[1]);
          Display.updateDoska(
              Display.harfManzil(katak1[0]),
              int.parse(katak1[1]),
              Display.harfManzil(katak2[0]),
              int.parse(katak2[1]));
        }
      } else {
        if (Chess.navbat) {
          writeln(printIsColor(
              text: ('  -' + name2 + " " + "it's_your_turn".tr), penColor: 0));
          write('figure_is_located'.tr);
          katak1 = read.toUpperCase();
          if (katak1 == 'EXIT') {
            katak2 = 'EXIT';
            List s = [katak1, katak2];
            await NetworkService.POST(
                NetworkService.apiChes,
                NetworkService.headers,
                {"from": name1, "to": name2, "location": s, "color": color});
            writeln(printIsColor(text: ' O`yin tugatildi!', penColor: 196));
            write(printIsColor(
                text: ' Ortga qaytish uchun enterni bosing: ', penColor: 196));
            read;
            await Navigator.pop();
          } else {
            if (!(Display.katakManzil(katak1) &&
                Display.katakQoralardami(katak1))) {
              writeln(printIsColor(
                  text: (" $name2 " + "entered_an_error".tr), penColor: 196));
              continue;
            }

            figura = Attack.nominiAniqla(katak1[0], katak1[1]);
            figura = figura
                .replaceRange(figura.length - 1, figura.length, '')
                .replaceRange(0, 1, '');
            write(" $figura " "want_to_walk".tr);
            katak2 = read.toUpperCase();
            if (!(Display.katakManzil(katak2) &&
                !Display.katakQoralardami(katak2))) {
              writeln(printIsColor(
                  text: " $name2 " 'entered_an_error'.tr, penColor: 196));
              continue;
            }

            // -----Natija-----
            if (Attack.natija(katak1[0], katak1[1], katak2[0], katak2[1])) {
              List s = [katak1, katak2];
              await NetworkService.POST(
                  NetworkService.apiChes, NetworkService.headers, {
                "from": name1,
                "to": name2,
                "location": s,
                "color": color,
              });

              Display.updateDoskaBlack(
                  Display.harfManzil(katak1[0]),
                  int.parse(katak1[1]),
                  Display.harfManzil(katak2[0]),
                  int.parse(katak2[1]));
            } else {
              writeln(printIsColor(
                  text: (' ' 'we'.tr + figura + "can't_walk".tr),
                  penColor: 196));
              continue;
            }
          }
        } else {
          write(printIsColor(
              text: ' ${name2}ning navbati kutilmoqda...', penColor: 46));
          bool res = true;
          while (res) {
            index = '';
            String source = await NetworkService.GET(
                NetworkService.apiChes, NetworkService.headers);

            List list = jsonDecode(source);

            List<AttackModel> loc =
                list.map((e) => AttackModel.fromJson(e)).toList();

            for (var item in loc) {
              if (item.to == name1) {
                katak1 = item.location[0];
                katak2 = item.location[1];
                index = item.id!;
                if (item.location[0] == 'EXIT') {
                  writeln(printIsColor(
                      text: ' $name2 o`yinni yakunladi!', penColor: 196));
                  write(printIsColor(
                      text: ' Ortga qaytish uchun enterni bosing: ',
                      penColor: 196));
                  read;
                  await Navigator.pop();
                }
              }
            }
            if (index != "") {
              res = false;
            }
            await waiting();
          }
          await NetworkService.DELETE(
              NetworkService.apiChes + "/$index", NetworkService.headers);
          // -----Natija-----
          Attack.natija(katak1[0], katak1[1], katak2[0], katak2[1]);
          Display.updateDoskaBlack(
              Display.harfManzil(katak1[0]),
              int.parse(katak1[1]),
              Display.harfManzil(katak2[0]),
              int.parse(katak2[1]));
        }
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
    writeln(printIsColor(text: ' ' "the_end".tr, penColor: 196));
    write(printIsColor(
        text: ' Ortga qaytish uchun enterni bosing: ', penColor: 196));
    read;
    await Navigator.pop();
  }
}

Future waiting() {
  return Future.delayed(Duration(seconds: 1));
}
