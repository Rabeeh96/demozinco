part of 'transaction_contact_bloc.dart';

@immutable
abstract class TransactionContactEvent {}

class CreateTransactionContactEventEvent extends TransactionContactEvent {
  final String organisation;
  final String date;
  final String time;
  final String fromAccount;
  final String toAccount;
  final String reminder_date;

  final String amount;
  final String description;
  final String transactionType;
  final bool isReminder;

  CreateTransactionContactEventEvent(
      {required this.organisation,
      required this.date,
      required this.reminder_date,
      required this.time,
      required this.fromAccount,
      required this.toAccount,

      required this.amount,
      required this.description,
      required this.transactionType,
      required this.isReminder});

}
class ListTransactionContactEventEvent extends TransactionContactEvent {
  final String search;
  final String organisation;
  final String from_date;
  final String to_date;
  final String id;

  ListTransactionContactEventEvent({required this.search,required this.id,required this.organisation,required this.from_date,required this.to_date});

}
class DetailTransactionContactEventEvent extends TransactionContactEvent {
  final String id;
  final String organisation;
  DetailTransactionContactEventEvent({required this.id,required this.organisation});

}




class EditTransactionContactEventEvent extends TransactionContactEvent {
  final String organisation;
  final String date;
  final String reminder_date;
  final String time;
  final String fromAccount;
  final String toAccount;

  final String amount;
  final String description;
  final String transactionType;
  final String id;
  final bool isReminder;

  EditTransactionContactEventEvent(
      {required this.organisation,
        required this.date,
        required this.time,
        required this.fromAccount,
        required this.toAccount,
        required this.reminder_date,

        required this.amount,
        required this.description,
        required this.transactionType,
        required this.id,
        required this.isReminder});

}



class DeleteTransactionContactEventEvent extends TransactionContactEvent {
  final String id;
  final String organisation;
  DeleteTransactionContactEventEvent({required this.id,required this.organisation});

}