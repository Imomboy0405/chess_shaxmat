import 'dart:convert';
import 'dart:io';

class DataService {
  Directory directory = Directory(Directory.current.path + '\\assets\\store');

  Future<void> initDirectory() async {
    Directory directory = Directory(Directory.current.path + '\\assets');
    bool isDirectoryCreated = await directory.exists();
    if (isDirectoryCreated == false) {
      await directory.create();
    }

    directory = Directory(Directory.current.path + '\\assets\\files');
    isDirectoryCreated = await directory.exists();
    if (isDirectoryCreated == false) {
      await directory.create();
    }

    isDirectoryCreated = await this.directory.exists();
    if (isDirectoryCreated == false) {
      await this.directory.create();
    }
  }

  Future<void> initData() async {
    File file = File(directory.path + '\\data.json');
    bool isFileCreated = await file.exists();
    if (isFileCreated == false) {
      await file.create();
      await file.writeAsString("{}");
    } else {
      String s = await file.readAsString();
      if (s.isEmpty) {
        await file.writeAsString("{}");
      }
    }
  }

  Future<void> writeData(String key, dynamic value) async {
    File file = File(directory.path + "\\data.json");
    Map<String, dynamic> map = {};
    map = jsonDecode(await file.readAsString());
    map.addAll({key: value});
    String source = jsonEncode(map);
    await file.writeAsString(source);
  }

  Future<String?> readData(String key) async {
    File file = File(directory.path + '\\data.json');
    Map<String, dynamic> map = jsonDecode(await file.readAsString());
    if (map.containsKey(key)) {
      return map[key].toString();
    } else {
      return null;
    }
  }
}
