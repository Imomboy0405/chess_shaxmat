

import 'package:chess_shaxmat/services/ext_service.dart';

import '../models/chess_model.dart';
import 'display_service.dart';

abstract class Attack {
// -----Hujum funksiyalari-----
  static bool natija(var x, var y, var x1, var y1) {
    // Bu funksiya yurish qilishda figuraga mos funksiyalarga yo'naltiradi
    String figura = nominiAniqla(x, y);
    figura = figura.replaceRange(figura.length - 1, figura.length, '');
    y = y.toString().toInt;
    y1 = y1.toString().toInt;
    switch (figura) {
      case '▓SHOH':
      case '░SHOH':
        return shoh(x, y, x1, y1);
      case '▓FARZIN':
      case '░FARZIN':
        return farzin(x, y, x1, y1);
      case '▓FIL':
      case '░FIL':
        return fil(x, y, x1, y1);
      case '▓OT':
      case '░OT':
        return ot(x, y, x1, y1);
      case "▓TO'RA":
      case "░TO'RA":
        return tora(x, y, x1, y1);
      case '▓PIYODA':
      case '░PIYODA':
        return piyoda(x, y, x1, y1);
      default:
        return false;
    }
  }

  static bool siklUchun(int xx, int yy, int x1, int y1, String bizniFigura) {
    // Bu siklda figura 4 tarafga yurishi jarayonida siklga 4 marta bitta kod yozmaslik uchun
    bool result = true;
    bool result1 = false;
    String deleteFigura = '';
    if (xx == x1 && yy == y1) {
      // Agar manzilga yetib borsa

      if (bizniFigura[0] == '▓') {
        // Agar figura oq bo'lsa
        Chess.figuralar.forEach((nom, manzil) {
          if (manzil[0] == raqamToHarf(x1) && manzil[1] == y1.toString()) {
            result = false; // Manzilda oq figura bo'lsa false qaytaradi
          }
        });
        if (result == false) {
          return false;
        }
        Chess.figuralarR.forEach((nom, manzil) {
          if (manzil[0] == raqamToHarf(x1) && manzil[1] == y1.toString()) {
            Chess.figuralar[bizniFigura] = manzil[0] + manzil[1] + '1';
            deleteFigura = nom; // Agar manzilda qora bo'lsa yangilaydi
            result1 = true;
          }
        });
        if (result1) {
          Chess.figuralarR.remove(deleteFigura);
          return true;
        }
        Chess.figuralar[bizniFigura] = raqamToHarf(xx) + yy.toString() + '1';
        return true; // Agar manzil bo'sh bo'lsa yangilaydi va true qaytaradi
      }

      if (bizniFigura[0] == '░') {
        // Agar figura qora bo'lsa
        Chess.figuralarR.forEach((nom, manzil) {
          if (manzil[0] == raqamToHarf(x1) && manzil[1] == y1.toString()) {
            result = false; // Manzilda qora figura bo'lsa false qaytaradi
          }
        });
        if (result == false) {
          return false;
        }
        Chess.figuralar.forEach((nom, manzil) {
          if (manzil[0] == raqamToHarf(x1) && manzil[1] == y1.toString()) {
            Chess.figuralarR[bizniFigura] = manzil[0] + manzil[1] + '1';
            deleteFigura = nom; // Agar manzilda oq bo'lsa yangilaydi
            result1 = true;
          }
        });
        if (result1) {
          Chess.figuralar.remove(deleteFigura);
          return true;
        }
        Chess.figuralarR[bizniFigura] = raqamToHarf(xx) + yy.toString() + '1';
        return true; // Agar manzil bo'sh bo'lsa yangilaydi  va true qaytaradi
      }
    }
    // Agar manzilga yetib bormagan bo'lsa
    if (nominiAniqla(raqamToHarf(xx), yy.toString()) == 'no') {
      return true; // Agar yo'lda figura bo'lmasa true qaytaradi
    } else {
      return false; // Agar bo'lsa false qaytaradi
    }
  }

