part of 'home_bloc.dart';

//То что отдаем

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}





class HomePageOpened extends HomeState {
  final List<Flower> flowerList;

  const HomePageOpened(this.flowerList);

  @override
  List<Object?> get props => [flowerList];
}



class HomePageError extends HomeState {
  final String message;

  HomePageError(this.message);

  @override
  List<Object?> get props => [];
}