part of 'country_bloc.dart';

@immutable
abstract class CountryEvent {}
class CreateCountryEvent extends CountryEvent{
  final String organisation;
  final String country;

  CreateCountryEvent({required this.organisation,required this.country});


}
class ListCountryEvent extends CountryEvent{
  final String organisation;
  final String search;
  ListCountryEvent({required this.organisation,required this.search});
}
class DetailCountryEvent extends CountryEvent{
  final String organisation;
  final String id;
  DetailCountryEvent({required this.organisation,required this.id});
}
class EditCountryEvent extends CountryEvent{
  final String organisation;
  final String country;
  final String id;
  EditCountryEvent({required this.organisation,required this.country,required this.id});
}
class DeleteCountryEvent extends CountryEvent{
  final String organisation;
  final String id;
  DeleteCountryEvent({required this.organisation,required this.id});
}
class SetAsDefaultCountryEvent extends CountryEvent{
  final bool isDefault;
  final String id;
  final String currency;
  final String countryName;
  final String currencyCode;
  SetAsDefaultCountryEvent({required this.isDefault,required this.id,required this.currency,required this.countryName,required this.currencyCode});
}

