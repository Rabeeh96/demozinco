import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../Api_Functions/otp/otp_api.dart';
import '../../ModelClasses/otp/OtpModelclass.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
late  OtpModelclass otpModelclass;
OtpApi otpApi;
  OtpBloc(this.otpApi) : super(OtpInitial()) {
    on<FetchOtpEvent>((event, emit)async {
      emit(OtpLoading());
      try{
        otpModelclass = await otpApi.otpFunction(email: event.email, otp: event. otp);

        emit(OtpLoaded());

      }catch(e){
        emit(OtpError());


      }
    });
  }
}
