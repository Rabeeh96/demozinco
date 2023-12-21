abstract class NewTransferBlocEvent {}

class InitEvent extends NewTransferBlocEvent {}
class NewTransferListEvent extends NewTransferBlocEvent {
  final String organisationId;

  NewTransferListEvent({required this.organisationId});
}
