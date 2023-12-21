
import 'package:bloc/bloc.dart';

import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/dashboard/ZakathOrInterestDetailListModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/dashboard/ZakathorInterestListModelClass.dart';
import 'package:meta/meta.dart';


import '../../Api_Functions/zakath or interest/zakath_interest_api.dart';

part 'zakath_interest_list_event.dart';
part 'zakath_interest_list_state.dart';

class ZakathInterestListBloc extends Bloc<ZakathInterestListEvent, ZakathInterestListState> {
late  ZakathorInterestListModelClass zakathorInterestListModelClass ;
 late ZakathOrInterestDetailListModelClass zakathOrInterestDetailListModelClass ;
ZakathInterestApi zakathInterestApi;


  ZakathInterestListBloc(this.zakathInterestApi) : super(ZakathInterestListInitial()) {
    on<FetchInterestZakathListEvent>((event, emit) async{
      emit(ZakathInterestListLoading());
     try{
       zakathorInterestListModelClass = await zakathInterestApi.zakathInterestListFunction(filter: event.filter);
       emit(ZakathInterestListLoaded());

     }catch(e){
       emit(ZakathInterestListError());


     }
    });

    on<FetchInterestZakathDetailListEvent>((event, emit) async{
      emit(ZakathInterestDetailListLoading());
      try{
        zakathOrInterestDetailListModelClass = await zakathInterestApi.DetailZakathInterestListFunction(filter: event.filter, accountId: event.id, fromDate: event.fromDate,toDate: event.toDate);
        emit(ZakathInterestDetailListLoaded());

      }catch(e){
        emit(ZakathInterestDetailListError());


      }
    });


  }
}
