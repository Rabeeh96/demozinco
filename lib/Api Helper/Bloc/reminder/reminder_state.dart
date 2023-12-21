part of 'reminder_bloc.dart';

abstract class ReminderState {}

class ReminderInitial extends ReminderState {}

class ReminderListLoading extends ReminderState {}
class ReminderListLoaded extends ReminderState {}
class ReminderListError extends ReminderState {}