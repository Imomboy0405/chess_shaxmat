import 'package:chess_shaxmat/models/chess_model.dart';
import 'package:chess_shaxmat/services/attack_service.dart';
import 'package:chess_shaxmat/services/io_service.dart';

late int oq, qora;

class Display {
  static List<String> sBegin = [
    '',
    colorB('║8│'),
    colorB('║7▐'),
    colorB('║6│'),
    colorB('║5▐'),
    colorB('║4│'),
    colorB('║3▐'),
    colorB('║2│'),
    colorB("║1▐"),
  ];
  static List<String> sEnd = [
    '',
    colorB('▌8║'),
    colorB('│7║'),
    colorB('▌6║'),
    colorB('│5║'),
    colorB('▌4║'),
    colorB('│3║'),
    colorB('▌2║'),
    colorB("│1║"),
  ];
  static List<String> sBeginBlack = [
    '',
    colorB('║1▐'),
    colorB('║2│'),
    colorB('║3▐'),
    colorB('║4│'),
    colorB('║5▐'),
    colorB('║6│'),
    colorB('║7▐'),
    colorB("║8│"),
  ];
  static List<String> sEndBlack = [
    '',
    colorB('│1║'),
    colorB('▌2║'),
    colorB('│3║'),
    colorB('▌4║'),
    colorB('│5║'),
    colorB('▌6║'),
    colorB('│7║'),
    colorB("▌8║"),
  ];
  static List<List<String>> satrS = [
    [],
    [
      '',
      colorB("│-TO'RA-│"),
      colorB("│---OT--│"),
      colorB("│--FIL--│"),
      colorB('│-FARZIN│'),
      colorB("│--SHOH-│"),
      colorB("│--FIL--│"),
      colorB("│---OT--│"),
      colorB("│-TO'RA-│")
    ],
    [
      '',
      colorB("│-PIYODA│"),
      colorB("│-PIYODA│"),
      colorB("│-PIYODA│"),
      colorB('│-PIYODA│'),
      colorB("│-PIYODA│"),
      colorB("│-PIYODA│"),
      colorB("│-PIYODA│"),
      colorB("│-PIYODA│")
    ],
    [
      '',
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         ')
    ],
    [
      '',
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         ')
    ],
    [
      '',
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         ')
    ],
    [
      '',
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         ')
    ],
    [
      '',
      colorW("│-PIYODA│"),
      colorW("│-PIYODA│"),
      colorW("│-PIYODA│"),
      colorW("│-PIYODA│"),
      colorW("│-PIYODA│"),
      colorW("│-PIYODA│"),
      colorW("│-PIYODA│"),
      colorW("│-PIYODA│")
    ],
    [
      '',
      colorW("│-TO'RA-│"),
      colorW("│---OT--│"),
      colorW("│--FIL--│"),
      colorW("│-FARZIN│"),
      colorW("│--SHOH-│"),
      colorW("│--FIL--│"),
      colorW("│---OT--│"),
      colorW("│-TO'RA-│")
    ],
  ];

  static List<List<String>> satrSBlack = [
    [],
    [
      '',
      colorW("│-TO'RA-│"),
      colorW("│---OT--│"),
      colorW("│--FIL--│"),
      colorW("│--SHOH-│"),
      colorW("│-FARZIN│"),
      colorW("│--FIL--│"),
      colorW("│---OT--│"),
      colorW("│-TO'RA-│")
    ],
    [
      '',
      colorW("│-PIYODA│"),
      colorW("│-PIYODA│"),
      colorW("│-PIYODA│"),
      colorW("│-PIYODA│"),
      colorW("│-PIYODA│"),
      colorW("│-PIYODA│"),
      colorW("│-PIYODA│"),
      colorW("│-PIYODA│")
    ],
    [
      '',
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         ')
    ],
    [
      '',
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         ')
    ],
    [
      '',
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         ')
    ],
    [
      '',
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         '),
      colorW('         '),
      colorB('         ')
    ],
    [
      '',
      colorB("│-PIYODA│"),
      colorB("│-PIYODA│"),
      colorB("│-PIYODA│"),
      colorB('│-PIYODA│'),
      colorB("│-PIYODA│"),
      colorB("│-PIYODA│"),
      colorB("│-PIYODA│"),
      colorB("│-PIYODA│")
    ],
    [
      '',
      colorB("│-TO'RA-│"),
      colorB("│---OT--│"),
      colorB("│--FIL--│"),
      colorB('│--SHOH-│'),
      colorB("│-FARZIN│"),
      colorB("│--FIL--│"),
      colorB("│---OT--│"),
      colorB("│-TO'RA-│")
    ],
  ];

  Display();

  //color_print uchun funksiya
  static String colorW(String text) {
    return printIsColor(text: text, penColor: qora, bgColor: oq);
  }

