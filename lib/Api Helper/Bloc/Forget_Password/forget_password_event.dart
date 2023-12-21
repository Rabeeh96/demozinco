part of 'forget_password_bloc.dart';

@immutable
abstract class ForgetPasswordEvent {}

class FetchEmailResendEvent extends ForgetPasswordEvent{
  final String email;

  FetchEmailResendEvent({required this.email});
}


class FetchForgetOtpEvent extends ForgetPasswordEvent{
  final String email;
  final String otp;
  final String isOtp;

  FetchForgetOtpEvent({required this.email,required this.otp,required this.isOtp});

}

class FetchResetPasswordEvent extends ForgetPasswordEvent{
  final String email;
  final String otp;
  final String password1;
  final String password2;

  FetchResetPasswordEvent({required this.email,required this.otp,required this.password1,required this.password2});

}