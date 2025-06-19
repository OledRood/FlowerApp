import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart';

import '../../models/flower_model.dart';
import '../../storage/database.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static DatabaseHelper dbHelper = DatabaseHelper.instance;



  Future<List<Flower>> getFlowerList() async {
    List<Flower> flowersList = await dbHelper.getFlowers();

    return flowersList;
  }

  HomeBloc() : super(HomeInitial()) {
    on<HomeFlowerWatering>(_onWaterFlower);
    on<PageOpening>(_onOpenPage);
  }

  FutureOr<void> _onOpenPage(
    final PageOpening event,
    final Emitter<HomeState> emit,
  ) async {
    emit(HomePageOpened(await getFlowerList()));
  }


  FutureOr<void> _onWaterFlower(
    final HomeFlowerWatering event,
    final Emitter<HomeState> emit,
  ) async {
    final Flower flower = await dbHelper.getFlowerById(event.flowerId);
    final todayIndexInWateringList = _checkIndexTodayWatering(flower);

    if(todayIndexInWateringList == -1){
      flower.wateringDates.add(DateTime.now());
    } else {
      flower.wateringDates.removeAt(todayIndexInWateringList);
    }
    dbHelper.updateFlower(flower: flower);
    List<Flower> flowerList = await getFlowerList();
    emit(HomePageOpened(flowerList));




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
