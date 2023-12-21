import 'package:bloc/bloc.dart';

import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/asset%20new%20design%20api/stock_apis.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/Stock/CreateStockModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/Stock/DeleteStockModelClass.dart';
import 'package:meta/meta.dart';


import '../../../ModelClasses/asset new modelclsses/Stock/EditStockModelClass.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  late CreateStockModelClass createStockModelClass ;
 late  DeleteStockModelClass deleteStockModelClass ;
 late   EditStockModelClass editStockModelClass ;

  StockAssetApi stockAssetApi;
  StockBloc(this.stockAssetApi) : super(StockInitial()) {
    on<FetchCreateStockAssetEvent>((event, emit) async{
      emit(AssetStockCreateLoading());
      try{
        createStockModelClass = await stockAssetApi.createStockAssetFunction(assetId: event.assetId, share: event.share, value: event.value, preOwn: event.preOwn,
            asOnDate: event.asOnDate, accountId: event.accountId);

        emit(AssetStockCreateLoaded());
      }catch(e){
        emit(AssetStockCreateError());

      }




    });



    on<FetchDeleteStockEvent>((event, emit) async{
      emit(AssetStockDeleteLoading());
      try{
        deleteStockModelClass = await stockAssetApi.deleteStockAssetFunction(assetDetailId: event.assetDetailId);

        emit(AssetStockDeleteLoaded());
      }catch(e){
        emit(AssetStockDeleteError());

      }
    });

    on<FetchEditStockEvent>((event, emit) async{
      emit(AssetStockEditLoading());
      try{
        editStockModelClass = await stockAssetApi.editStockAssetFunction(
            assetId: event.assetId, share: event.share, Value: event.Value,
            pre_owned: event.pre_owned, as_on_date: event.as_on_date, account_id: event.account_id, asset_detail_id: event.asset_detail_id);

        emit(AssetStockEditLoaded());
      }catch(e){
        emit(AssetStockEditError());

      }
    });

  }
}
