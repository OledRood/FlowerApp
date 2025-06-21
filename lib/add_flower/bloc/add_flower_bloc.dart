import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../core/flower_model.dart';
import '../../core/storage/database.dart';
import '../../core/storage/file_save.dart';

part 'add_flower_event.dart';

part 'add_flower_state.dart';

class AddFlowerBloc extends Bloc<AddFlowerEvent, AddFlowerState> {
  String _name = '';
  bool _nameError = false;
  String _plantDate = DateTime.now().toString();
  File? _photo;
  bool _photoError = false;
  String _description = '';
  String _wateringDate = DateTime.now().toString();

  DatabaseHelper dbHelper = DatabaseHelper.instance;

  AddFlowerBloc()
      : super(AddFlowerErrors(photoError: false, nameError: false)) {
    on<NameAddingEvent>(_onNameAdd);
    on<DatePlantAdding>(_onDatePlantAdding);
    on<PhotoAdding>(_onPhotoAdding);
    on<DescriptionAdding>(_onDesciprionAdding);
    on<DateWateringAdding>(_onDateWateringAdding);
    on<AddButtonTapping>(_onAddButtonTapping);
  }

  FutureOr<void> _onPhotoAdding(
    final PhotoAdding event,
    final Emitter<AddFlowerState> emit,
  ) {
    _photo = event.photo;
    _photoError = false;
    // debugPrint(_photo?.path);
    emit(_calculateErrors());
  }

  FutureOr<void> _onNameAdd(
    final NameAddingEvent event,
    final Emitter<AddFlowerState> emit,
  ) {
    _name = event.name;
    _nameError = false;
    emit(_calculateErrors());
  }

  FutureOr<void> _onDatePlantAdding(
    final DatePlantAdding event,
    final Emitter<AddFlowerState> emit,
  ) {
    _plantDate = event.plantDate;
  }

  FutureOr<void> _onDesciprionAdding(
    final DescriptionAdding event,
    final Emitter<AddFlowerState> emit,
  ) {
    _description = event.description;
  }

  FutureOr<void> _onDateWateringAdding(
    final DateWateringAdding event,
    final Emitter<AddFlowerState> emit,
  ) {
    _wateringDate = event.wateringDate;
  }

  FutureOr<void> _onAddButtonTapping(
    final AddButtonTapping event,
    final Emitter<AddFlowerState> emit,
  ) async {
    if (_name != '' &&
        _plantDate != '' &&
        _photo != null &&
        _wateringDate != '') {
      // debugPrint(_wateringDate);
      // debugPrint(_plantDate);
      // debugPrint(_description);
      // debugPrint(_name);
      debugPrint('Flower is created');

      String flowerId = getUuid();
      String? filePath = await savePhoto(photo: _photo!, name: flowerId);

      //Сохраняем цветок
      try {
        if(filePath == null){
          throw 'Путь равен нулю';
        }
        dbHelper.insertFlower(Flower(
            name: _name,
            plantDate: _plantDate,
            wateringDates: [DateTime.parse(_wateringDate)],
            photoPath: filePath,
            description: _description,
            id: flowerId));
        emit(AddFlowerCompleted());
      } catch (e){
        debugPrint('Произошла ошибка в _onAddButtonTapping: $e');
      }



    }
    if (_photo == null) {
      _photoError = true;
    }
    if (_name == '') {
      _nameError = true;
    }
    emit(_calculateErrors());
  }

  String getUuid() {
    final uuid = Uuid();
    final uniqueId = uuid.v4();
    return uniqueId;
  }

  AddFlowerErrors _calculateErrors() {
    return AddFlowerErrors(photoError: _photoError, nameError: _nameError);
  }
}
