
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../Api_Functions/User/user_api.dart';
import '../../ModelClasses/User/DeleteUserModelClass.dart';
import '../../ModelClasses/User/DetailUserModelClass.dart';
import '../../ModelClasses/User/EditUserModelClass.dart';
import '../../ModelClasses/User/ListUserModelClass.dart';
import '../../ModelClasses/User/UserCreateModelClass.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
 late UserCreateModelClass userCreateModelClass ;
 late  ListUserModelClass listUserModelClass ;
 late  DetailUserModelClass detailUserModelClass ;
 late  EditUserModelClass editUserModelClass ;
 late DeleteUserModelClass deleteUserModelClass ;
  UserApi userApi;
  UserBloc(this.userApi) : super(UserInitial()) {
    on<CreateUserEvent>((event, emit)async {
      emit(UserCreateLoading());
      try{
        userCreateModelClass = await userApi.useroleCreateFunction(firstName: event.firstName,
            userName: event.userName, email: event.email, passwordOne: event.passwordOne, passwordTwo: event.passwordTwo, 
            phone: event.phone, userTypeId: event.userTypeId, organization_id: event.organization_id, filePath: event.filePath);

        emit(UserCreateLoaded());
      }catch(e){
        emit(UserCreateError());

      }
     
    });
    on<ListUserEvent>((event, emit)async {
      emit(UserListSearchLoading());
      try{
        listUserModelClass = await userApi.useroleListFunction(search: event.search);

        emit(UserListSearchLoaded());
      }catch(e){
        emit(UserListSearchError());

      }

    });
    on<DetailUserEvent>((event, emit)async {
      emit(DetailUserLoading());
      try{
        detailUserModelClass = await userApi.useroleDetailFunction(id: event.id);

        emit(DetailUserLoaded());
      }catch(e){
        emit(DetailUserError());

      }

    });
    on<EditUserEvent>((event, emit)async {
      emit(EditUserLoading());
      try{
        editUserModelClass = await userApi.useroleEditFunction(firstName:
        event.firstName, userName: event.userName, email: event.email, passwordOne: event.passwordOne,
            passwordTwo: event.passwordTwo, phone: event.phone, userTypeId: event.userTypeId, organization_id: event.organization_id
            , id: event.id, filePath: event.filePath);

        emit(EditUserLoaded());
      }catch(e){
        emit(EditUserError());

      }

    });
    on<DeleteUserEvent>((event, emit)async {
      emit(DeleteUserLoading());
      try{
        deleteUserModelClass = await userApi.useroleDeleteFunction(id: event.id);

        emit(DeleteUserLoaded());
      }catch(e){
        emit(DeleteUserError());

      }

    });
  }
}
