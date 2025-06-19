part of 'test_bloc.dart';

//то что получаем от действия пользователя

sealed class TestEvent extends Equatable {
  const TestEvent();
}

class PageOpening extends TestEvent{
  @override
  List<Object?> get props => [];

}

