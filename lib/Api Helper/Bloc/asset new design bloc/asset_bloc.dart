import 'package:bloc/bloc.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/asset%20new%20design%20api/asset_api.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/AssetDeleteModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/AssetDetailModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/ListAssetModelClass.dart';


import 'asset_event.dart';
import 'asset_state.dart';


class AssetBloc extends Bloc<AssetEvent, AssetState> {
  late ListAssetModelClass listAssetModelClass;
  late  AssetDeleteModelClass assetDeleteModelClass;
 late DetailAssetModelClass detailAssetModelClass ;


  AssetApi assetApi;
  AssetBloc(this.assetApi) : super(AssetInitial()) {

    on<ListAssetEvent>((event, emit) async{
      emit(AssetListLoading());
      try{
        listAssetModelClass = await assetApi.ListAssetFunction( organization: event.organization, search: event.search, pageNumber: event.pageNumber, page_size:event.page_size);

        emit(AssetListLoaded());
      }catch(e){
        emit(AssetListError());

      }

    });

    on<DeleteAssetEvent>((event, emit) async{
      emit(AssetDeleteLoading());
      try{
        assetDeleteModelClass = await assetApi.DeleteAssetFunction(organization: event.organisation, id: event.id);

        emit(AssetDeleteLoaded());
      }catch(e){
        emit(AssetDeleteError());

      }

    });

    on<FetchOverViewAssetEvent>((event, emit) async{
      emit(AssetOverviewLoading());
      try{
        detailAssetModelClass = await assetApi.detailAssetFunction( id: event.id);

        emit(AssetOverviewLoaded());
      }catch(e){
        emit(AssetOverviewError());
      }
    });




  }}