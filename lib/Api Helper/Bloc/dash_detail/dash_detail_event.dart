abstract class Dash_detailEvent {}


class DashDetailEvent extends Dash_detailEvent {
  final String organisationId;
  final String id;
  DashDetailEvent({required this.organisationId, required this.id});
}

class DeleteDashAccountEvent extends Dash_detailEvent {
  final String organisation;
  final String account_id;


  DeleteDashAccountEvent(
      {required this.organisation,
        required this.account_id,
      });
}
