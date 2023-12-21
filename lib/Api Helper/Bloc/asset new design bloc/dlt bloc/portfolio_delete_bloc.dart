import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Api_Functions/asset new design api/asset_api.dart';
import '../../../ModelClasses/asset new modelclsses/AssetDeleteModelClass.dart';


part 'portfolio_delete_event.dart';
part 'portfolio_delete_state.dart';

class PortfolioDeleteBloc extends Bloc<PortfolioDeleteEvent, PortfolioDeleteState> {
  late  AssetDeleteModelClass assetDeleteModelClass;
  AssetApi assetApi;


  PortfolioDeleteBloc(this.assetApi) : super(PortfolioDeleteInitial()) {
    on<FetchPortfolioDeleteEvent>((event, emit) async{
      emit(PortfolioDeleteLoading());
      try{
        assetDeleteModelClass = await assetApi.DeleteAssetFunction(organization: event.organisation, id: event.id);

        emit(PortfolioDeleteLoaded());
      }catch(e){
        emit(PortfolioDeleteError());

      }

    });
  }
}
