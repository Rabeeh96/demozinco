part of 'portfolio_delete_bloc.dart';

@immutable
abstract class PortfolioDeleteState {}

class PortfolioDeleteInitial extends PortfolioDeleteState {}

class PortfolioDeleteLoading extends PortfolioDeleteState {}
class PortfolioDeleteLoaded extends PortfolioDeleteState {}
class PortfolioDeleteError extends PortfolioDeleteState {}
