part of 'income_bloc.dart';

@immutable
abstract class IncomeEvent {}
class CreateIncomeEvent extends IncomeEvent {
  final  bool isInterest;
  final  bool is_zakath;
  final String date;
  final String time;
  final String organization;
  final String from_account;
  final String to_account;
  final String amount;
  final String description;
  final int finance_type;

  CreateIncomeEvent(
      {required this.isInterest,
      required this.is_zakath,
      required this.date,
      required this.time,
      required this.organization,
      required this.from_account,
      required this.to_account,
      required this.amount,
      required this.description,
      required this.finance_type});

}
class ListIncomeEvent extends IncomeEvent {
  final String organization;
  final String search;
  final int financeType;
  ListIncomeEvent({required this.organization,
        required this.search,
    required this.financeType
  });}


class DetailsIncomeEvent extends IncomeEvent {
  final String organization;
  final String id;


  DetailsIncomeEvent({required this.organization,
    required this.id,

  });}


class EditIncomeEvent extends IncomeEvent {
  final  bool isInterest;
  final  bool is_zakath;
  final String date;
  final String time;
  final String organization;
  final String from_account;
  final String to_account;
  final String amount;
  final String description;
  final String id;
  final int finance_type;

  EditIncomeEvent(
      {required this.isInterest,
        required this.is_zakath,
        required this.date,
        required this.time,
        required this.organization,
        required this.from_account,
        required this.to_account,
        required this.amount,
        required this.description,
        required this.id,
        required this.finance_type});

}
class DeleteIncomeEvent extends IncomeEvent {
  final String organization;
  final String id;
  DeleteIncomeEvent({required this.organization,
    required this.id,});}