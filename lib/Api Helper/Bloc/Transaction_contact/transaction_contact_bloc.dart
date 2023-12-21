import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../Api_Functions/TransactionContact/transaction_contact.dart';
import '../../ModelClasses/transaction contact/CreateTranactionContactModelClass.dart';
import '../../ModelClasses/transaction contact/DeleteTransactionContactModelClass.dart';
import '../../ModelClasses/transaction contact/DetailTransactionContactModelClass.dart';
import '../../ModelClasses/transaction contact/EditTransactionContactModelClass.dart';
import '../../ModelClasses/transaction contact/ListTransactionContactModelClass.dart';

part 'transaction_contact_event.dart';
part 'transaction_contact_state.dart';

class TransactionContactBloc extends Bloc<TransactionContactEvent, TransactionContactState> {
 late  CreateTranactionContactModelClass createTranactionContactModelClass ;
 late DeleteTransactionContactModelClass deleteTransactionContactModelClass ;
 late  DetailTransactionContactModelClass detailTransactionContactModelClass ;
 late  ListTransactionContactModelClass listTransactionContactModelClass ;
 late EditTransactionContactModelClass editTransactionContactModelClass ;
 TransactionContactApi transactionContactApi;
  TransactionContactBloc(this.transactionContactApi) : super(TransactionContactInitial()) {
    on<CreateTransactionContactEventEvent>((event, emit) async{
      emit(TransactionContactCreateLoading());
      try{
        createTranactionContactModelClass = await transactionContactApi.createTransactionContactFunction(
          reminderData: event.reminder_date,
            organisation: event.organisation, date: event.date, time: event.time, fromAccount:event.fromAccount,
            toAccount: event.toAccount,  description: event.description,
            amount: event.amount, transactionType: event.transactionType, isReminder: event.isReminder);

        emit(TransactionContactCreateLoaded());
      }catch(e){
        emit(TransactionContactCreateError());

      }
    });
    on<ListTransactionContactEventEvent>((event, emit) async{
      emit(TransactionContactListLoading());
      try{
        listTransactionContactModelClass = await transactionContactApi.listTransactionContactFunction(
          id: event.id,
            organisation: event.organisation, search: event.search,to_date:event.to_date,from_date:event.from_date);

        emit(TransactionContactListLoaded());
      }catch(e){
        emit(TransactionContactListError());

      }
    });

    on<DetailTransactionContactEventEvent>((event, emit) async{
      emit(DetailTransactionContactLoading());
      try{
        detailTransactionContactModelClass = await transactionContactApi.detailTransactionContactFunction(
            organisation: event.organisation, id: event.id);

        emit(DetailTransactionContactLoaded());
      }catch(e){
        emit(DetailTransactionContactError());

      }
    });


    on<EditTransactionContactEventEvent>((event, emit) async{
      emit(EditTransactionContactLoading());
      try{
        editTransactionContactModelClass = await transactionContactApi.editTransactionContactFunction(
            reminderData: event.reminder_date,
            organisation: event.organisation, date: event.date, time: event.time, fromAccount: event.fromAccount,
            toAccount: event.toAccount, amount: event.amount, description: event.description,
            transactionType: event.transactionType, isReminder: event.isReminder, id: event.id);

        emit(EditTransactionContactLoaded());
      }catch(e){
        emit(EditTransactionContactError());

      }
    });



    on<DeleteTransactionContactEventEvent>((event, emit) async{
      emit(DeleteTransactionContactLoading());
      try{
        deleteTransactionContactModelClass = await transactionContactApi.deleteTransactionContactFunction(
            organisation: event.organisation, id: event.id);

        emit(DeleteTransactionContactLoaded());
      }catch(e){
        emit(DeleteTransactionContactError());

      }
    });


  }
}
