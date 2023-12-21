
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import '../../../Api Helper/ModelClasses/contact/ListContactModelClass.dart';
import '../api.dart';

part 'pagination_contact_event.dart';
part 'pagination_contact_state.dart';

class PaginationContactBloc extends Bloc<PaginationContactEvent, PaginationContactState> {
  ListContactModelClass listContactModelClass = ListContactModelClass();
  PaginationContactApi paginationContactApi;
  late  Response response ;



  PaginationContactBloc(this.paginationContactApi) : super(PaginationContactInitial()) {

    on<InitialListEvent>((event, emit) async{
      emit(ListPaginationContactLoading());      try{
        response  = await paginationContactApi.contacttListFunction(organisation: event.organisation,
            page_number: 1, page_size: 2, search: event.search);
        emit(ListPaginationContactLoaded());
      }catch(e){
        emit(ListPaginationContactError());
      }

    });
    on<ListContactPaginationEvent>((event, emit) async {

      try {
         response = await paginationContactApi.contacttListFunction(
          organisation: event.organisation,
          page_number: event.page_number,
          page_size: event.page_size,
          search: event.search,
        );

        emit(ListPaginationContactLoaded());
      } catch (e) {
        emit(ListPaginationContactError());
      }
    });
  }
}
