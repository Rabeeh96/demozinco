part of 'reminder_bloc.dart';

abstract class ReminderEvent {}
class ListReminderEvent extends ReminderEvent {
  final String organization;
  final String description;
  final String date;
  final String voucher_type;
  final String amount;
  final int reminder_cycle;
  final int master_id;


  ListReminderEvent({
    required this.organization,
    required this.description,
    required this.date,
    required this.amount,
    required this.reminder_cycle,
    required this.master_id,
    required this.voucher_type


  });}