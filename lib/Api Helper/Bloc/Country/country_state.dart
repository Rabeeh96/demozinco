part of 'country_bloc.dart';

@immutable
abstract class CountryState {}

class CountryInitial extends CountryState {}
class CreateCountryLoading extends CountryState {}
class CreateCountryLoaded extends CountryState {}
class CreateCountryError extends CountryState {}
class ListCountryLoading extends CountryState {}
class ListCountryLoaded extends CountryState {}
class ListCountryError extends CountryState {}
class DetailCountryLoading extends CountryState {}
class DetailCountryLoaded extends CountryState {}
class DetailCountryError extends CountryState {}
class EditCountryLoading extends CountryState {}
class EditCountryLoaded extends CountryState {}
class EditCountryError extends CountryState {}
class DeleteCountryLoading extends CountryState {}
class DeleteCountryLoaded extends CountryState {}
class DeleteCountryError extends CountryState {}
class SetAsDefaultCountryLoading extends CountryState {}
class SetAsDefaultCountryLoaded extends CountryState {}
class SetAsDefaultCountryError extends CountryState {}