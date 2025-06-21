import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../core/flower_model.dart';
import '../../core/saving_status.dart';
import '../../core/storage/database.dart';

part 'flower_info_event.dart';

part 'flower_info_state.dart';

class FlowerInfoBloc extends Bloc<FlowerInfoEvent, FlowerInfoState> {
  String? _id;
  String? _name;
  String? _plantDate;
  String? _description;
  List<DateTime>? _wateringDates;
  String? _photoPath;

  late Flower _flower;

  static DatabaseHelper dbHelper = DatabaseHelper.instance;

  FlowerInfoBloc() : super(FlowerInfoSaved(savingStatus: SavingStatus.none)) {
    // on<FlowerInfoEvent>((event, emit) {
    // });
    on<FlowerInfoGettingStartData>(_onFlowerInfoGetStartData);
    on<NameAddingEvent>(_onNameAdd);
    on<DatePlantAdding>(_onDatePlantAdding);
    on<PhotoAdding>(_onPhotoAdding);
    on<DescriptionAdding>(_onDesciprionAdding);
    on<DateWateringAdding>(_onDateWateringAdding);
    on<FlowerInfoRemoving>(_onFlowerInfoRemoving);
    on<FlowerInfoSaving>(_onFlowerInfoSaving);
  }

  FutureOr<void> _onFlowerInfoGetStartData(
    final FlowerInfoGettingStartData event,
    final Emitter<FlowerInfoState> emit,
  ) async {

    _flower = await dbHelper.getFlowerById(event.flowerId);


    emit(FlowerInfoGetFlower(flower: _flower));
  }

  FutureOr<void> _onPhotoAdding(
    final PhotoAdding event,
    final Emitter<FlowerInfoState> emit,
  ) {
    _photoPath = event.photo.path;

    // debugPrint(_photo?.path);
  }

  FutureOr<void> _onNameAdd(
    final NameAddingEvent event,
    final Emitter<FlowerInfoState> emit,
  ) {
    _name = event.name;
  }

  FutureOr<void> _onDatePlantAdding(
    final DatePlantAdding event,
    final Emitter<FlowerInfoState> emit,
  ) {
    _plantDate = event.plantDate;
  }

  FutureOr<void> _onDesciprionAdding(
    final DescriptionAdding event,
    final Emitter<FlowerInfoState> emit,
  ) {
    _description = event.description;
  }

  FutureOr<void> _onDateWateringAdding(
    final DateWateringAdding event,
    final Emitter<FlowerInfoState> emit,
  ) async {
    _wateringDates = event.wateringDate;
    await dbHelper.updateFlower(
        flower: Flower(
            name: _flower.name,
            plantDate: _flower.plantDate,
            photoPath: _flower.photoPath,
            id: _flower.id,
            wateringDates: _wateringDates!,
            description: _flower.description));

    emit(FlowerInfoSaved(savingStatus: SavingStatus.none));

  }


  FutureOr<void> _onFlowerInfoRemoving(
    final FlowerInfoRemoving event,
    final Emitter<FlowerInfoState> emit,
  ) async {

    await dbHelper.deleteFlower(event.flowerId);

    emit(FlowerInfoRemoved());
  }

  // @override
  // void onTransition(Transition<FlowerInfoEvent, FlowerInfoState> transition) {
  //   debugPrint('LoginBloc event transition: $transition');
  //
  //   super.onTransition(transition);
  // }

  FutureOr<void> _onFlowerInfoSaving(
      final FlowerInfoSaving event, final Emitter<FlowerInfoState> emit) {
    try {
      if (_name == '') {
        emit(FlowerInfoSaved(savingStatus: SavingStatus.error));
      } else {
        updateFlowerInDatabase();
        emit(FlowerInfoSaved(savingStatus: SavingStatus.good));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(FlowerInfoSaved(savingStatus: SavingStatus.error));
    }

  }

  void updateFlowerInDatabase() {
    dbHelper.updateFlower(
        flower: Flower(
            name: _name ?? _flower.name,
            plantDate: _plantDate ?? _flower.plantDate,
            photoPath: _photoPath ?? _flower.photoPath,
            id: _id ?? _flower.id,
            wateringDates: _wateringDates ?? _flower.wateringDates,
            description: _description ?? _flower.description));
  }

  Future<List<Flower>> getFlowerList() async {
    List<Flower> flowersList = await dbHelper.getFlowers();

    return flowersList;
  }
}
