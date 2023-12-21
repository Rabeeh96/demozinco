import 'package:bloc/bloc.dart';

import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/SettingsApi/CountryApi/country_api.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Country/CreateCountryModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Country/DeleteCountryModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Country/DetailCountryModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Country/EditCountryModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Country/ListCountryModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Country/SetAsDefaultCountryModelClass.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utilities/global/variables.dart';


part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
late  ListCountryModelClass listCountryModelClass ;
 late DetailCountryModelClass detailCountryModelClass ;
  late EditCountryModelClass editCountryModelClass;
late  DeleteCountryModelClass deleteCountryModelClass;
late  CreateCountryModelClass createCountryModelClass;
late SetAsDefaultCountryModelClass setAsDefaultCountryModelClass;
CountryApi countryApi;

CountryBloc(this.countryApi) : super(CountryInitial()) {
    on<CreateCountryEvent>((event, emit) async{
      emit(CreateCountryLoading());
      try{
        createCountryModelClass = await countryApi.createCountryList(organisation: event.organisation, country: event.country);
        emit(CreateCountryLoaded());
      }catch(e){
        emit(CreateCountryError());

      }
    });

    on<ListCountryEvent>((event, emit) async{
      emit(ListCountryLoading());
      try{
        listCountryModelClass = await countryApi.listCountryList(organisation: event.organisation, search:event.search);
        emit(ListCountryLoaded());
      }catch(e){
        emit(ListCountryError());

      }
    });
    on<DetailCountryEvent>((event, emit) async{
      emit(DetailCountryLoading());
      try{
        detailCountryModelClass = await countryApi.detailCountryList(organisation: event.organisation, id: event.id);
        emit(DetailCountryLoaded());
      }catch(e){
        emit(DetailCountryError());
      }
    });
    on<EditCountryEvent>((event, emit) async{
      emit(EditCountryLoading());
      try{
        editCountryModelClass = await countryApi.editCountryList(organisation:event. organisation, country: event.country, id: event.id);
        emit(EditCountryLoaded());
      }catch(e){
        emit(EditCountryError());
      }
    });
    on<DeleteCountryEvent>((event, emit) async{
      emit(DeleteCountryLoading());
      try{
        deleteCountryModelClass = await countryApi.deleteCountryList(organisation: event.organisation, id: event.id);
        emit(DeleteCountryLoaded());
      }catch(e){
        emit(DeleteCountryError());
      }
    });

    on<SetAsDefaultCountryEvent>((event, emit) async{
      emit(SetAsDefaultCountryLoading());
      try{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("currency_symbol",event.currency);
        prefs.setString("default_country",event.countryName);
        prefs.setString("default_country_id",event.id);
        prefs.setString("country_id",event.id);
        prefs.setString("default_country_code",event.currencyCode);


          countryCurrencyCode = event.currency;
          default_country_name = event.countryName;
          default_country_id = event.id;
          countryShortCode = event.currencyCode;

        setAsDefaultCountryModelClass = await countryApi.setAsDefaultCountryFunction(isDefault: event.isDefault, id: event.id);
        emit(SetAsDefaultCountryLoaded());
      }catch(e){
        emit(SetAsDefaultCountryError());

      }
    });


  }
}
