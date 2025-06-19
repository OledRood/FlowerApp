part of 'home_bloc.dart';

//то что получаем от действия пользователя

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class PageOpening extends HomeEvent{
  @override
  List<Object?> get props => [];

}



class HomeFlowerWatering extends HomeEvent{
  final String flowerId;

  const HomeFlowerWatering(this.flowerId);

  @override
  List<Object?> get props => [flowerId];
}

