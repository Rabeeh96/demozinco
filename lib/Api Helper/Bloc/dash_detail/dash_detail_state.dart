import 'package:flutter/cupertino.dart';



@immutable
abstract class Dash_detailState {}

class DashDetailsInitial extends Dash_detailState {}
class DashDetailsLoading extends Dash_detailState {}
class DashDetailsLoaded extends Dash_detailState {}
class DashDetailsError extends Dash_detailState {}

class DeleteDashAccountLoading extends Dash_detailState {}
class DeleteDashAccountLoaded extends Dash_detailState {}
class DeleteDashAccountError extends Dash_detailState {}
