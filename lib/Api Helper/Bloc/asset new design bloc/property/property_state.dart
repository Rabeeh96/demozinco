part of 'property_bloc.dart';

@immutable
abstract class PropertyState {}

class PropertyInitial extends PropertyState {}

class AssetPropertyCreateLoading extends PropertyState {}
class AssetPropertyCreateLoaded extends PropertyState {}
class AssetPropertyCreateError extends PropertyState {}


class AssetPropertyDeleteLoading extends PropertyState {}
class AssetPropertyDeleteLoaded extends PropertyState {}
class AssetPropertyDeleteError extends PropertyState {}


class AssetPropertyEditLoading extends PropertyState {}
class AssetPropertyEditLoaded extends PropertyState {}
class AssetPropertyEditError extends PropertyState {}




