import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../flower_model.dart';
import 'database_state.dart';

class DatabaseNotifier extends StateNotifier<DatabaseState> {
  final DatabaseHelper _dbHelper;

  DatabaseNotifier(this._dbHelper) : super(DatabaseState(flowers: [])) {
    refreshFlowers();
  }

  Future<void> refreshFlowers() async {
    final flowers = await _dbHelper.getFlowers();
    state = state.copyWith(flowers: flowers);
  }
}

class DatabaseHelper {
  // Имя базы данных
  static final _databaseName = 'flowersbase.db';

  // Версия базы данных (нужно увеличивать при изменении схемы)
  static final _databaseVersion = 1;

  //Таблица к цветку
  static final table = 'flowers';
  static final columnId = 'id';
  static final columnName = 'name';
  static final columnPlantDate = 'plantDate';
  static final columnWateringDates = 'wateringDates';
  static final columnDescription = 'description';
  static final columnPhotoPath = 'photoPath';

  // Singleton (единственный экземпляр DatabaseHelper)
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Подключение к базе данных
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Инициализация базы данных
  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Создание таблицы
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId TEXT NOT NULL, 
        $columnName TEXT NOT NULL,
        $columnPlantDate TEXT NOT NULL,
        $columnWateringDates TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnPhotoPath TEXT NOT NULL
      )
    ''');
  }

  // Добавление цветка
  Future<int> insertFlower(Flower flower) async {
    final db = await database;
    return await db.insert(table, flower.toMap());
  }

  // Получение всех цветов
  Future<List<Flower>> getFlowers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Flower.fromMap(maps[i]);
    });
  }

  // Получение цветка по id
  Future<Flower> getFlowerById(String id) async {
    final db = await database; // Получаем базу данных
    final List<Map<String, dynamic>> maps = await db.query(
      table, // Название таблицы
      where: 'id = ?', // Условие WHERE
      whereArgs: [id], // Аргументы для условия
    );

    return Flower.fromMap(maps.first);
  }

  // Обновление цветка
  Future<int> updateFlower({required Flower flower}) async {
    flower.wateringDates;
    final db = await database;
    return await db.update(
      table,
      flower.toMap(),
      where: 'id = ?',
      whereArgs: [flower.id],
    );
  }


  Future<int> deleteFlower(String id) async {
    final db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

}
