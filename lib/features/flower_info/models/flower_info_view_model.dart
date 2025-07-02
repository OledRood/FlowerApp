import 'dart:io';

import 'package:flowers_app/core/storage/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/flower_model.dart';
import '../../../core/message/scaffold_messenger_manager.dart';
import '../../../core/navigation/app_navigator.dart';
import '../domain/flower_info_state.dart';

class FlowerInfoViewModel extends StateNotifier<FlowerInfoState> {
  final AppNavigator navigator;
  final String flowerId;
  final ScaffoldMessengerManager _scaffoldMessengerManager;

  FlowerInfoViewModel(
    this.navigator,
    this.flowerId,
    this._scaffoldMessengerManager,
  ) : super(FlowerInfoState.initial()) {
    _initialData(flowerId);
  }

  DatabaseHelper dbHelper = DatabaseHelper.instance;

  final controllerOfName = TextEditingController();
  final controllerOfDatePlant = TextEditingController();
  final controllerOfDescription = TextEditingController();

  void _initialData(String flowerId) async {
    try {
      Flower flower = await dbHelper.getFlowerById(flowerId);
      controllerOfName.text = flower.name;
      controllerOfDatePlant.text = flower.plantDate;
      controllerOfDescription.text = flower.description;
      state = state.copyWith(
        photoPath: flower.photoPath,
        plantDate: flower.plantDate,
        wateringDates: flower.wateringDates,
        flowerId: flowerId,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void addPhoto(File photo) {
    state = state.copyWith(photoPath: photo.path, saveStatus: SaveStatus.ready);
  }

  void addPlantData(String newPlantDate) {
    state = state.copyWith(
      plantDate: newPlantDate,
      saveStatus: SaveStatus.ready,
    );
  }

  void addDateWatering(List<DateTime> newWateringDates) async {
    state = state.copyWith(
      wateringDates: newWateringDates,
      saveStatus: SaveStatus.ready,
    );
  }

  Future removeFlower() async {
    await dbHelper.deleteFlower(state.flowerId!);
    //Вызвать ссообщение об удалении
    navigator.back();
  }

  Future saveFlowerInfo() async {
    if (state.isLoading) return;
    if (state.saveStatus == SaveStatus.none) return;
    if (controllerOfName.text == '') {
      _showMessage('Имя не должно быть пустым');
      return;
    }

    state = state.copyWith(isLoading: true);
    Flower newFlower = Flower(
      id: state.flowerId!,
      name: controllerOfName.text,
      photoPath: state.photoPath!,
      plantDate: controllerOfDatePlant.text,
      description: controllerOfDescription.text,
      wateringDates: state.wateringDates!,
    );
    _updateFlowerInDatabase(newFlower);

    state = state.copyWith(saveStatus: SaveStatus.saved);
    await Future.delayed(Duration(milliseconds: 300));
    state = state.copyWith(saveStatus: SaveStatus.none, isLoading: false);
  }

  void _showMessage(String message) {
    _scaffoldMessengerManager.showSnackBar(message);
  }

  void _updateFlowerInDatabase(Flower flower) {
    dbHelper.updateFlower(flower: flower);
  }

  void changeSaveStatusToReady() {
    state = state.copyWith(saveStatus: SaveStatus.ready);
  }

  Future<List<Flower>> getFlowerList() async {
    state = state.copyWith(isLoading: true);
    List<Flower> flowersList = await dbHelper.getFlowers();
    state = state.copyWith(isLoading: false);
    return flowersList;
  }

  @override
  void dispose() {
    controllerOfName.dispose();
    controllerOfDatePlant.dispose();
    controllerOfDescription.dispose();
    super.dispose();
  }
}
