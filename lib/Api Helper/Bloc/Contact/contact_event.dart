part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

class ListContactEvent extends ContactEvent {
  final String organisation;
  final int page_number;
  final int page_size;
  final String search;

  ListContactEvent(
      {required this.organisation,
        required this.page_number,
        required this.page_size,
        required this.search});
}

class CreateContactEvent extends ContactEvent {
  final String organisation;
  final String country;
  final String accountName;

  final String amount;
  final String address_name;
  final String building_name;
  final String land_mark;
  final String state;
  final String pin_code;
  final String phone;

  CreateContactEvent({
    required this.organisation,
    required this.country,
    required this.accountName,

    required this.amount,
    required this.address_name,
    required this.building_name,
    required this.land_mark,
    required this.state,
    required this.pin_code, required String photo,
    required this.phone
  });
}

class ListCountryEvent extends ContactEvent {
  final String organisation;
  final String search;
  ListCountryEvent({required this.organisation, required this.search});
}

class EditContactEvent extends ContactEvent {
  final String organisation;
  final String country;
  final String accountName;
  final String amount;
  final String address_name;
  final String building_name;
  final String land_mark;
  final String state;
  final String pin_code;
  final String id;
  final String photo;
  final String phone;

  EditContactEvent({
    required this.organisation,
    required this.country,
    required this.accountName,
    required this.amount,
    required this.address_name,
    required this.building_name,
    required this.land_mark,
    required this.state,
    required this.pin_code,
    required this.id,
    required this.photo,
    required this.phone

  });
}

class DeleteContactEvent extends ContactEvent {
  final String organisationId;
  final String id;
  DeleteContactEvent({required this.organisationId, required this.id});
}

class DetailContactEvent extends ContactEvent {
  final String organisationId;
  final String id;
  DetailContactEvent({required this.organisationId, required this.id});
}