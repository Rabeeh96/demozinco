part of 'forget_password_bloc.dart';

@immutable
abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}



class EmailResendLoading extends ForgetPasswordState {}
class EmailResendLoaded extends ForgetPasswordState {}
class EmailResendError extends ForgetPasswordState {}



class ForgetOtpLoading extends ForgetPasswordState {}
class ForgetOtpLoaded extends ForgetPasswordState {}
class ForgetOtpError extends ForgetPasswordState {}


class ResetPasswordLoading extends ForgetPasswordState {}
class ResetPasswordLoaded extends ForgetPasswordState {}
class ResetPasswordError extends ForgetPasswordState {}