  static String nominiAniqla(String x, String y) {
    // Bu funksiya katakda turgan figuraning mapdagi nomini qaytaradi
    // agar katak bo'sh bo'lsa no qaytaradi
    String result = 'no';
    bool r = true;
    Chess.figuralar.forEach((nomi, manzil) {
      if (manzil[0] == x && manzil[1] == y) {
        result = nomi;
        r = false;
      }
    });
    if (r) {
      Chess.figuralarR.forEach((nomi, manzil) {
        if (manzil[0] == x && manzil[1] == y) {
          result = nomi;
        }
      });
    }
    return result;
  }

  static String figuraManzili(String figuraNomi) {
    // Bu funksiya katakda turgan figuraning mapdagi manzilini qaytaradi
    // agar bunday figura bo'lmasa no qaytaradi
    String result;
    if (figuraNomi[0] == '▓') {
      result = Chess.figuralar[figuraNomi] ?? 'no';
    } else {
      result = Chess.figuralarR[figuraNomi] ?? 'no';
    }
    return result;
  }

  static String raqamToHarf(int x) {
    // Bu funksiya raqamga mos harf qaytaradi
    switch (x) {
      case 1:
        return 'A';
      case 2:
        return 'B';
      case 3:
        return 'C';
      case 4:
        return 'D';
      case 5:
        return 'E';
      case 6:
        return 'F';
      case 7:
        return 'G';
      case 8:
        return 'H';
      default:
        return 'I';
    }
  }

  static bool piyoda(var x, int y, var x1, int y1) {
    // Bu funksiya piyodani yurish qilishini backend qismi
    String figuraNomi = nominiAniqla(x, y.toString());
    String figuraKatagi = figuraManzili(figuraNomi);
    if (figuraNomi[0] == '▓') {
      if (((figuraKatagi[2] == '0') &&
              (x == x1 && y1 == y + 2) &&
              nominiAniqla(x1, y1.toString()) == 'no') ||
          ((x == x1 && y1 == y + 1) &&
              (nominiAniqla(x1, y1.toString()) == 'no'))) {
        Chess.figuralar[figuraNomi] = x1 + y1.toString() + '1';
        return true; // Oq figura bo'lsa yurish sharti
      }
      if (((Display.harfManzil(x1) - 1) == Display.harfManzil(x)) &&
          (y + 1 == y1) &&
          nominiAniqla(x1, y1.toString())[0] == '░') {
        Chess.figuralarR.remove(nominiAniqla(x1, y1.toString()));
        Chess.figuralar[figuraNomi] = x1 + y1.toString() + '1';
        return true; // Oq figuraning hujumi
      }
      if (((Display.harfManzil(x1) + 1) == Display.harfManzil(x)) &&
          (y + 1 == y1) &&
          nominiAniqla(x1, y1.toString())[0] == '░') {
        Chess.figuralarR.remove(nominiAniqla(x1, y1.toString()));
        Chess.figuralar[figuraNomi] = x1 + y1.toString() + '1';
        return true; // Oq figuraning hujumi
      }
    } else {
      if (((figuraKatagi[2] == '0') &&
              (x == x1 && y1 == y - 2) &&
              nominiAniqla(x1, y1.toString()) == 'no') ||
          ((x == x1 && y1 == y - 1) &&
              (nominiAniqla(x1, y1.toString()) == 'no'))) {
        Chess.figuralarR[figuraNomi] = x1 + y1.toString() + '1';
        return true; // Qora figura bo'lsa yurish sharti
      }
      if (((Display.harfManzil(x1) - 1) == Display.harfManzil(x)) &&
          (y - 1 == y1) &&
          nominiAniqla(x1, y1.toString())[0] == '▓') {
        Chess.figuralar.remove(nominiAniqla(x1, y1.toString()));
        Chess.figuralarR[figuraNomi] = x1 + y1.toString() + '1';
        return true; // Qora figuraning hujumi
      }
      if (((Display.harfManzil(x1) + 1) == Display.harfManzil(x)) &&
          (y - 1 == y1) &&
          nominiAniqla(x1, y1.toString())[0] == '▓') {
        Chess.figuralar.remove(nominiAniqla(x1, y1.toString()));
        Chess.figuralarR[figuraNomi] = x1 + y1.toString() + '1';
        return true; // Qora figuraning hujumi
      }
    }
    return false; // Agar umuman true chiqmasa demak noto'g'ri yurish va false
  }

