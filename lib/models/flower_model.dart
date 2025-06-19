import 'dart:io';

import 'package:flowers_app/models/convert_watering_date.dart';
import 'package:flowers_app/models/declension_date_word.dart';

class Flower {
  final String id;
  final String name;
  final String plantDate;
  final String description;
  final List<DateTime> wateringDates;

  // final File photo;
  final String photoPath;

  Flower({
    required this.name,
    required this.plantDate,
    // required this.wateringDate,
    // required this.photo,
    required this.photoPath,
    required this.id,
    required this.wateringDates,
    required this.description,
  });

  // Преобразование объекта User в Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      "name": name,
      "plantDate": plantDate,
      "photoPath": photoPath,
      "description": description,
      "wateringDates": ConvertWateringDate.wateringDatesToString(wateringDates),
    };
  }

  String get flowerAge {
    List<int> plantDateList =
        plantDate.substring(0, 10).split('-').map(int.parse).toList();
    DateTime today = DateTime.now();
    DateTime plantDateTime =
        DateTime(plantDateList[0], plantDateList[1], plantDateList[2]);

    if (today.isBefore(plantDateTime)) {
      return 'Не взошел';
    }

    Duration difference = today.difference(plantDateTime);
    int years = difference.inDays ~/ 365;
    int months = (difference.inDays % 365) ~/ 30;
    int days = (difference.inDays % 365) % 30;

    if (days == 1 && months == 0 && years == 0) {
      return 'Один день!';
    } else if (days == 15 && months == 0 && years == 0) {
      return "Полмесяца!";
    } else if (days == 0 && months == 1 && years == 0) {
      return "Ровно месяц!";
    } else if (days < 5 && months == 6 && years == 0) {
      return "Полгода!";
    } else if (days < 5 && months == 0 && years == 1) {
      return "Целый год";
    } else if (days < 5 && months == 6 && years == 1) {
      return "Полтора года!";
    } else if (days < 5 && months == 0 && years == 2) {
      return "Два года!";
    } else if (days < 5 && months == 0 && years == 3) {
      return "Три года!";
    } else if (days == 0 && months == 0 && years == 5) {
      return "Первый юбилей!";
    } else if (months < 2 && years == 0) {

      return DeclensionDateWord.daysName(days);
    } else if (months >= 2 && years == 0) {
      return DeclensionDateWord.monthName(months);
    } else if (years != 0) {
      return "${DeclensionDateWord.monthName(months)}, ${DeclensionDateWord.yearName(years)}";
    }
    return '${DeclensionDateWord.daysName(days)}, ${DeclensionDateWord.monthName(months)}, ${DeclensionDateWord.yearName(years)}';
  }


bool get isWateringToday{
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);

    final normalizedWateringDates = wateringDates.map((date) {
      return DateTime(date.year, date.month, date.day);
    }).toList();

    // Проверяем, содержится ли сегодняшняя дата в списке
    return normalizedWateringDates.contains(normalizedToday);

}

  // Преобразование Map в объект User
  factory Flower.fromMap(Map<String, dynamic> map) {
    return Flower(
        name: map["name"],
        plantDate: map["plantDate"],
        // wateringDate: map["wateringDate"],
        // photo: map["photo"],
        photoPath: map["photoPath"],
        id: map['id'],
        description: map['description'],
        wateringDates:
            ConvertWateringDate.wateringDatesToList(map["wateringDates"]));
  }

  @override
  String toString() {
    return 'Flower{id: $id, name: $name, plantDate: $plantDate, description: $description, wateringDates: $wateringDates, photoPath: $photoPath}';
  }
}
