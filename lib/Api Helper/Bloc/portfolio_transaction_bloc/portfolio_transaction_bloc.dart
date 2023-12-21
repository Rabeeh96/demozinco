import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../Api_Functions/asset new design api/asset_api.dart';
import '../../ModelClasses/asset new modelclsses/TransactionAssetModelClass.dart';

part 'portfolio_transaction_event.dart';
part 'portfolio_transaction_state.dart';

class PortfolioTransactionBloc extends Bloc<PortfolioTransactionEvent, PortfolioTransactionState> {
  AssetApi assetApi;
  late   TransactionAssetModelClass transactionAssetModelClass ;


  PortfolioTransactionBloc(this.assetApi) : super(PortfolioTransactionInitial()) {
    on<FetchTransactionAssetEvent>((event, emit) async{
      emit(AssetTransactionLoading());
      try{
        transactionAssetModelClass = await assetApi.transactionAssetFunction(masterId: event.masterId, fromDate: event.fromDate, toDate: event.toDate);

        emit(AssetTransactionLoaded());
      }catch(e){
        emit(AssetTransactionError());

      }

    });
  }
}
