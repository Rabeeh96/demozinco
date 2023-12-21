part of 'portfolio_transaction_bloc.dart';

@immutable
abstract class PortfolioTransactionState {}

class PortfolioTransactionInitial extends PortfolioTransactionState {}

class AssetTransactionLoading extends PortfolioTransactionState {}
class AssetTransactionLoaded extends PortfolioTransactionState {}
class AssetTransactionError extends PortfolioTransactionState {}
