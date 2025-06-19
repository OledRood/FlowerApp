part of 'add_flower_bloc.dart';

sealed class AddFlowerState extends Equatable {
  const AddFlowerState();
}


class AddFlowerErrors extends AddFlowerState{
  final bool photoError;
  final bool nameError;

  const AddFlowerErrors({required this.photoError, required this.nameError});

  @override
  List<Object?> get props => [photoError, nameError];

}
class AddFlowerCompleted extends AddFlowerState{


  @override
  List<Object?> get props => [];

}
