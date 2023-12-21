// import 'package:bloc/bloc.dart';
// import 'package:zinco/Api%20Helper/ModelClasses/new_transferList/NewTransferListModel.dart';
//
// import '../../Api_Functions/NewTransferList/new_trnasfer_listApi.dart';
// import 'new_transfer_bloc_event.dart';
// import 'new_transfer_bloc_state.dart';
//
// class NewTransferBlocBloc extends Bloc<NewTransferBlocEvent, NewTransferBlocState> {
//   late NewTransferListModel newTransferListModel;
//   NewTransferListApi newTransferListApi;
//   NewTransferBlocBloc(this.newTransferListApi) : super(NewTransferInitial()) {
//
//     on<NewTransferListEvent>((event, emit) async {
//       emit(NewTransferLoading());
//
//       try {
//         newTransferListModel = await newTransferListApi.newTransferListFunction(
//             organisationId: event.organisationId);
//         emit(NewTransferLoaded());
//       } catch (e) {
//         emit(NewTransferError());
//         print("________details bloc catch error ______________$e");
//       }
//     });
//
//
//
//   }
//
//
//
// }
