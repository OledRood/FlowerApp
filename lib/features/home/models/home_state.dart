import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/flower_model.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default([]) List<Flower> flowerList,

  }) = _HomeState;

  const HomeState._();

  factory HomeState.initial() =>
      const HomeState(
        isLoading: false,
        errorMessage: null,
        flowerList: [],
      );

}
