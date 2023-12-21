
abstract class Transaction_listEvent {}




class TransferListEventEvent extends Transaction_listEvent {
  final String organisation;
  final String account_id;
  final String toDate;
  final String fromDate;


  TransferListEventEvent(
      {required this.organisation,
        required this.account_id,
        required this.toDate,
        required this.fromDate
      });
}

class DeleteTransferListEventEvent extends Transaction_listEvent {
  final String organisation;
  final String id;


  DeleteTransferListEventEvent(
      {required this.organisation,
        required this.id,
      });
}