  static bool shoh(var x, int y, var x1, int y1) {
    // Bu funksiya shohni yurish qilishini backend qismi
    String bizniFigura = nominiAniqla(x, y.toString());
    String deleteFigura = '';
    bool result = false;
    String xx = x1;
    if (bizniFigura[0] == '▓') {
      if (Chess.figuralar[bizniFigura] == 'E10' &&
          Chess.figuralar["▓TO'RA2"] == 'H10' &&
          y1 == 1 &&
          x1 == 'G') {
        Chess.figuralar.forEach((key, value) {
          if (value[0] == '1' && (value[1] == 'F' || value[1] == 'G')) {
            result = true;
          }
        });
        if (result) return false;
        Chess.figuralarR.forEach((key, value) {
          if (value[0] == '1' && (value[1] == 'F' || value[1] == 'G')) {
            result = true;
          }
        });
        if (result) return false;
        Chess.figuralar[bizniFigura] = 'G11';
        Chess.figuralar["▓TO'RA2"] = 'F11';
        Display.updateSatr(8, 1, 6, 1);
        return true;
      }
    } else {
      if (Chess.figuralarR[bizniFigura] == 'E80' &&
          Chess.figuralarR["░TO'RA2"] == 'H80' &&
          y1 == 8 &&
          x1 == 'G') {
        Chess.figuralarR.forEach((key, value) {
          if (value[0] == '8' && (value[1] == 'F' || value[1] == 'G')) {
            result = true;
          }
        });
        if (result) return false;
        Chess.figuralar.forEach((key, value) {
          if (value[0] == '8' && (value[1] == 'F' || value[1] == 'G')) {
            result = true;
          }
        });
        if (result) return false;
        Chess.figuralarR[bizniFigura] = 'G81';
        Chess.figuralarR["░TO'RA2"] = 'F81';
        Display.updateSatr(8, 8, 6, 8);
        return true;
      }
    }
    x = Display.harfManzil(x);
    x1 = Display.harfManzil(x1);
    if (((x + 1 == x1 || x - 1 == x1) && (y == y1)) ||
        ((y + 1 == y1 || y - 1 == y1) && (x == x1)) ||
        (x - 1 == x1 && y - 1 == y1) ||
        (x + 1 == x1 && y + 1 == y1) ||
        (x + 1 == x1 && y - 1 == y1) ||
        (x - 1 == x1 && y + 1 == y1)) {
      if (bizniFigura[0] == '▓') {
        Chess.figuralar[bizniFigura] = xx + y1.toString() + '1';
        Chess.figuralarR.forEach((nomi, manzil) {
          if (manzil[0] == xx && manzil[1] == y1.toString()) {
            deleteFigura = nomi;
            result = true;
          }
        });
        if (result) {
          Chess.figuralarR.remove(deleteFigura);
        }
      } else {
        Chess.figuralarR[bizniFigura] = xx + y1.toString() + '1';
        Chess.figuralar.forEach((nomi, manzil) {
          if (manzil[0] == xx && manzil[1] == y1.toString()) {
            deleteFigura = nomi;
            result = true;
          }
        });
        if (result) {
          Chess.figuralar.remove(deleteFigura);
        }
      }
      return true;
    } else {
      return false;
    }
  }

