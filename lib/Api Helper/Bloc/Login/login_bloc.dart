import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../Api_Functions/Login/login.dart';
import '../../ModelClasses/Login/LoginModelClass.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late LoginModelClass loginModelClass;
  LoginApi loginApi;
  LoginBloc(this.loginApi) : super(LoginInitial()) {
    on<PostLoginEvent>((event, emit) async {
      final preference = await SharedPreferences.getInstance();
      emit(LoginLoading());
      try{
        loginModelClass = await loginApi.loginFunction(username: event.userName, password: event.password);
        preference.setString('token', loginModelClass.accessToken.toString());
        preference.setString('userName', loginModelClass.username.toString());
          preference.setString('organisation',loginModelClass.organization! );
        emit(LoginLoaded());
      }catch(e){
        emit(LoginError());

      }
    });
  }
}

