
import 'package:bloc/bloc.dart';

import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/dashboard/dashboard.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/dashboard/ModelClassDashboard.dart';
import 'package:meta/meta.dart';


part 'dash_board_event.dart';
part 'dash_board_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
 late ModelClassDashboard modelClassDashboard ;
 DashBoardApi dashBoardApi;
  DashBoardBloc(this.dashBoardApi) : super(DashBoardInitial()) {
    on<DashBoardEvent>((event, emit) async{
      emit(DashBoardLoading());
      try{
        modelClassDashboard = await dashBoardApi.dashBoardFunction();
      emit(DashBoardLoaded());
      }catch(e){
        emit(DashBoardError());


      }

    });
  }
}
