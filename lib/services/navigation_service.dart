import 'chess_service.dart';
import '../models/menu_model.dart';

class Navigator {
  static final List<Menu> _list = <Menu>[];

  static set initialValue(Menu menu) {
    _list.add(menu);
  }

  static Future _runMenu() async {
    await _list.last.build();
  }

  static Menu? _findMenu(String id) {
    return MyApp.routeMenu[id];
  }

  static Future push(Menu menu) async {
    _list.add(menu);
    await _runMenu();
  }

  static Future<void> pushNamed(String id) async{
    Menu menu = _findMenu(id)!;
    await push(menu);
  }

  static Future<void> pushReplacement(Menu menu) async {
    _list.removeLast();
    _list.add(menu);
    await _runMenu();
  }

  static Future<void> pushReplacementNamed(String id) async{
    Menu menu = _findMenu(id)!;
    await pushReplacement(menu);
  }

  static Future<String?> pop({String? message}) async  {
    _list.removeLast();
    await _runMenu();
    return message;
  }

  static Future<String?> popUntil({String? message}) async {
    _list.removeRange(1, _list.length);
    await _runMenu();
    return message;
  }
}
