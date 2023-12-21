part of 'portfolio_transaction_bloc.dart';

@immutable
abstract class PortfolioTransactionEvent {}

class FetchTransactionAssetEvent extends PortfolioTransactionEvent {

  final int masterId;
  final String fromDate;
  final String toDate;



  FetchTransactionAssetEvent({required this.masterId,required this.fromDate,required this.toDate});
}
