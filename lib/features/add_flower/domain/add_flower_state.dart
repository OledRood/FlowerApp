

import 'dart:io';

import 'package:flowers_app/features/flower_info/domain/flower_info_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_flower_state.freezed.dart';

@freezed
sealed class AddFlowerState with _$AddFlowerState {
  const factory AddFlowerState({
    String? flowerId,
    File? photo,
    @Default('') String plantDate,
    List<DateTime>? wateringDates,
    @Default(true) bool isLoading,
    String? errorMessage,
    @Default(SaveStatus.none) SaveStatus saveStatus,
    @Default(false) bool photoError,
    @Default(false) bool nameError,
  }) = _AddFlowerState;
  const AddFlowerState._();
  factory AddFlowerState.initial() {
    final now = DateTime.now().toString();    
    return AddFlowerState(
      flowerId: null,
      photo: null,
      plantDate: now,
      wateringDates: null,
      isLoading: false,
      errorMessage: null,
      saveStatus: SaveStatus.none,
      photoError: false,
      nameError: false,
    );
  }
}