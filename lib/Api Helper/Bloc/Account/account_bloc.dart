import 'package:bloc/bloc.dart';

import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/Account/account_api.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Account/CreateAccountModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Account/DeleteAccountModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Account/DetailAccountModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Account/EditAccountModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Account/ListAccountModelClass.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';


part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
late  CreateAccountModelClass createAccountModelClass ;
late ListAccountModelClass listAccountModelClass ;
late DeleteAccountModelClass deleteAccountModelClass;
late DetailAccountModelClass detailAccountModelClass ;
late EditAccountModelClass editAccountModelClass ;
AccountApi accountApi;
late  Response response ;

  AccountBloc(this.accountApi) : super(AccountInitial()) {
    on<CreateAccountEvent>((event, emit) async{
      emit(CreateAccountLoading());
      try{
        createAccountModelClass = await accountApi.accountCreateFunction(
            accountName:  event.accountName, openingBalance:  event.openingBalance, organisation:  event.organisation,
            country:  event.country, account_type:  event.account_type, as_on_date:  event.as_on_date);
        emit(CreateAccountLoaded());
      }catch(e){
        emit(CreateAccountError());
      }

    });


    on<ListAccountEvent>((event, emit) async{
      emit(ListAccountLoading());

      try{
        listAccountModelClass  = await accountApi.accountListFunction(organisation: event.organisation,
            page_number: event.page_number, page_size: event.page_size, search: event.search, type:event.type, country:event.country);
        emit(ListAccountLoaded());
      }catch(e){
        emit(ListAccountError());
      }

    });
    on<DeleteAccountEvent>((event, emit) async{
      emit(DeleteAccountLoading());

      try{
        deleteAccountModelClass  = await accountApi.accountDeleteFunction(id: event.id, organisation: event.organisation);
        emit(DeleteAccountLoaded());
      }catch(e){
        emit(DeleteAccountError());
      }

    });
    on<DetailAccountEvent>((event, emit) async{
      emit(DetailAccountLoading());

      try{
        detailAccountModelClass  = await accountApi.accountDetailFunction(id: event.id, organisation: event.organisation);
        emit(DetailAccountLoaded());
      }catch(e){
        emit(DetailAccountError());
      }

    });
    on<EditAccountEvent>((event, emit) async{
      emit(EditAccountLoading());

      try{
        editAccountModelClass  = await accountApi.editAccountFunction(
            id: event.id, organisation: event.organisation, accountName: event.accountName,
            openingBalance: event.openingBalance, country: event.country, date: event.date, accountType: event.accountType);
        emit(EditAccountLoaded());
      }catch(e){
        emit(EditAccountError());
      }

    });

  }
}
