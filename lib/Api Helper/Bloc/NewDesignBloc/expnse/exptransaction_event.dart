part of 'exptransaction_bloc.dart';

@immutable
abstract class ExptransactionEvent {}

class FetchExpTransactionEvent extends ExptransactionEvent {final String fromDate;
final String toDate;
FetchExpTransactionEvent(
    {required this.fromDate,required this.toDate});
}


