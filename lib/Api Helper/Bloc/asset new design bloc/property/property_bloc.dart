
import 'package:bloc/bloc.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/asset%20new%20design%20api/property_api.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/property/DeletePropertyModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/property/EditPropertyModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/asset%20new%20modelclsses/property/PropertCreateModelClass.dart';
import 'package:meta/meta.dart';

part 'property_event.dart';
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
 late PropertCreateModelClass propertCreateModelClass ;
 //
late  DeletePropertyModelClass deletePropertyModelClass;

  late EditPropertyModelClass editPropertyModelClass;

  PropertyAssetApi propertyAssetApi;
  PropertyBloc(this.propertyAssetApi) : super(PropertyInitial()) {
    on<FetchCreatePropertyAssetEvent>((event, emit) async{
      emit(AssetPropertyCreateLoading());
      try{
        propertCreateModelClass = await propertyAssetApi.createPropertyAssetFunction(assetMasterId: event.assetMasterId, propertyName:  event.propertyName, value:  event.value);

        emit(AssetPropertyCreateLoaded());
      }catch(e){
        emit(AssetPropertyCreateError());

      }




    });



    on<FetchDeletePropertyEvent>((event, emit) async{
      emit(AssetPropertyDeleteLoading());
      try{
        deletePropertyModelClass = await propertyAssetApi.deletePropertyAssetFunction(property_id:  event.propertyId);

        emit(AssetPropertyDeleteLoaded());
      }catch(e){
        emit(AssetPropertyDeleteError());

      }
    });


    on<FetchEditPropertyEvent>((event, emit) async{
      emit(AssetPropertyEditLoading());
      try{
        editPropertyModelClass = await propertyAssetApi.editStockAssetFunction(
            property_name: event.property_name, property_value: event.property_value, property_id: event.property_id);

        emit(AssetPropertyEditLoaded());
      }catch(e){
        emit(AssetPropertyEditError());

      }
    });

  }
}
