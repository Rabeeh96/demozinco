import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../../Api_Functions/New design_ apis/api_income.dart';
import '../../../ModelClasses/New Design ModelClass/incme/ModelClassDetailIncome.dart';
import '../../../ModelClasses/New Design ModelClass/incme/ModelClassIncome.dart';

part 'new_income_event.dart';
part 'new_income_state.dart';

class NewIncomeBloc extends Bloc<NewIncomeEvent, NewIncomeState> {
 late ModelClassIncome modelClassIncome ;
late ModelClassDetailIncome  modelClassDetailIncome ;
 ApiIncome apiIncome;

  NewIncomeBloc(this.apiIncome) : super(NewIncomeInitial()) {
    on<FetchNewIncomeOverviewEvent>((event, emit)async {
      emit(IncomeOverviewLoading());
      try{
        modelClassIncome =  await apiIncome.overviewIncomeFunction(
            fromDate: event.fromDate, toDate:  event.toDate, pageNumber:  event.pageNumber, pageSize:  event.pageSize);

        emit(IncomeOverviewLoaded());


      }catch(e){
        emit(IncomeOverviewError());

      }    });



    on<FetchNewIncomeDetailEvent>((event, emit)async {
      emit(IncomeDetailLoading());
      try{
        modelClassDetailIncome =  await apiIncome.detailIncomeFunction(accountId: event.accountId, pageNumber: event.pageNumber, pageSize: event.pageSize);

        emit(IncomeDetailLoaded());


      }catch(e){
        emit(IncomeDetailError());

      }
    });




  }
}
