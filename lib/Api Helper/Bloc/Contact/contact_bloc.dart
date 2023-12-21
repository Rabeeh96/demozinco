import 'package:bloc/bloc.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/Contact/contact.dart';
import 'package:meta/meta.dart';


import '../../ModelClasses/contact/CreateContactModelClass.dart';
import '../../ModelClasses/contact/DetailContactModelClass.dart';
import '../../ModelClasses/contact/EditContactModelClass.dart';
import '../../ModelClasses/contact/ListContactModelClass.dart';
import '../../ModelClasses/contact/delete_contactModelClass.dart';


part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  late CreateContacModelClass createContactModelClass;
  late EditContactModelClass editContactModelClass;
  late DeleteContactModel deleteContactModelClass;

  late ListContactModelClass listContactModelClass;
   late  DetailContactModelClass detailContactModelClass ;


  ContactApi contactApi;

  ContactBloc(this.contactApi) : super(ContactInitial()) {
    on<ContactEvent>((event, emit) {
      // TODO: implement event handler0
    });
    on<CreateContactEvent>((event, emit) async {
      emit(CreateContactLoading());
      try {
        createContactModelClass = await contactApi.contactCreateFunction(
            organisation: event.organisation,
            country: event.country,
            accountName: event.accountName,
            phone:event.phone,
            amount: event.amount,
            address_name: event.address_name,
            building_name: event.building_name,
            land_mark: event.land_mark,
            state: event.state,
            pin_code: event.pin_code);
        emit(CreateContactLoaded());
      } catch (e) {
        emit(CreateContactError());
      }
    });

    ///list
    on<ListContactEvent>((event, emit) async {
      emit(ListContactLoading());
      try {
        listContactModelClass = await contactApi.contacttListFunction(
            organisation: event.organisation,
            page_number: event.page_number,
            page_size: event.page_size,
            search: event.search);
        emit(ListContactLoaded());
      } catch (e) {
        emit(ListContactError());
      }
    });
    ///edit
    on<EditContactEvent>((event, emit) async {
      emit(EditContactLoading());

      try {
        editContactModelClass = await contactApi.contactEditFunction(
            organisation: event.organisation,
            country: event.country,
            accountName: event.accountName,
            phone:event.phone,
            amount: event.amount,
            address_name: event.address_name,
            building_name: event.building_name,
            land_mark: event.land_mark,
            state: event.state,
            pin_code: event.pin_code, id: event.id);
        emit(EditContactLoaded());
      } catch (e) {
        emit(EditContactError());
      }
    });


    on<DetailContactEvent>((event, emit) async {
      emit(DetailsContactLoading());

      try {
        detailContactModelClass = await contactApi.contactDetailFunction(
            organisationId: event.organisationId, id: event.id);
        emit(DetailsContactLoaded());
      } catch (e) {
        emit(DetailsContactError());
      }
    });



    on<DeleteContactEvent>((event, emit) async {
      emit(DeleteContactLoading());

      try {
        deleteContactModelClass = await contactApi.contactDeleteFunction(
            organisationId: event.organisationId, id: event.id);
        emit(DeleteContactLoaded());
      } catch (e) {
        emit(DeleteContactError());
      }
    });
  }
}
