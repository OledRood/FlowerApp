import '../flower_model.dart';

class DatabaseState {
  final List<Flower> flowers;

  DatabaseState({required this.flowers});

  DatabaseState copyWith({List<Flower>? flowers}) {
    return DatabaseState(flowers: flowers ?? this.flowers);
  }
}
