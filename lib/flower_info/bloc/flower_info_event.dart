part of 'flower_info_bloc.dart';

sealed class FlowerInfoEvent extends Equatable {
  const FlowerInfoEvent();
}


class FlowerInfoGettingStartData extends FlowerInfoEvent{
  final String flowerId;

  const FlowerInfoGettingStartData({required this.flowerId});

  @override
  List<Object?> get props => [flowerId];

}


class PhotoAdding extends FlowerInfoEvent {
  final File photo;

  const PhotoAdding(this.photo);

  @override
  List<Object?> get props => [photo];
}
class NameAddingEvent extends FlowerInfoEvent {
  final String name;

  const NameAddingEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class DatePlantAdding extends FlowerInfoEvent {
  final String plantDate;

  const DatePlantAdding(this.plantDate);

  @override
  List<Object?> get props => [plantDate];
}

class DescriptionAdding extends FlowerInfoEvent {
  final String description;

  const DescriptionAdding(this.description);

  @override
  List<Object?> get props => [description];
}

class DateWateringAdding extends FlowerInfoEvent {
  final List<DateTime> wateringDate;

  const DateWateringAdding(this.wateringDate);

  @override
  List<Object?> get props => [wateringDate];
}

class FlowerInfoRemoving extends FlowerInfoEvent{
  final String flowerId;


  const FlowerInfoRemoving({required this.flowerId});

  @override
  List<Object?> get props => [flowerId];

}

class FlowerInfoSaving extends FlowerInfoEvent{
  @override
  List<Object?> get props => [];

}