  static String colorB(String text) {
    return printIsColor(text: text, penColor: oq, bgColor: qora);
  }

  static void colorUpChess() {
    writeln(colorB(
        '╔════════════════════════════════════════════════════════════════════════════╗'));
    writeln(colorB(
        '║№│▐■■[A]■■▌▐■■[B]■■▌▐■■[C]■■▌▐■■[D]■■▌▐■■[E]■■▌▐■■[F]■■▌▐■■[G]■■▌▐■■[H]■■▌│№║'));
  }

  static void colorDownChess() {
    writeln(colorB(
        '║№│▐■■[A]■■▌▐■■[B]■■▌▐■■[C]■■▌▐■■[D]■■▌▐■■[E]■■▌▐■■[F]■■▌▐■■[G]■■▌▐■■[H]■■▌│№║'));
    writeln(colorB(
        '╚════════════════════════════════════════════════════════════════════════════╝'));
  }

  static void colorUpChessBlack() {
    writeln(colorB(
        '╔════════════════════════════════════════════════════════════════════════════╗'));
    writeln(colorB(
        '║№│▐■■[H]■■▌▐■■[G]■■▌▐■■[F]■■▌▐■■[E]■■▌▐■■[D]■■▌▐■■[C]■■▌▐■■[B]■■▌▐■■[A]■■▌│№║'));
  }

  static void colorDownChessBlack() {
    writeln(colorB(
        '║№│▐■■[H]■■▌▐■■[G]■■▌▐■■[F]■■▌▐■■[E]■■▌▐■■[D]■■▌▐■■[C]■■▌▐■■[B]■■▌▐■■[A]■■▌│№║'));
    writeln(colorB(
        '╚════════════════════════════════════════════════════════════════════════════╝'));
  }

  // -----Namoyish funksiyalari-----
  static void newGameUpdates() {
    Chess.newGameUpdateData();
    satrS.clear();
    satrS = [
      [],
      [
        '',
        colorB("│-TO'RA-│"),
        colorB("│---OT--│"),
        colorB("│--FIL--│"),
        colorB('│-FARZIN│'),
        colorB("│--SHOH-│"),
        colorB("│--FIL--│"),
        colorB("│---OT--│"),
        colorB("│-TO'RA-│")
      ],
      [
        '',
        colorB("│-PIYODA│"),
        colorB("│-PIYODA│"),
        colorB("│-PIYODA│"),
        colorB('│-PIYODA│'),
        colorB("│-PIYODA│"),
        colorB("│-PIYODA│"),
        colorB("│-PIYODA│"),
        colorB("│-PIYODA│")
      ],
      [
        '',
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         ')
      ],
      [
        '',
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         ')
      ],
      [
        '',
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         ')
      ],
      [
        '',
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         ')
      ],
      [
        '',
        colorW("│-PIYODA│"),
        colorW("│-PIYODA│"),
        colorW("│-PIYODA│"),
        colorW("│-PIYODA│"),
        colorW("│-PIYODA│"),
        colorW("│-PIYODA│"),
        colorW("│-PIYODA│"),
        colorW("│-PIYODA│")
      ],
      [
        '',
        colorW("│-TO'RA-│"),
        colorW("│---OT--│"),
        colorW("│--FIL--│"),
        colorW("│-FARZIN│"),
        colorW("│--SHOH-│"),
        colorW("│--FIL--│"),
        colorW("│---OT--│"),
        colorW("│-TO'RA-│")
      ],
    ];
    satrSBlack.clear();
    satrSBlack = [
      [],
      [
        '',
        colorW("│-TO'RA-│"),
        colorW("│---OT--│"),
        colorW("│--FIL--│"),
        colorW("│--SHOH-│"),
        colorW("│-FARZIN│"),
        colorW("│--FIL--│"),
        colorW("│---OT--│"),
        colorW("│-TO'RA-│")
      ],
      [
        '',
        colorW("│-PIYODA│"),
        colorW("│-PIYODA│"),
        colorW("│-PIYODA│"),
        colorW("│-PIYODA│"),
        colorW("│-PIYODA│"),
        colorW("│-PIYODA│"),
        colorW("│-PIYODA│"),
        colorW("│-PIYODA│")
      ],
      [
        '',
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         ')
      ],
      [
        '',
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         ')
      ],
      [
        '',
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         ')
      ],
      [
        '',
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         ')
      ],
      [
        '',
        colorB("│-PIYODA│"),
        colorB("│-PIYODA│"),
        colorB("│-PIYODA│"),
        colorB('│-PIYODA│'),
        colorB("│-PIYODA│"),
        colorB("│-PIYODA│"),
        colorB("│-PIYODA│"),
        colorB("│-PIYODA│")
      ],
      [
        '',
        colorB("│-TO'RA-│"),
        colorB("│---OT--│"),
        colorB("│--FIL--│"),
        colorB('│--SHOH-│'),
        colorB("│-FARZIN│"),
        colorB("│--FIL--│"),
        colorB("│---OT--│"),
        colorB("│-TO'RA-│")
      ],
    ];
  }

