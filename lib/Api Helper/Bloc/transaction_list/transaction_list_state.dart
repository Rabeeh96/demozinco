  import 'package:flutter/cupertino.dart';



  @immutable
  abstract class Transaction_listState {}

  class TransferListInitial extends Transaction_listState {}


  class TransferListLoading extends Transaction_listState {}

  class TransferListLoaded extends Transaction_listState {}

  class TransferListError extends Transaction_listState {}


  class DeleteTransferListLoading extends Transaction_listState {}

  class DeleteTransferListLoaded extends Transaction_listState {}

  class DeleteTransferListError extends Transaction_listState {}