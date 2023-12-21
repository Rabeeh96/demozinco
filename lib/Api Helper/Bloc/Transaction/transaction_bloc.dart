import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../Api_Functions/transacton/transaction_api.dart';
import '../../ModelClasses/Transaction/CreateTransactionModelClass.dart';
import '../../ModelClasses/Transaction/DeleteTransactionModelClass.dart';
import '../../ModelClasses/Transaction/DetailTransactionModelClass.dart';
import '../../ModelClasses/Transaction/EditTransactiomModelClass.dart';
import '../../ModelClasses/Transaction/ListTransactionModelClass.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
 late  CreateTransactionModelClass createTransactionModelClass ;
 late DetailTransactionModelClass detailTransactionModelClass ;
 late  ListTransactionModelClass listTransactionModelClass ;
 late EditTransactiomModelClass editTransactiomModelClass ;
 late  DeleteTransactionModelClass deleteTransactionModelClass ;
 TransactionApi transactionApi;
  TransactionBloc(this.transactionApi) : super(TransactionInitial()) {
    on<FetchCreateTransactionEvent>((event, emit) async {
      emit(TransactionCreateLoading());
      try{
      createTransactionModelClass = await transactionApi.createTransactionFunction(
          organisation: event.organisation, date: event.date, time: event.time, fromAccount: event.fromAccount,
          fromCountry: event.fromCountry, fromAmount: event.fromAmount, toAccount: event.toAccount,
          toCountry: event.toCountry, toAmount: event.toAmount, description: event.description);

        emit(TransactionCreateLoaded());
      }catch(e){
        emit(TransactionCreateError());

      }
    });


    on<FetchListTransactionEvent>((event, emit) async {
      emit(TransactionListLoading());
      try{
       listTransactionModelClass = await transactionApi.ListTransactionFunction(organisationId: event.organisation, search: event.search);

        emit(TransactionListLoaded());
      }catch(e){
        emit(TransactionListError());

      }
    });


    on<FetchDetailTransactionEvent>((event, emit) async {
      emit(DetailTransactionLoading());
      try{
        detailTransactionModelClass = await transactionApi.DetailTransactionFunction(id: event.id, organisation: event.organisation);

        emit(DetailTransactionLoaded());
      }catch(e){
        emit(DetailTransactionError());

      }
    });



    on<FetchEditTransactionEvent>((event, emit) async {
      emit(EditTransactionLoading());
      try{
editTransactiomModelClass = await transactionApi.EditTransactionFunction(
    organisation: event.organisation, date: event.date, time: event.time, fromAccount: event.fromAccount,
    fromCountry: event.fromCountry, fromAmount: event.fromAmount, toAccount: event.toAccount, toCountry: event.toCountry,
    toAmount: event.toAmount, description: event.description, id: event.id);
        emit(EditTransactionLoaded());
      }catch(e){
        emit(EditTransactionError());

      }
    });




    on<FetchDeleteTransactionEvent>((event, emit) async {
      emit(DeleteTransactionLoading());
      try{
        deleteTransactionModelClass = await transactionApi.DeleteTransactionFunction(id: event.id, organisation: event.organisation);

        emit(DeleteTransactionLoaded());
      }catch(e){
        emit(DeleteTransactionError());

      }
    });



  }
}
