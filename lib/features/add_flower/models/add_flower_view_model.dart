import 'dart:io';

import 'package:flowers_app/core/errors/errors_types.dart';
import 'package:flowers_app/core/message/scaffold_messenger_manager.dart';
import 'package:flowers_app/core/navigation/app_navigator.dart';
import 'package:flowers_app/core/storage/database.dart';
import 'package:flowers_app/core/storage/file_save.dart';
import 'package:flowers_app/core/flower_model.dart';
import 'package:flowers_app/features/add_flower/domain/add_flower_state.dart';
import 'package:flowers_app/features/flower_info/domain/flower_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class AddFlowerViewModel extends StateNotifier<AddFlowerState> {
  final AppNavigator navigator;
  final ScaffoldMessengerManager _scaffoldMessengerManager;

  AddFlowerViewModel(this.navigator, this._scaffoldMessengerManager)
    : super(AddFlowerState.initial());

  final controllerOfName = TextEditingController();
  final controllerOfDatePlant = TextEditingController();
  final controllerOfDescription = TextEditingController();

  DatabaseHelper dbHelper = DatabaseHelper.instance;

  void addPhoto(File photo) {
    state = state.copyWith(photo: photo, photoError: false, errorMessage: null);
  }

  void addPlantData(String newPlantDate) {
    state = state.copyWith(plantDate: newPlantDate);
  }

  void addDateWatering(List<DateTime> newWateringDates) {
    state = state.copyWith(wateringDates: newWateringDates);
  }

  Future addFlower() async {
    if (controllerOfName.text.isEmpty) {
      state = state.copyWith(
        nameError: true,
        errorMessage: _errorsMessageMap[ErrorsTypes.nameError],
      );
      _showMessage();
      return;
    }
    if (state.photo == null) {
      state = state.copyWith(
        photoError: true,
        errorMessage: _errorsMessageMap[ErrorsTypes.photoError],
      );
      _showMessage();
      return;
    }
    if (state.plantDate == null) {
      state = state.copyWith(
        errorMessage: _errorsMessageMap[ErrorsTypes.plantDateError],
      );
      _showMessage();
      return;
    }
    if (state.isLoading) return;

    // Начинаем загрузку
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      photoError: false,
      nameError: false,
    );

    try {
      String flowerId = getUuid();
      String? filePath = await savePhoto(photo: state.photo!, name: flowerId);

      if (filePath == null) {
        throw Exception('Не удалось сохранить фото');
      }

      // Сохраняем цветок
      await dbHelper.insertFlower(
        Flower(
          name: controllerOfName.text,
          plantDate: state.plantDate!,
          wateringDates: state.wateringDates ?? [],
          photoPath: filePath,
          description: controllerOfDescription.text,
          id: flowerId,
        ),
      );

      state = state.copyWith(isLoading: false, saveStatus: SaveStatus.saved);

      navigator.back();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Ошибка при сохранении цветка',
        saveStatus: SaveStatus.none,
      );
    }
  }

  void resetNameError() {
    state = state.copyWith(nameError: false, errorMessage: null);
  }

  void _showMessage() {
    final message = state.errorMessage;
    if (message == null || message.isEmpty) return;
    _scaffoldMessengerManager.showUpSnackBar(message);
  }

  String getUuid() {
    final uuid = Uuid();
    final uniqueId = uuid.v4();
    return uniqueId;
  }
}

Map<ErrorsTypes, String> _errorsMessageMap = {
  ErrorsTypes.nameError: 'Заполните имя',
  ErrorsTypes.photoError: 'Добавьте фото',
  ErrorsTypes.plantDateError: 'Выберите дату посадки',
  ErrorsTypes.wateringDatesError: 'Выберите даты полива',
  ErrorsTypes.errorMessage: 'Произошла ошибка, попробуйте позже',
};
