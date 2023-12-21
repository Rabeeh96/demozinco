part of 'dash_board_bloc.dart';

@immutable
abstract class DashBoardState {}

class DashBoardInitial extends DashBoardState {}

class DashBoardLoading extends DashBoardState {}
class DashBoardLoaded extends DashBoardState {}
class DashBoardError extends DashBoardState {}