  static bool ot(var x, int y, var x1, int y1) {
    // Bu funksiya otni yurish qilishini backend qismi
    String bizniFigura = nominiAniqla(x, y.toString());
    String deleteFigura = '';
    bool result = false;
    String xx = x1;
    x = Display.harfManzil(x);
    x1 = Display.harfManzil(x1);
    if ((x + 1 == x1 && y + 2 == y1) ||
        (x + 2 == x1 && y + 1 == y1) ||
        (x + 2 == x1 && y - 1 == y1) ||
        (x + 1 == x1 && y - 2 == y1) ||
        (x - 1 == x1 && y - 2 == y1) ||
        (x - 2 == x1 && y - 1 == y1) ||
        (x - 2 == x1 && y + 1 == y1) ||
        (x - 1 == x1 && y + 2 == y1)) {
      if (bizniFigura[0] == '▓') {
        Chess.figuralar[bizniFigura] = xx + y1.toString();
        Chess.figuralarR.forEach((nomi, manzil) {
          if (manzil[0] == xx && manzil[1] == y1.toString()) {
            deleteFigura = nomi;
            result = true;
          }
        });
        if (result) {
          Chess.figuralarR.remove(deleteFigura);
        }
      } else {
        Chess.figuralarR[bizniFigura] = xx + y1.toString();
        Chess.figuralar.forEach((nomi, manzil) {
          if (manzil[0] == xx && manzil[1] == y1.toString()) {
            deleteFigura = nomi;
            result = true;
          }
        });
        if (result) {
          Chess.figuralar.remove(deleteFigura);
        }
      }
      return true;
    } else {
      return false;
    }
  }

  static bool fil(var x, int y, var x1, int y1) {
    // Bu funksiya filni yurish qilishini backend qismi
    String bizniFigura = nominiAniqla(x, y.toString());
    x = Display.harfManzil(x);
    x1 = Display.harfManzil(x1);
    // pastda 4 ta while bilan 4 tomonga filni yurishi
    int xx = x;
    int yy = y;
    while (xx < x1 && yy < y1) {
      xx++;
      yy++;
      if (siklUchun(xx, yy, x1, y1, bizniFigura) && xx == x1 && yy == y1) {
        return true;
      }
      if (siklUchun(xx, yy, x1, y1, bizniFigura) == false) {
        return false;
      }
    }
    xx = x;
    yy = y;
    while (xx > x1 && yy > y1) {
      xx--;
      yy--;
      if (siklUchun(xx, yy, x1, y1, bizniFigura) && xx == x1 && yy == y1) {
        return true;
      }
      if (siklUchun(xx, yy, x1, y1, bizniFigura) == false) {
        return false;
      }
    }
    xx = x;
    yy = y;
    while (xx > x1 && yy < y1) {
      xx--;
      yy++;
      if (siklUchun(xx, yy, x1, y1, bizniFigura) && xx == x1 && yy == y1) {
        return true;
      }
      if (siklUchun(xx, yy, x1, y1, bizniFigura) == false) {
        return false;
      }
    }
    xx = x;
    yy = y;
    while (xx < x1 && yy > y1) {
      xx++;
      yy--;
      if (siklUchun(xx, yy, x1, y1, bizniFigura) && xx == x1 && yy == y1) {
        return true;
      }
      if (siklUchun(xx, yy, x1, y1, bizniFigura) == false) {
        return false;
      }
    }
    return false;
  }

  static bool tora(var x, int y, var x1, int y1) {
    // Bu funksiya to'rani yurish qilishini backend qismi
    String bizniFigura = nominiAniqla(x, y.toString());
    x = Display.harfManzil(x);
    x1 = Display.harfManzil(x1);
    int xx = x;
    int yy = y;
    // pastda 4 ta while bilan 4 tomonga to'rani yurishi
    while (xx < x1) {
      xx++;
      if (siklUchun(xx, yy, x1, y1, bizniFigura) && xx == x1 && yy == y1) {
        return true;
      }
      if (siklUchun(xx, yy, x1, y1, bizniFigura) == false) {
        return false;
      }
    }
    xx = x;
    yy = y;
    while (xx > x1) {
      xx--;
      if (siklUchun(xx, yy, x1, y1, bizniFigura) && xx == x1 && yy == y1) {
        return true;
      }
      if (siklUchun(xx, yy, x1, y1, bizniFigura) == false) {
        return false;
      }
    }
    xx = x;
    yy = y;
    while (yy > y1) {
      yy--;
      if (siklUchun(xx, yy, x1, y1, bizniFigura) && yy == y1 && xx == x1) {
        return true;
      }
      if (siklUchun(xx, yy, x1, y1, bizniFigura) == false) {
        return false;
      }
    }
    xx = x;
    yy = y;
    while (yy < y1) {
      yy++;
      if (siklUchun(xx, yy, x1, y1, bizniFigura) && yy == y1 && xx == x1) {
        return true;
      }
      if (siklUchun(xx, yy, x1, y1, bizniFigura) == false) {
        return false;
      }
    }
    return false;
  }

