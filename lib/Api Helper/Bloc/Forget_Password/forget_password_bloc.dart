import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../Api_Functions/ForgetPasswordApi/forget_password_api.dart';
import '../../ModelClasses/Forget_password/EmailResendModelClass.dart';
import '../../ModelClasses/Forget_password/ForgetOtpMOdelClass.dart';
import '../../ModelClasses/Forget_password/PasswordResetModelClass.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {

  late  EmailResendModelClass emailResendModelClass;
  late ForgetOtpMOdelClass forgetOtpMOdelClass ;
  late   PasswordResetModelClass passwordResetModelClass ;


  ForgetPasswordApi forgetPasswordApi;
  ForgetPasswordBloc(this.forgetPasswordApi) : super(ForgetPasswordInitial()) {
    on<FetchEmailResendEvent>((event, emit) async{

      emit(EmailResendLoading());
      try{
        emailResendModelClass = await forgetPasswordApi.EmailResendFunction(email: event.email);
        emit(EmailResendLoaded());

      }catch(e){
        emit(EmailResendError());


      }
    });

    on<FetchForgetOtpEvent>((event, emit) async{

      emit(ForgetOtpLoading());
      try{
        forgetOtpMOdelClass = await forgetPasswordApi.forgetOtpFunction(email: event.email, otp: event.otp, isOtp: event.isOtp);
        emit(ForgetOtpLoaded());

      }catch(e){
        emit(ForgetOtpError());


      }
    });


    on<FetchResetPasswordEvent>((event, emit) async{

      emit(ResetPasswordLoading());
      try{
        passwordResetModelClass = await forgetPasswordApi.resetPasswordFunction(email: event.email, otp: event.otp, password1: event.password1, password2: event.password2);
        emit(ResetPasswordLoaded());

      }catch(e){
        emit(ResetPasswordError());


      }
    });


  }
}
