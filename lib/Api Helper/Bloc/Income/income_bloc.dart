import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../Api_Functions/Income/income_api.dart';
import '../../ModelClasses/Income/CreateIncomeModelClass.dart';
import '../../ModelClasses/Income/DeleteIncomeModelClass.dart';
import '../../ModelClasses/Income/DetailsIncomeModelClass.dart';
import '../../ModelClasses/Income/EditIncomeModelClass.dart';
import '../../ModelClasses/Income/ListIncomeModelClass.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
 late CreateIncomeModelClass createIncomeModelClass ;
 late  ListIncomeModelClass listIncomeModelClass ;
 late DetailsIncomeModelClass detailsIncomeModelClass ;
 late EditIncomeModelClass editIncomeModelClass ;
 late DeleteIncomeModelClass deleteIncomeModelClass ;
 IncomeApi incomeApi;
  IncomeBloc(this.incomeApi) : super(IncomeInitial()) {

    on<CreateIncomeEvent>((event, emit) async{
      emit(IncomeCreateLoading());
      try{
        createIncomeModelClass = await incomeApi.CreateIncomeFunction(
            isInterest: event.isInterest, is_zakath: event.is_zakath, date: event.date,
            time: event.time, organization: event.organization, from_account: event.from_account,
            to_account: event.to_account, amount: event.amount, description: event.description, finance_type: event.finance_type);

        emit(IncomeCreateLoaded());
      }catch(e){
        emit(IncomeCreateError());

      }

    });
    on<ListIncomeEvent>((event, emit) async{
      emit(IncomeListLoading());
      try{
        listIncomeModelClass = await incomeApi.ListIncomeFunction(search: event.search,
            organization: event.organization, financeType: event.financeType);

        emit(IncomeListLoaded());
      }catch(e){
        emit(IncomeListError());

      }

    });
    on<DetailsIncomeEvent>((event, emit) async{
      emit(DetailIncomeLoading());
      try{
        detailsIncomeModelClass = await incomeApi.DetailIncomeFunction(id: event.id, organization: event.organization);

        emit(DetailIncomeLoaded());
      }catch(e){
        emit(DetailIncomeError());

      }

    });
    on<EditIncomeEvent>((event, emit) async{
      emit(EditIncomeLoading());
      try{
        editIncomeModelClass = await incomeApi.EditIncomeFunction(isInterest:
        event.isInterest, is_zakath: event.is_zakath, date: event.date,
            time: event.time, organization: event.organization, from_account: event.from_account,
            to_account: event.to_account, amount: event.amount, description: event.description, id: event.id, finance_type: event.finance_type);

        emit(EditIncomeLoaded());
      }catch(e){
        emit(EditIncomeError());

      }

    });

    on<DeleteIncomeEvent>((event, emit) async{
      emit(DeleteIncomeLoading());
      try{
        deleteIncomeModelClass = await incomeApi.DeleteIncomeFunction(id: event.id, organization: event.organization);

        emit(DeleteIncomeLoaded());
      }catch(e){
        emit(DeleteIncomeError());

      }

    });


  }
}
