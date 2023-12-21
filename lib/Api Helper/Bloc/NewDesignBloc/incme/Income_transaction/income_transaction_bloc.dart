
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../../../Api_Functions/New design_ apis/api_income.dart';
import '../../../../ModelClasses/New Design ModelClass/incme/IncomeTransactionModelClass.dart';

part 'income_transaction_event.dart';
part 'income_transaction_state.dart';

class IncomeTransactionBloc extends Bloc<IncomeTransactionEvent, IncomeTransactionState> {
  late IncomeTransactionModelClass incomeTransactionModelClass ;
  ApiIncome apiIncome;


  IncomeTransactionBloc(this.apiIncome) : super(IncomeTransactionInitial()) {

    on<FetchIncomeTransactionEvent>((event, emit)async {
      emit(IncomeTransactionLoading());
      try{
        incomeTransactionModelClass =  await apiIncome.transactionIncomeFunction(fromDate: event.fromDate, toDate: event.toDate);

        emit(IncomeTransactionLoaded());


      }catch(e){
        emit(IncomeTransactionError());

      }
    });
  }
}
