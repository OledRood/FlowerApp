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

  Future getFlowerList() async {
    List<Flower> flowerList = await dbHelper.getFlowers();
    print(flowerList);
    state = state.copyWith(flowerList: flowerList);
  }

  Future wateringFlower(flowerId) async {
    if (state.isLoading) return;
    try {
      state = state.copyWith(isLoading: true);
      final Flower flower = await dbHelper.getFlowerById(flowerId);
      final todayIndexInWateringList = _checkIndexTodayWatering(flower);
      if (todayIndexInWateringList == -1) {
        flower.wateringDates.add(DateTime.now());
      } else {
        flower.wateringDates.removeAt(todayIndexInWateringList);
      }
      dbHelper.updateFlower(flower: flower);
      List<Flower> flowerList = await getFlowerList();
      state = state.copyWith(flowerList: flowerList, isLoading: false);
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
