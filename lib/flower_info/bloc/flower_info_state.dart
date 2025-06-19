part of 'flower_info_bloc.dart';

sealed class FlowerInfoState extends Equatable {
  const FlowerInfoState();
}

final class FlowerInfoInitial extends FlowerInfoState {
  @override
  List<Object> get props => [];
}





class FlowerInfoRemoved extends FlowerInfoState{
  @override
  List<Object?> get props => [];
}


class FlowerInfoSaved extends FlowerInfoState{
  final SavingStatus savingStatus;

  const FlowerInfoSaved({required this.savingStatus});

  @override
  List<Object?> get props => [savingStatus];
}

class FlowerInfoGetFlower extends FlowerInfoState{
  final Flower flower;

  const FlowerInfoGetFlower({required this.flower});

  @override
  List<Object?> get props => [flower];
}






