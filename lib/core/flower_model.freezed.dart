// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flower_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Flower {

 String get name; String get plantDate; String get photoPath; String get id; List<DateTime> get wateringDates; String get description;
/// Create a copy of Flower
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlowerCopyWith<Flower> get copyWith => _$FlowerCopyWithImpl<Flower>(this as Flower, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Flower&&(identical(other.name, name) || other.name == name)&&(identical(other.plantDate, plantDate) || other.plantDate == plantDate)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.wateringDates, wateringDates)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,name,plantDate,photoPath,id,const DeepCollectionEquality().hash(wateringDates),description);

@override
String toString() {
  return 'Flower(name: $name, plantDate: $plantDate, photoPath: $photoPath, id: $id, wateringDates: $wateringDates, description: $description)';
}


}

/// @nodoc
abstract mixin class $FlowerCopyWith<$Res>  {
  factory $FlowerCopyWith(Flower value, $Res Function(Flower) _then) = _$FlowerCopyWithImpl;
@useResult
$Res call({
 String name, String plantDate, String photoPath, String id, List<DateTime> wateringDates, String description
});




}
/// @nodoc
class _$FlowerCopyWithImpl<$Res>
    implements $FlowerCopyWith<$Res> {
  _$FlowerCopyWithImpl(this._self, this._then);

  final Flower _self;
  final $Res Function(Flower) _then;

/// Create a copy of Flower
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? plantDate = null,Object? photoPath = null,Object? id = null,Object? wateringDates = null,Object? description = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,plantDate: null == plantDate ? _self.plantDate : plantDate // ignore: cast_nullable_to_non_nullable
as String,photoPath: null == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,wateringDates: null == wateringDates ? _self.wateringDates : wateringDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _Flower implements Flower {
  const _Flower({required this.name, required this.plantDate, required this.photoPath, required this.id, required final  List<DateTime> wateringDates, required this.description}): _wateringDates = wateringDates;
  

@override final  String name;
@override final  String plantDate;
@override final  String photoPath;
@override final  String id;
 final  List<DateTime> _wateringDates;
@override List<DateTime> get wateringDates {
  if (_wateringDates is EqualUnmodifiableListView) return _wateringDates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_wateringDates);
}

@override final  String description;

/// Create a copy of Flower
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlowerCopyWith<_Flower> get copyWith => __$FlowerCopyWithImpl<_Flower>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Flower&&(identical(other.name, name) || other.name == name)&&(identical(other.plantDate, plantDate) || other.plantDate == plantDate)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._wateringDates, _wateringDates)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,name,plantDate,photoPath,id,const DeepCollectionEquality().hash(_wateringDates),description);

@override
String toString() {
  return 'Flower(name: $name, plantDate: $plantDate, photoPath: $photoPath, id: $id, wateringDates: $wateringDates, description: $description)';
}


}

/// @nodoc
abstract mixin class _$FlowerCopyWith<$Res> implements $FlowerCopyWith<$Res> {
  factory _$FlowerCopyWith(_Flower value, $Res Function(_Flower) _then) = __$FlowerCopyWithImpl;
@override @useResult
$Res call({
 String name, String plantDate, String photoPath, String id, List<DateTime> wateringDates, String description
});




}
/// @nodoc
class __$FlowerCopyWithImpl<$Res>
    implements _$FlowerCopyWith<$Res> {
  __$FlowerCopyWithImpl(this._self, this._then);

  final _Flower _self;
  final $Res Function(_Flower) _then;

/// Create a copy of Flower
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? plantDate = null,Object? photoPath = null,Object? id = null,Object? wateringDates = null,Object? description = null,}) {
  return _then(_Flower(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,plantDate: null == plantDate ? _self.plantDate : plantDate // ignore: cast_nullable_to_non_nullable
as String,photoPath: null == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,wateringDates: null == wateringDates ? _self._wateringDates : wateringDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
