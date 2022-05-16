import 'package:chess_shaxmat/menu/global_menu.dart';
import 'package:chess_shaxmat/menu/home_menu.dart';
import 'package:chess_shaxmat/menu/lang_settings_menu.dart';
import 'package:chess_shaxmat/menu/local_menu.dart';
import 'package:chess_shaxmat/menu/name_settings_menu.dart';
import 'package:chess_shaxmat/menu/play_type_menu.dart';
import 'package:chess_shaxmat/menu/saved_games_menu.dart';
import 'package:chess_shaxmat/menu/settings_menu.dart';
import 'package:chess_shaxmat/menu/theme_settings_menu.dart';
import 'package:chess_shaxmat/services/chess_service.dart';
import 'package:chess_shaxmat/services/color_service.dart';
import 'package:chess_shaxmat/services/lang_services.dart';

void main() async {
  ansiColorDisabled = false;
  MyApp(
    home: HomeMenu(),
    locale: await LangService.currentLanguage(),
    routes: {
      HomeMenu.id: HomeMenu(),
      GlobalMenu.id: GlobalMenu(),
      LocalMenu.id: LocalMenu(),
      SettingsMenu.id: SettingsMenu(),
      ThemeSettings.id: ThemeSettings(),
      NameSettings.id: NameSettings(),
      LangSettings.id: LangSettings(),
      PlayMenu.id: PlayMenu(),
      SavedGames.id: SavedGames(),
    },
  );
}
