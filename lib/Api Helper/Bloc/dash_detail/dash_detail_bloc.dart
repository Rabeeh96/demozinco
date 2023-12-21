import 'package:bloc/bloc.dart';

import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/Dashboard_Detail/dashboard_detail.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/dashboard_detail_model/DeleteAccountModel.dart';


import '../../ModelClasses/dashboard_detail_model/DashboardDEtailModel.dart';
import 'dash_detail_event.dart';
import 'dash_detail_state.dart';

class Dash_detailBloc extends Bloc<Dash_detailEvent, Dash_detailState> {
  late DashboardDEtailModel dashboradDEtailModel;
  late DeleteAccountModel deleteAccountModel;
  DashBoardDetailApi dashBoardDetailApi;

  Dash_detailBloc(this.dashBoardDetailApi) : super(DashDetailsInitial()) {

    on<DashDetailEvent>((event, emit) async {
      emit(DashDetailsLoading());

      try {
        dashboradDEtailModel = await dashBoardDetailApi.dashBoardDEtailFunction(
            organisationId: event.organisationId, id: event.id);
        emit(DashDetailsLoaded());
      } catch (e) {
        emit(DashDetailsError());
      }
    });
    on<DeleteDashAccountEvent>((event, emit) async {
      emit(DeleteDashAccountLoading());
      try {
        deleteAccountModel = await dashBoardDetailApi.deleteAccountFunction(
            organisationId: event.organisation,
            id: event.account_id
        );
        emit(DeleteDashAccountLoaded());
      } catch (e) {
        emit(DeleteDashAccountError());
      }
    });

    // on<DeleteTransferListEventEvent>((event, emit) async {
    //   emit(DeleteTransferListLoading());
    //   try {
    //     deleteTransferList = await dashBoardDetailApi.deleteTransferListFunction(
    //         organisationId: event.organisation,
    //         id: event.id
    //     );
    //     emit(DeleteTransferListLoaded());
    //   } catch (e) {
    //     emit(DeleteTransferListError());
    //     print("________create bloc catch error ______________$e");
    //   }
    // });


  }

}
