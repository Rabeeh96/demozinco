part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}
class CreateAccountEvent extends AccountEvent{
  final String accountName;
  final String openingBalance;
  final String organisation;
  final String country;
  final int account_type;
  final String as_on_date;

  CreateAccountEvent({required this.accountName,required this.openingBalance,required this.organisation,required this.country,required this.account_type,required this.as_on_date});


}

class ListAccountEvent extends AccountEvent{
  final String organisation;
  final int page_number;
  final int page_size;
  final String search;
  final dynamic type;
  final String country;

  ListAccountEvent({required this.organisation,required this.page_number,required this.page_size,required this.search,required this.country,required this.type});
}
class DeleteAccountEvent extends AccountEvent{
  final String id;
  final String organisation;

  DeleteAccountEvent({required this.id,required this.organisation});
}
class DetailAccountEvent extends AccountEvent{
  final String id;
  final String organisation;

  DetailAccountEvent({required this.id,required this.organisation});
}
class EditAccountEvent extends AccountEvent{
  final String id;
  final String organisation;
  final String accountName;
  final String openingBalance;
  final String country;
  final String date;
  final String accountType;

  EditAccountEvent(
      {required this.id,
      required this.organisation,
      required this.accountName,
      required this.openingBalance,
      required this.country,
      required this.date,
      required this.accountType});


}