part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
class PostLoginEvent extends LoginEvent {
  final String userName;
  final String password;

  PostLoginEvent({required this.userName, required this.password});
}
