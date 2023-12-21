import 'package:flutter/cupertino.dart';

@immutable
abstract class NewTransferBlocState {}

class NewTransferInitial extends NewTransferBlocState {}

class NewTransferLoading extends NewTransferBlocState {}

class NewTransferLoaded extends NewTransferBlocState {}

class NewTransferError extends NewTransferBlocState {}