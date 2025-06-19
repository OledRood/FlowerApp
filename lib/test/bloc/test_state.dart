part of 'test_bloc.dart';

sealed class TestState extends Equatable {
  const TestState();
}

final class TestInitial extends TestState {


  @override
  List<Object> get props => [];
}





class TestPageOpened extends TestState {
  final List<String> flowerList;

  const TestPageOpened(this.flowerList);

  @override
  List<Object?> get props => [flowerList];
}

class TestFlowerWatered extends TestState {
  final bool isWatered;

  const TestFlowerWatered(this.isWatered);

  @override
  List<Object?> get props => [isWatered];
}
