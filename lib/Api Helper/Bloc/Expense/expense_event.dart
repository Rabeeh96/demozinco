part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent {}
class CreateExpenseEvent extends ExpenseEvent {
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

  CreateExpenseEvent(
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
class ListExpenseEvent extends ExpenseEvent {
  final String organization;
  final String search;
  final int financeType;
  ListExpenseEvent({required this.organization,
    required this.search,
    required this.financeType
  });}


class DetailsExpenseEvent extends ExpenseEvent {
  final String organization;
  final String id;
  DetailsExpenseEvent({required this.organization,
    required this.id,});}


class EditExpenseEvent extends ExpenseEvent {
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

  EditExpenseEvent(
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
class DeleteExpenseEvent extends ExpenseEvent {
  final String organization;
  final String id;
  DeleteExpenseEvent({required this.organization,
    required this.id,});}
