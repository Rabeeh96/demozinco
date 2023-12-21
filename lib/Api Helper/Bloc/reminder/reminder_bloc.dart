import 'package:bloc/bloc.dart';

import '../../Api_Functions/Reminder/reminder_api.dart';

import '../../ModelClasses/Reminder/ListReminderModelClass.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
late ListReminderModelClass listReminderModelClass;
 ReminderApi reminderApi;
 ReminderBloc(this.reminderApi) : super(ReminderInitial()) {
    on<ListReminderEvent>((event, emit) async {
      emit(ReminderListLoading());
      try{
        listReminderModelClass = await reminderApi.ListReminderFunction(description: event.description, date: event.date, organisation: event.organization, voucher_type: event.voucher_type, amount: event.amount, reminder_cycle: event.reminder_cycle, master_id: event.master_id);
        emit(ReminderListLoaded());
      }catch(e){
        emit(ReminderListError());

      }

    });


  }
}
