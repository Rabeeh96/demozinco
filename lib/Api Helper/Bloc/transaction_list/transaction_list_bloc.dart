import 'package:bloc/bloc.dart';

import '../../Api_Functions/Dashboard_Detail/transaction_detail.dart';
import '../../ModelClasses/transfer_list/transfer_list_model.dart';
import 'transaction_list_event.dart';
import 'transaction_list_state.dart';


import '../../ModelClasses/dashboard_detail_model/DeleteTransferList.dart';

class Transaction_listBloc
    extends Bloc<Transaction_listEvent, Transaction_listState> {
  late TransactionListModelClass transactionListModelClass;
  late DeleteTransferList deleteTransferList;
  TransactionListApi transactionListApi;

  Transaction_listBloc(this.transactionListApi) : super(TransferListInitial()) {
    on<TransferListEventEvent>((event, emit) async {
      emit(TransferListLoading());
      try {
        transactionListModelClass =
            await transactionListApi.transferListFunction(
                organisationId: event.organisation,
                account_id: event.account_id,
              toDate: event.toDate,
              fromDate: event.fromDate
            );
        emit(TransferListLoaded());
      } catch (e) {
        emit(TransferListError());
      }
    });

    on<DeleteTransferListEventEvent>((event, emit) async {
      emit(DeleteTransferListLoading());
      try {
        deleteTransferList =
            await transactionListApi.deleteTransferListFunction(
                organisationId: event.organisation, id: event.id);
        emit(DeleteTransferListLoaded());
      } catch (e) {
        emit(DeleteTransferListError());
      }
    });
  }
}
