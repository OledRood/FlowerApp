part of 'add_flower_bloc.dart';

sealed class AddFlowerEvent extends Equatable {
  const AddFlowerEvent();
}

class PhotoAdding extends AddFlowerEvent {
  final File photo;

  const PhotoAdding(this.photo);

  @override
  List<Object?> get props => [photo];
}
class NameAddingEvent extends AddFlowerEvent {
  final String name;

  const NameAddingEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class DatePlantAdding extends AddFlowerEvent {
  final String plantDate;

  const DatePlantAdding(this.plantDate);

  @override
  List<Object?> get props => [plantDate];
}

class DescriptionAdding extends AddFlowerEvent {
  final String description;

  const DescriptionAdding(this.description);

  @override
  List<Object?> get props => [description];
}

class DateWateringAdding extends AddFlowerEvent {
  final String wateringDate;

  const DateWateringAdding(this.wateringDate);

  @override
  List<Object?> get props => [wateringDate];
}

class AddButtonTapping extends AddFlowerEvent {

  const AddButtonTapping();

  @override
  List<Object?> get props => [];
}



