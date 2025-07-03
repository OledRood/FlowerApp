import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/flower_model.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../core/storage/database.dart';
import '../models/home_state.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  static DatabaseHelper dbHelper = DatabaseHelper.instance;
  final AppNavigator _navigator;

  HomeViewModel(this._navigator) : super(HomeState.initial()) {
    getFlowerList();
  }

  Future<void> getFlowerList() async {
    List<Flower> flowerList = await dbHelper.getFlowers();
    if (!mounted) return;
    state = state.copyWith(flowerList: flowerList);
  }

  Future<void> wateringFlower(String flowerId) async {
    if (state.isLoading) return;
    try {
      state = state.copyWith(isLoading: true);
      final Flower flower = await dbHelper.getFlowerById(flowerId);
      final todayIndexInWateringList = _checkIndexTodayWatering(flower);
      
      Flower updatedFlower;
      if (todayIndexInWateringList == -1) {
        // Добавляем сегодняшнюю дату полива
        final updatedWateringDates = [...flower.wateringDates, DateTime.now()];
        updatedFlower = flower.copyWith(wateringDates: updatedWateringDates);
      } else {
        // Удаляем сегодняшнюю дату полива
        final updatedWateringDates = [...flower.wateringDates];
        updatedWateringDates.removeAt(todayIndexInWateringList);
        updatedFlower = flower.copyWith(wateringDates: updatedWateringDates);
      }
      
      // Ожидаем обновления в базе данных
      await dbHelper.updateFlower(flower: updatedFlower);
      
      // Обновляем локальное состояние более эффективно
      final currentFlowers = [...state.flowerList];
      final flowerIndex = currentFlowers.indexWhere((f) => f.id == flowerId);
      if (flowerIndex != -1) {
        currentFlowers[flowerIndex] = updatedFlower;
        state = state.copyWith(flowerList: currentFlowers, isLoading: false);
      } else {
        // Если цветок не найден в текущем списке, перезагружаем весь список
        await getFlowerList();
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  void goToFlowerInfo(String flowerId) {
    _navigator.flowerInfo(flowerId);
  }

  void goToAddFlower() {
    _navigator.addFlower();
  }

  int _checkIndexTodayWatering(Flower flower) {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);

    final normalizedWateringDates = flower.wateringDates.map((date) {
      return DateTime(date.year, date.month, date.day);
    }).toList();

    return normalizedWateringDates.indexOf(normalizedToday);
  }
}
