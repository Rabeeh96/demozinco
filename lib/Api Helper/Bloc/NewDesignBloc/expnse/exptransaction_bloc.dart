
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../../Api_Functions/New design_ apis/api_expense.dart';
import '../../../ModelClasses/New Design ModelClass/exp/TransactionExpenseModelClass.dart';

part 'exptransaction_event.dart';
part 'exptransaction_state.dart';

class ExptransactionBloc extends Bloc<ExptransactionEvent, ExptransactionState> {
  late  TransactionExpenseModelClass transactionExpenseModelClass;
  ApiExpense apiExpense;
  ExptransactionBloc(this.apiExpense) : super(ExptransactionInitial()) {
    on<FetchExpTransactionEvent>((event, emit)async {
      emit(ExpTransactionLoading());
      try{
        transactionExpenseModelClass =  await apiExpense.transactionExpenseFunction(fromDate: event.fromDate, toDate: event.toDate);

        emit(ExpTransactionLoaded());


      }catch(e){
        emit(ExpTransactionError());

      }
    });





  }
}
