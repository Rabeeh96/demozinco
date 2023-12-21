part of 'loan_bloc.dart';

@immutable
abstract class LoanEvent {}

class CreateLoanEvent extends LoanEvent {
  final String organization;
  final String loanName;
  final String loanType;
  final String amount;
  final String date;
  final String day;
  final String interest;
  final String paymentCycle;
  final String duration;
  final String interestAmount;
  final String processingFee;
  final String totalAmount;
  final bool isManual;
  final bool isExisting;
  final String account;
  final List reminderList;

  CreateLoanEvent(
      {required this.organization,
      required this.loanName,
      required this.loanType,
      required this.amount,
      required this.interest,
      required this.day,
      required this.paymentCycle,
      required this.date,
      required this.duration,
      required this.interestAmount,
      required this.processingFee,
      required this.totalAmount,
      required this.isManual,
      required this.isExisting,
      required this.account,
      required this.reminderList});



}
class ListLoanEvent extends LoanEvent {}


class DetailsLoanEvent extends LoanEvent {
  final String organization;
  final String id;
  DetailsLoanEvent({required this.organization,
    required this.id,});}


class EditLoanEvent extends LoanEvent {
  final String organization;
  final String loanName;
  final String loanType;
  final String amount;
  final String day;
  final String interest;
  final String paymentCycle;
  final String duration;
  final String interestAmount;
  final String processingFee;
  final String totalAmount;
  final bool isManual;
  final bool isExisting;
  final String account;
  final String date;
  final String id;
  final List reminderList;

  EditLoanEvent(
      {required this.organization,
        required this.loanName,
        required this.date,
        required this.loanType,
        required this.amount,
        required this.interest,
        required this.day,
        required this.paymentCycle,
        required this.duration,
        required this.interestAmount,
        required this.processingFee,
        required this.totalAmount,
        required this.isManual,
        required this.isExisting,
        required this.account,
        required this.id,
        required this.reminderList});

}
class DeleteLoanEvent extends LoanEvent {
  final String organization;
  final String id;
  DeleteLoanEvent({required this.organization,
    required this.id,});}


class LoanViewEvent extends LoanEvent {
  final String organization;
  final String id;
  LoanViewEvent({required this.organization,
    required this.id,});}
