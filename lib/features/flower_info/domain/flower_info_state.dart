import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/flower_model.dart';
import '../../../core/saving_status.dart';

part 'flower_info_state.freezed.dart';

//TODO добавить статус схранения

@freezed
sealed class FlowerInfoState with _$FlowerInfoState {
  const factory FlowerInfoState({
    String? flowerId,
    String? photoPath,
    String? plantDate,
    List<DateTime>? wateringDates,
    @Default(true) bool isLoading,
    String? errorMessage,
    @Default(SaveStatus.none) SaveStatus saveStatus,

  }) = _FlowerInfoState;

  const FlowerInfoState._();

  factory FlowerInfoState.initial() => const FlowerInfoState(
    flowerId: null,
    photoPath: null,
    plantDate: null,
    wateringDates: null,
    isLoading: false,
    errorMessage: null,
    saveStatus: SaveStatus.none,
  );
}



enum SaveStatus{
  none,
  ready,
  saved,
}