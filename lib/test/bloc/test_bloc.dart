import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart';

import '../../models/flower_model.dart';
import '../../storage/database.dart';

part 'test_event.dart';

part 'test_state.dart';

// class TestBloc extends Bloc<TestEvent, TestState> {
//   static DatabaseHelper dbHelper = DatabaseHelper.instance;
//
//
//
//   Future<List<Flower>> getFlowerList() async {
//     List<Flower> flowersList = await dbHelper.getFlowers();
//
//     return flowersList;
//   }
//
//   TestBloc() : super(TestInitial()) {
//     on<TestFlowerWatering>(_onWaterFlower);
//     on<PageOpening>(_onOpenPage);
//     // on<TestUpdateComplete>(_onUpdateIsComplete);
//   }
//
//   FutureOr<void> _onOpenPage(
//     final PageOpening event,
//     final Emitter<TestState> emit,
//   ) async {
//     emit(TestPageOpened(await getFlowerList()));
//   }
//
//   // FutureOr<void> _onUpdateIsComplete(
//   //   final TestUpdateComplete event,
//   //   final Emitter<TestState> emit,
//   // ) async {
//   //   emit(const TestFlowerWatered(false));
//   // }
//
//   FutureOr<void> _onWaterFlower(
//     final TestFlowerWatering event,
//     final Emitter<TestState> emit,
//   ) async {
//     final Flower flower = await dbHelper.getFlowerById(event.flowerId);
//     final todayIndexInWateringList = _checkIndexTodayWatering(flower);
//     late bool  _todayIsWatering;
//
//     if(todayIndexInWateringList == -1){
//        _todayIsWatering = true;
//       flower.wateringDates.add(DateTime.now());
//     } else {
//        _todayIsWatering = false;
//
//       flower.wateringDates.removeAt(todayIndexInWateringList);
//     }
//     dbHelper.updateFlower(flower: flower);
//
//     emit(TestFlowerWatered(_todayIsWatering));
//     // await Future.delayed(Duration(seconds: 5));
//     // emit(TestPageOpened(await getFlowerList()));
//
//
//   }
//   int _checkIndexTodayWatering(Flower flower) {
//     final today = DateTime.now();
//     final normalizedToday = DateTime(today.year, today.month, today.day);
//
//     final normalizedWateringDates = flower.wateringDates.map((date) {
//       return DateTime(date.year, date.month, date.day);
//     }).toList();
//
//     return normalizedWateringDates.indexOf(normalizedToday);
//   }
//
// }

class TestBloc extends Bloc<TestEvent, TestState> {
  static DatabaseHelper dbHelper = DatabaseHelper.instance;

  List<String> flowerList = [];


  static List<String> getFlowerList() {
    final flowersList = ["one", "two", "three", 'four', 'five'];

    return flowersList;
  }

  TestBloc() : super(TestPageOpened(getFlowerList() )) {

  }


  FutureOr<void> _onOpenPage(
    final TestInitial event,
    final Emitter<TestState> emit,
  ) async {

    final flowerList = await getFlowerList();

    emit(TestPageOpened(flowerList));
    // await Future.delayed(Duration(seconds: 5));
    // emit(TestPageOpened(await getFlowerList()));


  }


}