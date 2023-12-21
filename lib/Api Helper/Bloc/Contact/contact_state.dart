part of 'contact_bloc.dart';

@immutable
abstract class ContactState {}

class ContactInitial extends ContactState {}

class CreateContactLoading extends ContactState {}

class CreateContactLoaded extends ContactState {}

class CreateContactError extends ContactState {}

class ListContactLoading extends ContactState {}

class ListContactLoaded extends ContactState {}

class ListContactError extends ContactState {}

class ListCountryLoading extends ContactState {}

class ListCountryLoaded extends ContactState {}

class ListCountryError extends ContactState {}

class EditContactLoading extends ContactState {}

class EditContactLoaded extends ContactState {}

class EditContactError extends ContactState {}

class DeleteContactLoading extends ContactState {}

class DeleteContactLoaded extends ContactState {}

class DeleteContactError extends ContactState {}


class DetailsContactLoading extends ContactState {}

class DetailsContactLoaded extends ContactState {}

class DetailsContactError extends ContactState {}