// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flower_info_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FlowerInfoState {

 String? get flowerId; String? get photoPath; String? get plantDate; List<DateTime>? get wateringDates; bool get isLoading; String? get errorMessage; SaveStatus get saveStatus;
/// Create a copy of FlowerInfoState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlowerInfoStateCopyWith<FlowerInfoState> get copyWith => _$FlowerInfoStateCopyWithImpl<FlowerInfoState>(this as FlowerInfoState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlowerInfoState&&(identical(other.flowerId, flowerId) || other.flowerId == flowerId)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.plantDate, plantDate) || other.plantDate == plantDate)&&const DeepCollectionEquality().equals(other.wateringDates, wateringDates)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus));
}


@override
int get hashCode => Object.hash(runtimeType,flowerId,photoPath,plantDate,const DeepCollectionEquality().hash(wateringDates),isLoading,errorMessage,saveStatus);

@override
String toString() {
  return 'FlowerInfoState(flowerId: $flowerId, photoPath: $photoPath, plantDate: $plantDate, wateringDates: $wateringDates, isLoading: $isLoading, errorMessage: $errorMessage, saveStatus: $saveStatus)';
}


}

/// @nodoc
abstract mixin class $FlowerInfoStateCopyWith<$Res>  {
  factory $FlowerInfoStateCopyWith(FlowerInfoState value, $Res Function(FlowerInfoState) _then) = _$FlowerInfoStateCopyWithImpl;
@useResult
$Res call({
 String? flowerId, String? photoPath, String? plantDate, List<DateTime>? wateringDates, bool isLoading, String? errorMessage, SaveStatus saveStatus
});




}
/// @nodoc
class _$FlowerInfoStateCopyWithImpl<$Res>
    implements $FlowerInfoStateCopyWith<$Res> {
  _$FlowerInfoStateCopyWithImpl(this._self, this._then);

  final FlowerInfoState _self;
  final $Res Function(FlowerInfoState) _then;

/// Create a copy of FlowerInfoState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? flowerId = freezed,Object? photoPath = freezed,Object? plantDate = freezed,Object? wateringDates = freezed,Object? isLoading = null,Object? errorMessage = freezed,Object? saveStatus = null,}) {
  return _then(_self.copyWith(
flowerId: freezed == flowerId ? _self.flowerId : flowerId // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,plantDate: freezed == plantDate ? _self.plantDate : plantDate // ignore: cast_nullable_to_non_nullable
as String?,wateringDates: freezed == wateringDates ? _self.wateringDates : wateringDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as SaveStatus,
  ));
}

}


/// @nodoc


class _FlowerInfoState extends FlowerInfoState {
  const _FlowerInfoState({this.flowerId, this.photoPath, this.plantDate, final  List<DateTime>? wateringDates, this.isLoading = true, this.errorMessage, this.saveStatus = SaveStatus.none}): _wateringDates = wateringDates,super._();
  

@override final  String? flowerId;
@override final  String? photoPath;
@override final  String? plantDate;
 final  List<DateTime>? _wateringDates;
@override List<DateTime>? get wateringDates {
  final value = _wateringDates;
  if (value == null) return null;
  if (_wateringDates is EqualUnmodifiableListView) return _wateringDates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  bool isLoading;
@override final  String? errorMessage;
@override@JsonKey() final  SaveStatus saveStatus;

/// Create a copy of FlowerInfoState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlowerInfoStateCopyWith<_FlowerInfoState> get copyWith => __$FlowerInfoStateCopyWithImpl<_FlowerInfoState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlowerInfoState&&(identical(other.flowerId, flowerId) || other.flowerId == flowerId)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath)&&(identical(other.plantDate, plantDate) || other.plantDate == plantDate)&&const DeepCollectionEquality().equals(other._wateringDates, _wateringDates)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus));
}


@override
int get hashCode => Object.hash(runtimeType,flowerId,photoPath,plantDate,const DeepCollectionEquality().hash(_wateringDates),isLoading,errorMessage,saveStatus);

@override
String toString() {
  return 'FlowerInfoState(flowerId: $flowerId, photoPath: $photoPath, plantDate: $plantDate, wateringDates: $wateringDates, isLoading: $isLoading, errorMessage: $errorMessage, saveStatus: $saveStatus)';
}


}

/// @nodoc
abstract mixin class _$FlowerInfoStateCopyWith<$Res> implements $FlowerInfoStateCopyWith<$Res> {
  factory _$FlowerInfoStateCopyWith(_FlowerInfoState value, $Res Function(_FlowerInfoState) _then) = __$FlowerInfoStateCopyWithImpl;
@override @useResult
$Res call({
 String? flowerId, String? photoPath, String? plantDate, List<DateTime>? wateringDates, bool isLoading, String? errorMessage, SaveStatus saveStatus
});




}
/// @nodoc
class __$FlowerInfoStateCopyWithImpl<$Res>
    implements _$FlowerInfoStateCopyWith<$Res> {
  __$FlowerInfoStateCopyWithImpl(this._self, this._then);

  final _FlowerInfoState _self;
  final $Res Function(_FlowerInfoState) _then;

/// Create a copy of FlowerInfoState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? flowerId = freezed,Object? photoPath = freezed,Object? plantDate = freezed,Object? wateringDates = freezed,Object? isLoading = null,Object? errorMessage = freezed,Object? saveStatus = null,}) {
  return _then(_FlowerInfoState(
flowerId: freezed == flowerId ? _self.flowerId : flowerId // ignore: cast_nullable_to_non_nullable
as String?,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,plantDate: freezed == plantDate ? _self.plantDate : plantDate // ignore: cast_nullable_to_non_nullable
as String?,wateringDates: freezed == wateringDates ? _self._wateringDates : wateringDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as SaveStatus,
  ));
}


}

// dart format on
