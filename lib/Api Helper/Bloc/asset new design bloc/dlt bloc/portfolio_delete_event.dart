part of 'portfolio_delete_bloc.dart';

@immutable
abstract class PortfolioDeleteEvent {}

class FetchPortfolioDeleteEvent extends PortfolioDeleteEvent {
  final String organisation;

  final String id;

  FetchPortfolioDeleteEvent({required this.organisation,required this.id});
}
