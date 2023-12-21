part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}
class SignupLoading extends SignupState {}
class SignupLoaded extends SignupState {}
class SignupError extends SignupState {}