  static void oldGameUpdateDoska() {
    satrS.clear();
    satrS = [
      [],
      [
        '',
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         ')
      ],
      [
        '',
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         ')
      ],
      [
        '',
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         ')
      ],
      [
        '',
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         ')
      ],
      [
        '',
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         ')
      ],
      [
        '',
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         ')
      ],
      [
        '',
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         ')
      ],
      [
        '',
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         '),
        colorB('         '),
        colorW('         ')
      ],
    ];
    Chess.figuralar.forEach((key, value) {
      satrS[raqamManzil(int.parse(value[1]))][harfManzil(value[0])] =
          figuraDizayn(key.replaceRange(key.length - 1, key.length, ''));
    });
    Chess.figuralarR.forEach((key, value) {
      satrS[raqamManzil(int.parse(value[1]))][harfManzil(value[0])] =
          figuraDizayn(key.replaceRange(key.length - 1, key.length, ''));
    });
    updateDoska(null, null, null, null);
  }

  static void updateDoska(int? x, int? y, int? x1, int? y1) {
    // Bu funksiya yurishdan keyingi doskani chop etadi
    if (x != null) {
      updateSatr(x, y!, x1!, y1!);
    }
    String s1 = "${colorB('║ │')}"
        '${colorW('         ')}'
        '${colorB('         ')}'
        '${colorW('         ')}'
        '${colorB('         ')}'
        '${colorW('         ')}'
        '${colorB('         ')}'
        '${colorW('         ')}'
        '${colorB('         ')}'
        "${colorB('▌ ║')}";
    String s2 = "${colorB('║ ▐')}"
        '${colorB('         ')}'
        '${colorW('         ')}'
        '${colorB('         ')}'
        '${colorW('         ')}'
        '${colorB('         ')}'
        '${colorW('         ')}'
        '${colorB('         ')}'
        '${colorW('         ')}'
        "${colorB('│ ║')}";

    print('');
    print(printIsColor(
        text:
            '==============================================================================',
        penColor: 46,
        bgColor: 21));
    print('');
    colorUpChess();
    for (int i = 1; i <= 8; i++) {
      if (i % 2 == 1) {
        print(s1);
        write(sBegin[i]);
        for (int j = 1; j <= 8; j++) {
          write(satrS[i][j]);
        }
        writeln(sEnd[i]);
        print(s1);
      } else {
        print(s2);
        write(sBegin[i]);
        for (int j = 1; j <= 8; j++) {
          write(satrS[i][j]);
        }
        writeln(sEnd[i]);
        print(s2);
      }
    }
    colorDownChess();
  }

  static void updateDoskaBlack(int? x, int? y, int? x1, int? y1) {
    // Bu funksiya yurishdan keyingi doskani chop etadi
    if (x != null) {
      updateSatrBlack(x, y!, x1!, y1!);
    }
    String s2 = "${colorB('║ │')}"
        '${colorW('         ')}'
        '${colorB('         ')}'
        '${colorW('         ')}'
        '${colorB('         ')}'
        '${colorW('         ')}'
        '${colorB('         ')}'
        '${colorW('         ')}'
        '${colorB('         ')}'
        "${colorB('▌ ║')}";
    String s1 = "${colorB('║ ▐')}"
        '${colorB('         ')}'
        '${colorW('         ')}'
        '${colorB('         ')}'
        '${colorW('         ')}'
        '${colorB('         ')}'
        '${colorW('         ')}'
        '${colorB('         ')}'
        '${colorW('         ')}'
        "${colorB('│ ║')}";

    print('');
    print(printIsColor(
        text:
            '==============================================================================',
        penColor: 46,
        bgColor: 21));
    print('');
    colorUpChessBlack();
    for (int i = 1; i <= 8; i++) {
      if (i % 2 == 1) {
        print(s1);
        write(sBeginBlack[i]);
        for (int j = 1; j <= 8; j++) {
          write(satrSBlack[i][j]);
        }
        writeln(sEndBlack[i]);
        print(s1);
      } else {
        print(s2);
        write(sBeginBlack[i]);
        for (int j = 1; j <= 8; j++) {
          write(satrSBlack[i][j]);
        }
        writeln(sEndBlack[i]);
        print(s2);
      }
    }
    colorDownChessBlack();
  }

