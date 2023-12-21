part of 'default_country_list_bloc.dart';

@immutable
abstract class DefaultCountryListState {}

class DefaultCountryListInitial extends DefaultCountryListState {}
class CountryDefaultLoading extends DefaultCountryListState {}
class CountryDefaultLoaded extends DefaultCountryListState {}
class CountryDefaultError extends DefaultCountryListState {}


class DefaultCountryLoading extends DefaultCountryListState {}
class DefaultCountryLoaded extends DefaultCountryListState {}
class DefaultCountryError extends DefaultCountryListState {}
