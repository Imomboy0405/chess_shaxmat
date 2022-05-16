class Chess {
  static late String name;
  static late List theme;
  static bool navbat = true;
  static Map<String, dynamic> figuralarR = {
    '░PIYODA1': 'A70',
    '░PIYODA2': 'B70',
    '░PIYODA3': 'C70',
    '░PIYODA4': 'D70',
    '░PIYODA5': 'E70',
    '░PIYODA6': 'F70',
    '░PIYODA7': 'G70',
    '░PIYODA8': 'H70',
    '░FARZIN1': 'D8',
    '░SHOH1': 'E80',
    "░TO'RA1": 'A80',
    "░TO'RA2": 'H80',
    '░FIL1': 'C8',
    '░FIL2': 'F8',
    '░OT1': 'B8',
    '░OT2': 'G8',
  }; // Qora figuralar nomlari va katak manzili

  static Map<String, dynamic> figuralar = {
    '▓PIYODA1': 'A20',
    '▓PIYODA2': 'B20',
    '▓PIYODA3': 'C20',
    '▓PIYODA4': 'D20',
    '▓PIYODA5': 'E20',
    '▓PIYODA6': 'F20',
    '▓PIYODA7': 'G20',
    '▓PIYODA8': 'H20',
    '▓FARZIN1': 'D1',
    '▓SHOH1': 'E10',
    "▓TO'RA1": 'A10',
    "▓TO'RA2": 'H10',
    '▓FIL1': 'C1',
    '▓FIL2': 'F1',
    '▓OT1': 'B1',
    '▓OT2': 'G1',
  }; // Oq figuralar nomlari va katak manzili

  Chess();

  static void newGameUpdateData() {
    navbat = true;
    figuralar.addAll( {
      '▓PIYODA1': 'A20',
      '▓PIYODA2': 'B20',
      '▓PIYODA3': 'C20',
      '▓PIYODA4': 'D20',
      '▓PIYODA5': 'E20',
      '▓PIYODA6': 'F20',
      '▓PIYODA7': 'G20',
      '▓PIYODA8': 'H20',
      '▓FARZIN1': 'D1',
      '▓SHOH1': 'E10',
      "▓TO'RA1": 'A10',
      "▓TO'RA2": 'H10',
      '▓FIL1': 'C1',
      '▓FIL2': 'F1',
      '▓OT1': 'B1',
      '▓OT2': 'G1',
    });
    figuralarR.addAll({
      '░PIYODA1': 'A70',
      '░PIYODA2': 'B70',
      '░PIYODA3': 'C70',
      '░PIYODA4': 'D70',
      '░PIYODA5': 'E70',
      '░PIYODA6': 'F70',
      '░PIYODA7': 'G70',
      '░PIYODA8': 'H70',
      '░FARZIN1': 'D8',
      '░SHOH1': 'E80',
      "░TO'RA1": 'A80',
      "░TO'RA2": 'H80',
      '░FIL1': 'C8',
      '░FIL2': 'F8',
      '░OT1': 'B8',
      '░OT2': 'G8',
    });
  }
}
