
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Api_Functions/New design_ apis/api_expense.dart';
import '../../../ModelClasses/New Design ModelClass/exp/DelteTransactionModelClass.dart';
import '../../../ModelClasses/New Design ModelClass/exp/ModelClassDetailExpense.dart';
import '../../../ModelClasses/New Design ModelClass/exp/ModelClassExpense.dart';
import '../../../ModelClasses/New Design ModelClass/exp/TransactionExpenseModelClass.dart';

part 'new_expense_event.dart';
part 'new_expense_state.dart';

class NewExpenseBloc extends Bloc<NewExpenseEvent, NewExpenseState> {
  late   ModelClassExpense modelClassExpense ;
late  ModelClassDetailExpense modelClassDetailExpense ;
late  TransactionExpenseModelClass transactionExpenseModelClass;
late DelteTransactionModelClass delteTransactionModelClass;
  ApiExpense apiExpense;

  NewExpenseBloc(this.apiExpense) : super(NewExpenseInitial()) {
    on<FetchNewExpenseOverviewEvent>((event, emit)async {
      emit(ExpenseOverviewLoading());
      try{
        modelClassExpense =  await apiExpense.overviewExpenseFunction(
            fromDate: event.fromDate, toDate:  event.toDate, pageNumber:  event.pageNumber, pageSize:  event.pageSize);

        emit(ExpenseOverviewLoaded());


      }catch(e){
        emit(ExpenseOverviewError());

      }
    });




    on<FetchNewExpenseDetailEvent>((event, emit)async {
      emit(ExpenseDetailLoading());
      try{
        modelClassDetailExpense =  await apiExpense.detailExpenseFunction(accountId: event.accountId, pageNumber: event.pageNumber,
            pageSize: event.pageSize, fromDate: event.fromDate, toDate: event.toDate);

        emit(ExpenseDetailLoaded());


      }catch(e){
        emit(ExpenseDetailError());

      }
    });






    on<FetchDeleteTransactionEvent>((event, emit)async {
      emit(ExpenseTransactionDeleteLoading());
      try{
        delteTransactionModelClass =  await apiExpense.deleteTransactionExpenseFunction(id: event.id);

        emit(ExpenseTransactionDeleteLoaded());


      }catch(e){
        emit(ExpenseTransactionDeleteError());

      }
    });

  }
}