  static void updateSatr(int x, int y, int x1, int y1) {
    // Bu funksiya yurishdan so'ng doska uchun chop etuvchi satrni yangilaydi
    y = raqamManzil(y);
    y1 = raqamManzil(y1);
    String nom =
        Attack.nominiAniqla(Attack.raqamToHarf(x1), raqamManzil(y1).toString());
    nom = nom.replaceRange(nom.length - 1, nom.length, '');
    if (y % 2 == 1) {
      if (x % 2 == 1) {
        satrS[y][x] = colorW('         ');
      } else {
        satrS[y][x] = colorB('         ');
      }
    } else {
      if (x % 2 == 0) {
        satrS[y][x] = colorW('         ');
      } else {
        satrS[y][x] = colorB('         ');
      }
    }
    satrS[y1][x1] = figuraDizayn(nom);
  }

  static void updateSatrBlack(int x, int y, int x1, int y1) {
    // Bu funksiya yurishdan so'ng doska uchun chop etuvchi satrni yangilaydi
    print(Attack.raqamToHarf(x1) + ':' + y1.toString());
    String nom = Attack.nominiAniqla(Attack.raqamToHarf(x1), y1.toString());
    nom = nom.replaceRange(nom.length - 1, nom.length, '');
    x = raqamManzil(x);
    x1 = raqamManzil(x1);
    if (y % 2 == 1) {
      if (x % 2 == 1) {
        satrSBlack[y][x] = colorB('         ');
      } else {
        satrSBlack[y][x] = colorW('         ');
      }
    } else {
      if (x % 2 == 0) {
        satrSBlack[y][x] = colorB('         ');
      } else {
        satrSBlack[y][x] = colorW('         ');
      }
    }
    print('--:$x $y');
    print('----------:$x1 $y1');
    satrSBlack[y1][x1] = figuraDizayn(nom);
  }

  static String figuraDizayn(String figura) {
    // Bu funksiya doskaga chop qilish uchun figura katagi uchun satr qaytaradi
    switch (figura) {
      case '▓FARZIN':
        return colorW('│-FARZIN│');
      case '▓OT':
        return colorW('│---OT--│');
      case '▓SHOH':
        return colorW('│--SHOH-│');
      case '▓FIL':
        return colorW('│--FIL--│');
      case '▓PIYODA':
        return colorW('│-PIYODA│');
      case "▓TO'RA":
        return colorW("│-TO'RA-│");
      case '░FARZIN':
        return colorB('│-FARZIN│');
      case '░OT':
        return colorB('│---OT--│');
      case '░SHOH':
        return colorB('│--SHOH-│');
      case '░FIL':
        return colorB('│--FIL--│');
      case '░PIYODA':
        return colorB('│-PIYODA│');
      case "░TO'RA":
        return colorB("│-TO'RA-│");
      default:
        return '│Xatolik│';
    }
  }

  // -----Kiritish test funksiyalari------
  static bool katakManzil(String katak) {
    // Bu funksiya katak manzili to'g'ri ekanligini tekshiradi
    if (katak.length != 2) {
      return false;
    }
    switch (katak[0]) {
      case 'A':
      case 'B':
      case 'C':
      case 'D':
      case 'E':
      case 'F':
      case 'G':
      case 'H':
        break;
      default:
        return false;
    }
    switch (katak[1]) {
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
        return true;
      default:
        return false;
    }
  }

  static int harfManzil(String katak) {
    // Bu funksiya katak harfiga mos raqam qaytaradi
    switch (katak) {
      case 'A':
        return 1;
      case 'B':
        return 2;
      case 'C':
        return 3;
      case 'D':
        return 4;
      case 'E':
        return 5;
      case 'F':
        return 6;
      case 'G':
        return 7;
      case 'H':
        return 8;
      default:
        return 0;
    }
  }

  static int raqamManzil(int y) {
    // Bu funksiya chop etish doskasi raqamlari teskari bo'lgani uchun
    // shunga mos teskari raqam qaytaradi
    switch (y) {
      case 1:
        return 8;
      case 2:
        return 7;
      case 3:
        return 6;
      case 4:
        return 5;
      case 5:
        return 4;
      case 6:
        return 3;
      case 7:
        return 2;
      case 8:
        return 1;
      default:
        return 0;
    }
  }

  static bool katakOqlardami(String katak) {
    // Bu funksiya katakda oq figura turganligini aniqlab beradi
    bool result = false;
    Chess.figuralar.forEach((nomi, manzil) {
      if (manzil[0] == katak[0] && manzil[1] == katak[1]) {
        result = true;
      }
    });
    return result;
  }

  static bool katakQoralardami(String katak) {
    // Bu funksiya katakda qora figura turganligini aniqlab beradi
    bool result = false;
    Chess.figuralarR.forEach((nomi, manzil) {
      if (manzil[0] == katak[0] && manzil[1] == katak[1]) {
        result = true;
      }
    });
    return result;
  }
}