  static bool farzin(var x, int y, var x1, int y1) {
    // Bu funksiya farzinni yurish qilishini backend qismi
    // Yoki to'radek yoki fildek yursa true bo'lmasa false
    if (tora(x, y, x1, y1)) {
      return true;
    }
    if (fil(x, y, x1, y1)) {
      return true;
    }
    return false;
  }

  //------Shox berish funksiyalari----------
  static bool natijaShoh(var x, var y, var x1, var y1) {
    // Bu funksiya yurish qilishda figuraga mos funksiyalarga yo'naltiradi
    String figura = nominiAniqla(x, y);
    figura = figura.replaceRange(figura.length - 1, figura.length, '');
    y = y.toString().toInt;
    y1 = y1.toString().toInt;
    switch (figura) {
      case '▓SHOH':
      case '░SHOH':
        return shohShoh(x, y, x1, y1);
      case '▓FARZIN':
      case '░FARZIN':
        return farzinShoh(x, y, x1, y1);
      case '▓FIL':
      case '░FIL':
        return filShoh(x, y, x1, y1);
      case '▓OT':
      case '░OT':
        return otShoh(x, y, x1, y1);
      case "▓TO'RA":
      case "░TO'RA":
        return toraShoh(x, y, x1, y1);
      case '▓PIYODA':
      case '░PIYODA':
        return piyodaShoh(x, y, x1, y1);
      default:
        return false;
    }
  }

  static bool piyodaShoh(var x, int y, var x1, int y1) {
    // Bu funksiya piyodani yurish qilishini backend qismi
    if (((Display.harfManzil(x1) - 1) == Display.harfManzil(x)) &&
        (y + 1 == y1)) {
      return true;
    }
    return false;
  }

  static bool shohShoh(var x, int y, var x1, int y1) {
    // Bu funksiya shohni yurish qilishini backend qismi
    x = Display.harfManzil(x);
    x1 = Display.harfManzil(x1);
    if (((x + 1 == x1 || x - 1 == x1) && (y == y1)) ||
        ((y + 1 == y1 || y - 1 == y1) && (x == x1)) ||
        (x - 1 == x1 && y - 1 == y1) ||
        (x + 1 == x1 && y + 1 == y1) ||
        (x + 1 == x1 && y - 1 == y1) ||
        (x - 1 == x1 && y + 1 == y1)) {
      return true;
    } else {
      return false;
    }
  }

  static bool otShoh(var x, int y, var x1, int y1) {
    // Bu funksiya otni yurish qilishini backend qismi
    x = Display.harfManzil(x);
    x1 = Display.harfManzil(x1);
    if ((x + 1 == x1 && y + 2 == y1) ||
        (x + 2 == x1 && y + 1 == y1) ||
        (x + 2 == x1 && y - 1 == y1) ||
        (x + 1 == x1 && y - 2 == y1) ||
        (x - 1 == x1 && y - 2 == y1) ||
        (x - 2 == x1 && y - 1 == y1) ||
        (x - 2 == x1 && y + 1 == y1) ||
        (x - 1 == x1 && y + 2 == y1)) {
      return true;
    } else {
      return false;
    }
  }

