import 'dart:io';

mixin FileService {
  static Directory directory =
      Directory(Directory.current.path + '\\assets\\files');

  static Future<bool> initFile(String fileName) async {
    return await File(directory.path + '\\' + fileName + '.json').exists();
  }

  static Future<bool> createFile(String fileName) async {
    if (await initFile(fileName)) {
      return false;
    }
    await File(directory.path + '\\' + fileName + '.json').create();
    return true;
  }

  static Future<bool> deleteFile(String fileName) async {
    if (await initFile(fileName)) {
      await File(directory.path + '\\' + fileName + '.json').delete();
      return true;
    }
    return false;
  }

  Future<void> deleteFileFromPath(String path) async {
    File file = File(path);
    await file.delete();
  }

  static Future<void> deleteAllFile() async {
    List<FileSystemEntity> list = directory.listSync();
    for (var item in list) {
      await item.delete();
    }
  }

  static Future<String> readFile(String fileName) async {
    if (await initFile(fileName)) {
      File file = File(directory.path + '\\' + fileName + '.json');
      return await file.readAsString();
    }
    return '';
  }

  static Future<List<FileSystemEntity>> viewAllFiles() async {
    List<FileSystemEntity> list = directory.listSync();
    return list;
  }

  static Future<bool> reWriteFile(String fileName, String text) async {
    if (await initFile(fileName)) {
      await File(directory.path + '\\' + fileName + '.json')
          .writeAsString(text);
      return true;
    }
    return false;
  } //map uchun

  static Future<String> writeFile(String fileName, String text) async {
    File file = File(directory.path + '\\' + fileName + '.txt');
    if (!(await file.exists())) {
      await file.create();
    }
    String oldText = await file.readAsString();
    if (text.isNotEmpty) {
      text = oldText + '\n' + text;
      await file.writeAsString(text);
      return text;
    } else {
      return oldText;
    }
  } //yurishlar uchun
}
