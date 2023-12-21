import 'package:bloc/bloc.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/Delete_user/delete_user.dart';
import 'package:meta/meta.dart';


import '../../ModelClasses/User/DeleteUserModelClass.dart';

part 'delete_user_event.dart';
part 'delete_user_state.dart';

class DeleteUserBloc extends Bloc<DeleteUserEvent, DeleteUserState> {
 late DeleteUserModelClass deleteUserModelClass;
 DeleteUserApi deleteUserApi;


  DeleteUserBloc(this.deleteUserApi) : super(DeleteUserInitial()) {
    on<FetchDeleteUser>((event, emit) async{

      emit(DeleteUserLoading());
      try{

        emit(DeleteUserLoaded());
      }catch(e){
        emit(DeleteUserError());
      }


    });
  }
}
