part of 'default_country_list_bloc.dart';

@immutable
abstract class DefaultCountryListEvent {}
class FetchDetailCountryEvent extends DefaultCountryListEvent{
  final String search;

  FetchDetailCountryEvent({required this.search});
}
class FetchDefaultCountryEvent extends DefaultCountryListEvent{
  final String search;

  FetchDefaultCountryEvent({required this.search});
}