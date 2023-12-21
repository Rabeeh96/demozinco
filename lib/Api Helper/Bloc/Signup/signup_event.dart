part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class FetchSignupEvent extends SignupEvent{
  final String firstName;
  final String email ;
  final String password1;
  final String  password2;
  final String country;

  FetchSignupEvent(
  {required this.firstName,required this.email,required this.password1,required this.password2,required this.country});
}
