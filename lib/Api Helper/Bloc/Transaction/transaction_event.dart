part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {}

class FetchCreateTransactionEvent extends TransactionEvent{
  final String organisation;
  final String date;
  final String time;
  final String fromAccount;
  final String fromCountry;
  final String fromAmount;
  final String toAccount;
  final String toCountry;
  final String toAmount;
  final String description;

  FetchCreateTransactionEvent(
      {required this.organisation,
      required this.date,
      required this.time,
      required this.fromAccount,
      required this.fromCountry,
      required this.fromAmount,
      required this.toAccount,
      required this.toCountry,
      required this.toAmount,
      required this.description});
}


class FetchListTransactionEvent extends TransactionEvent{
  final String organisation;
  final String search;
  FetchListTransactionEvent({required this.organisation,required this.search});
}


class FetchDetailTransactionEvent extends TransactionEvent{
  final String organisation;
  final String id;
  FetchDetailTransactionEvent({required this.organisation,required this.id});
}


class FetchEditTransactionEvent extends TransactionEvent{
  final String organisation;
  final String date;
  final String time;
  final String fromAccount;
  final String fromCountry;
  final String fromAmount;
  final String toAccount;
  final String toCountry;
  final String toAmount;
  final String description;
  final String id;

  FetchEditTransactionEvent(
      {required this.organisation,
        required this.date,
        required this.time,
        required this.fromAccount,
        required this.fromCountry,
        required this.fromAmount,
        required this.toAccount,
        required this.toCountry,
        required this.toAmount,
        required this.description,
        required this.id,
      });
}



class FetchDeleteTransactionEvent extends TransactionEvent{
  final String organisation;
  final String id;
  FetchDeleteTransactionEvent({required this.organisation,required this.id});
}