import 'package:bloc/bloc.dart';

import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/Recievables_Payables/receivables_payables.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/dashboard/PayableReceivableModelClass.dart';
import 'package:meta/meta.dart';


part 'payables_receivable_event.dart';
part 'payables_receivable_state.dart';

class PayablesReceivableBloc extends Bloc<PayablesReceivableEvent, PayablesReceivableState> {
  RecievablePayableApi recievablePayableApi;
  late  PayableReceivableModelClass payableReceivableModelClass ;
  PayablesReceivableBloc(this.recievablePayableApi) : super(PayablesReceivableInitial()) {
    on<FetchPayablesReceivableListEvent>((event, emit) async{
      emit(PayablesReceivableListLoading());
      try{
        payableReceivableModelClass = await recievablePayableApi.PayableReceivableListFunction(filter: event.filter);
        emit(PayablesReceivableListLoaded());

      }catch(e){
        emit(PayablesReceivableListError());


      }
    });
  }
}
