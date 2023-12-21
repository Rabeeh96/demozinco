import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../Api_Functions/Sign up/signup_api.dart';
import '../../ModelClasses/Sign up/SignupModelClass.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  late SignupModelClass? signupModelClass ;

  SignupApi signupApi;
  SignupBloc(this.signupApi) : super(SignupInitial()) {
    on<FetchSignupEvent>((event, emit) async{

      emit(SignupLoading());
      try{
        signupModelClass =await signupApi.signupFunction(firstName: event.firstName,
            email: event.email, password1: event.password1, password2: event.password2, country: event.country);

        emit(SignupLoaded());


      }catch(e){
        emit(SignupError());

      }
    });
  }
}
