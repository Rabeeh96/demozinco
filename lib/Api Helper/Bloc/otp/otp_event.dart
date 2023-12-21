part of 'otp_bloc.dart';

@immutable
abstract class OtpEvent {}
class FetchOtpEvent extends OtpEvent {
  final String email;
  final String otp;

  FetchOtpEvent({required this.email,required this.otp});
}