  static bool filShoh(var x, int y, var x1, int y1) {
    // Bu funksiya filni yurish qilishini backend qismi
    x = Display.harfManzil(x);
    x1 = Display.harfManzil(x1);
    // pastda 4 ta while bilan 4 tomonga filni yurishi
    int xx = x;
    int yy = y;
    while (xx < x1 && yy < y1) {
      xx++;
      yy++;
      if (siklUchunShoh(xx, yy, x1, y1) && xx == x1 && yy == y1) {
        return true;
      }
      if (siklUchunShoh(xx, yy, x1, y1) == false) {
        return false;
      }
    }
    xx = x;
    yy = y;
    while (xx > x1 && yy > y1) {
      xx--;
      yy--;
      if (siklUchunShoh(xx, yy, x1, y1) && xx == x1 && yy == y1) {
        return true;
      }
      if (siklUchunShoh(xx, yy, x1, y1) == false) {
        return false;
      }
    }
    xx = x;
    yy = y;
    while (xx > x1 && yy < y1) {
      xx--;
      yy++;
      if (siklUchunShoh(xx, yy, x1, y1) && xx == x1 && yy == y1) {
        return true;
      }
      if (siklUchunShoh(xx, yy, x1, y1) == false) {
        return false;
      }
    }
    xx = x;
    yy = y;
    while (xx < x1 && yy > y1) {
      xx++;
      yy--;
      if (siklUchunShoh(xx, yy, x1, y1) && xx == x1 && yy == y1) {
        return true;
      }
      if (siklUchunShoh(xx, yy, x1, y1) == false) {
        return false;
      }
    }
    return false;
  }

  static bool toraShoh(var x, int y, var x1, int y1) {
    // Bu funksiya to'rani yurish qilishini backend qismi
    x = Display.harfManzil(x);
    x1 = Display.harfManzil(x1);
    int xx = x;
    int yy = y;
    // pastda 4 ta while bilan 4 tomonga to'rani yurishi
    while (xx < x1) {
      xx++;
      if (siklUchunShoh(xx, yy, x1, y1) && xx == x1 && yy == y1) {
        return true;
      }
      if (siklUchunShoh(xx, yy, x1, y1) == false) {
        return false;
      }
    }
    xx = x;
    yy = y;
    while (xx > x1) {
      xx--;
      if (siklUchunShoh(xx, yy, x1, y1) && xx == x1 && yy == y1) {
        return true;
      }
      if (siklUchunShoh(xx, yy, x1, y1) == false) {
        return false;
      }
    }
    xx = x;
    yy = y;
    while (yy > y1) {
      yy--;
      if (siklUchunShoh(xx, yy, x1, y1) && yy == y1 && xx == x1) {
        return true;
      }
      if (siklUchunShoh(xx, yy, x1, y1) == false) {
        return false;
      }
    }
    xx = x;
    yy = y;
    while (yy < y1) {
      yy++;
      if (siklUchunShoh(xx, yy, x1, y1) && yy == y1 && xx == x1) {
        return true;
      }
      if (siklUchunShoh(xx, yy, x1, y1) == false) {
        return false;
      }
    }
    return false;
  }

  static bool farzinShoh(var x, int y, var x1, int y1) {
    // Bu funksiya farzinni yurish qilishini backend qismi
    // Yoki to'radek yoki fildek yursa true bo'lmasa false
    if (toraShoh(x, y, x1, y1)) {
      return true;
    }
    if (filShoh(x, y, x1, y1)) {
      return true;
    }
    return false;
  }

  static bool siklUchunShoh(int xx, int yy, int x1, int y1) {
    // Bu siklda figura 4 tarafga yurishi jarayonida siklga 4 marta bitta kod yozmaslik uchun
    if (xx == x1 && yy == y1) {
      // Agar manzilga yetib borsa true qaytadi
      return true;
    }
    // Agar manzilga yetib bormagan bo'lsa
    if (nominiAniqla(raqamToHarf(xx), yy.toString()) == 'no') {
      return true; // Agar yo'lda figura bo'lmasa true qaytaradi
    } else {
      return false; // Agar bo'lsa false qaytaradi
    }
  }

  static bool shohBerdi() {
    // true shox berdi
    // false oddiy yurish
    bool result = false;
    if (Chess.navbat) {
      Chess.figuralar.forEach((key, value) {
        String addressKing = Chess.figuralarR['░SHOH1'].toString();
        if (natijaShoh(value[0], value[1], addressKing[0], addressKing[1])) {
          result = true;
        }
      });
      if (result == true) {
        return true;
      }
    } else {
      Chess.figuralarR.forEach((key, value) {
        String addressKing = Chess.figuralar['▓SHOH1'].toString();
        if (natijaShoh(value[0], value[1], addressKing[0], addressKing[1])) {
          result = true;
        }
      });
      if (result == true) {
        return true;
      }
    }
    return false;
  }
}
