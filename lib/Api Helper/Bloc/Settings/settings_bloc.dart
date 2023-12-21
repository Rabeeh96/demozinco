
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../Api_Functions/SettingsApi/settings_api.dart';
import '../../ModelClasses/Settings/SettingsModelClass.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  late SettingsModelClass settingsModelClass;
  SettingsApi settingsApi;
  SettingsBloc(this.settingsApi) : super(SettingsInitial()) {
    on<FetchSettingsDetailEvent>((event, emit) async{
      final preference = await SharedPreferences.getInstance();
      emit(SettingsDetailLoading());
      try{
        settingsModelClass = await settingsApi.settingsDetailFunction();
        preference.setInt('organization_id', settingsModelClass.data!.organizationId!);
        // preference.setString('organizationUuid', settingsModelClass.data!.id!);
        // preference.setString('expiry_date', settingsModelClass.data!.expiryDate!);

        preference.setBool('is_reminder', settingsModelClass.data!.isReminder!);
        preference.setBool('is_zakath', settingsModelClass.data!.isZakath!);
        preference.setBool('is_intrest', settingsModelClass.data!.isInterest!);

        emit(SettingsDetailLoaded());
      }catch(e){
        emit(SettingsDetailError());
      }

    });
  }
}
