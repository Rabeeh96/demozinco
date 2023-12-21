import 'package:bloc/bloc.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Settings/Country/DefaultCountryModelClass.dart';
import 'package:meta/meta.dart';


import '../../Api_Functions/SettingsApi/CountryApi/country_api.dart';

part 'default_country_list_event.dart';
part 'default_country_list_state.dart';

class DefaultCountryListBloc extends Bloc<DefaultCountryListEvent, DefaultCountryListState> {
  late DefaultCountryModelClass defaultCountryModelClass;
  CountryApi countryApi;


  DefaultCountryListBloc(this.countryApi) : super(DefaultCountryListInitial()) {
    on<FetchDetailCountryEvent>((event, emit)async {
      emit(CountryDefaultLoading());
      try{

        defaultCountryModelClass = await countryApi.defaultCountryList(Search: event.search);
        emit(CountryDefaultLoaded());
      }catch(e){
        emit(CountryDefaultError());
      }});

    on<FetchDefaultCountryEvent>((event, emit)async {
      emit(DefaultCountryLoading());
      try{

        defaultCountryModelClass = await countryApi.defaultCountry(Search: event.search);
        emit(DefaultCountryLoaded());
      }catch(e){
        emit(DefaultCountryError());
      }
    });




  }
}
