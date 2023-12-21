import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';



import '../../Api_Functions/UsroleApi/userole_api.dart';
import '../../ModelClasses/Userole/CreateUseroleModelClass.dart';
import '../../ModelClasses/Userole/DeleteUseroleModelClass.dart';
import '../../ModelClasses/Userole/DetailUseroleModelClass.dart';
import '../../ModelClasses/Userole/EditUseroleModelClass.dart';
import '../../ModelClasses/Userole/ListUseroleModelClass.dart';

part 'userole_event.dart';
part 'userole_state.dart';

class UseroleBloc extends Bloc<UseroleEvent, UseroleState> {
 late CreateUseroleModelClass createUseroleModelClass ;
 late ListUseroleModelClass listUseroleModelClass ;
late  DetailUseroleModelClass detailUseroleModelClass ;
late  EditUseroleModelClass editUseroleModelClass ;
late DeleteUseroleModelClass deleteUseroleModelClass ;
 UseroleApi useroleApi;

 UseroleBloc(this.useroleApi) : super(UseroleInitial()) {
    on<CreateUseroleEvent>((event, emit) async{
      emit(UseroleCreateLoading());
      try{
        createUseroleModelClass = await useroleApi.useroleCreateFunction(organizationId: event.organizationId, userTypeName: event.userTypeName, notes: event.notes, permissionData: event.permissionData);

        emit(UseroleCreateLoaded());
      }catch(e){
        emit(UseroleCreateError());

      }

    });



    on<ListUseroleGetEvent>((event, emit) async{
       emit(UseroleListSearchLoading());
       try{
        listUseroleModelClass = await useroleApi.useroleListFunction( search: event.search, pageNo: event.pageNo, items_per_page: event.items_per_page);
        emit(UseroleListSearchLoaded());
      }catch(e){
        emit(UseroleListSearchError());

      }

    });

    on<DetailUseroleGetEvent>((event, emit) async{
      emit(DetailUseroleLoading());
      try{
        detailUseroleModelClass = await useroleApi.useroleDetailFunction(id: event.id);
        emit(DetailUseroleLoaded());
      }catch(e){
        emit(DetailUseroleError());

      }

    });

    on<EditUseroleGetEvent>((event, emit) async{
      emit(EditUseroleLoading());

      try{

        editUseroleModelClass = await useroleApi.useroleEditFunction(organisationId: event.organisationId,
            userTypeId: event.userTypeId, userTypeName: event.userTypeName, permissionData: event.permissionData);

        emit(EditUseroleLoaded());
      }catch(e){
        emit(EditUseroleError());

      }

    });
    on<DeleteUseroleGetEvent>((event, emit) async{
      emit(DeleteUseroleLoading());

      try{

        deleteUseroleModelClass = await useroleApi.useroleDeleteFunction(organisationId: event.organisationId, userTypeId: event.userTypeId);

        emit(DeleteUseroleLoaded());
      }catch(e){
        emit(DeleteUseroleError());

      }

    });


  }
}
