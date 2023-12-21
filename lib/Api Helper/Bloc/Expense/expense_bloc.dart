import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Api_Functions/Expense/expense_api.dart';
import '../../ModelClasses/Expense/DeleteExpenseModelClass.dart';
import '../../ModelClasses/Expense/ExpenseCreateModelClass.dart';
import '../../ModelClasses/Expense/ExpenseDetailModelClass.dart';
import '../../ModelClasses/Expense/ExpenseEditModelClass.dart';
import '../../ModelClasses/Expense/ListExpenseModelClass.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
 late ExpenseCreateModelClass expenseCreateModelClass;
 late ListExpenseModelClass listExpenseModelClass ;
 late  ExpenseDetailModelClass expenseDetailModelClass ;
 late ExpenseEditModelClass expenseEditModelClass ;
 late DeleteExpenseModelClass deleteExpenseModelClass ;
  ExpenseApi expenseApi;
  ExpenseBloc(this.expenseApi) : super(ExpenseInitial()) {
    on<CreateExpenseEvent>((event, emit) async{
      emit(ExpenseCreateLoading());
      try{
        expenseCreateModelClass = await expenseApi.CreateExpenseFunction(
            isInterest: event.isInterest, is_zakath: event.is_zakath, date: event.date,
            time: event.time, organization: event.organization, from_account: event.from_account,
            to_account: event.to_account, amount: event.amount, description: event.description, finance_type: event.finance_type);

        emit(ExpenseCreateLoaded());
      }catch(e){
        emit(ExpenseCreateError());
      }
    });
    on<ListExpenseEvent>((event, emit) async{
      emit(ExpenseListLoading());
      try{
        listExpenseModelClass = await expenseApi.ListExpenseFunction(search: event.search, organization: event.organization, financeType: event.financeType);
        emit(ExpenseListLoaded());
      }catch(e){
        emit(ExpenseListError());
      }
    });
    on<DetailsExpenseEvent>((event, emit) async{
      emit(DetailExpenseLoading());
      try{
        expenseDetailModelClass = await expenseApi.DetailExpenseFunction(id: event.id, organization: event.organization);

        emit(DetailExpenseLoaded());
      }catch(e){
        emit(DetailExpenseError());

      }

    });
    on<EditExpenseEvent>((event, emit) async{
      emit(EditExpenseLoading());
      try{
        expenseEditModelClass = await expenseApi.EditExpenseFunction(isInterest:
        event.isInterest, is_zakath: event.is_zakath, date: event.date,
            time: event.time, organization: event.organization, from_account: event.from_account,
            to_account: event.to_account, amount: event.amount, description: event.description, id: event.id, finance_type: event.finance_type);

        emit(EditExpenseLoaded());
      }catch(e){
        emit(EditExpenseError());

      }

    });

    on<DeleteExpenseEvent>((event, emit) async{
      emit(DeleteExpenseLoading());
      try{
        deleteExpenseModelClass = await expenseApi.DeleteExpenseFunction(id: event.id, organization: event.organization);

        emit(DeleteExpenseLoaded());
      }catch(e){
        emit(DeleteExpenseError());

      }

    });


  }
}

