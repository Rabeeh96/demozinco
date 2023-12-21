part of 'stock_bloc.dart';

@immutable
abstract class StockEvent {}

class FetchCreateStockAssetEvent extends StockEvent {
  final String assetId;
  final String share;
  final String value;
  final bool preOwn;
  final String asOnDate;
  final String accountId;

  FetchCreateStockAssetEvent({
    required this.assetId,
    required this.share,
    required this.value,
    required this.preOwn,
    required this.asOnDate,
    required this.accountId,

  });}
class FetchDeleteStockEvent extends StockEvent {

  final String assetDetailId;

  FetchDeleteStockEvent({required this.assetDetailId});
}

class FetchEditStockEvent extends StockEvent {

  final String assetId;
  final String share;
  final String Value;
  final bool pre_owned;
  final String as_on_date;
  final String account_id;
  final String asset_detail_id;

  FetchEditStockEvent(
      {required this.assetId,
     required this.share,
     required this.Value,
    required  this.pre_owned,
    required  this.as_on_date,
    required  this.account_id,
    required  this.asset_detail_id,
      });

}
