part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}
class SettingsDetailLoading extends SettingsState {}
class SettingsDetailLoaded extends SettingsState {}
class SettingsDetailError extends SettingsState {}
