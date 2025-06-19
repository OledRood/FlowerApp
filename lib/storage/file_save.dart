import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String?> savePhoto({required File photo, required String name}) async {
  // try {
  //   final directory = await ;
  //
  //   // Создаем уникальное имя файла, чтобы избежать перезаписи
  //   final fileName = 'flower_photo_$name.jpg';
  //   final savedFile = File('${directory.path}/$fileName');
  //
  //   // Копируем файл в новое место
  //   await photo.copy(savedFile.path);
  //
  //   return savedFile.path;
  // } catch (e) {
  //   print("Ошибка сохранения фото: $e");
  //   return null;
  // }

  final docsPath = await getApplicationDocumentsDirectory();
  final imageName = photo.path.split(Platform.pathSeparator).last;
  final photosPath =
      '${docsPath.absolute.path}${Platform.pathSeparator}photoes';
  await Directory(photosPath).create();
  final fullImagePath = '$photosPath${Platform.pathSeparator}$imageName';
  await photo.copy(fullImagePath);
  print("Сохранен по пути: $fullImagePath");

  return fullImagePath;
}
