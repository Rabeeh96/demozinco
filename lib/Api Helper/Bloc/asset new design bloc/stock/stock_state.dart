part of 'stock_bloc.dart';

@immutable
abstract class StockState {}

class StockInitial extends StockState {}
class AssetStockCreateLoading extends StockState {}
class AssetStockCreateLoaded extends StockState {}
class AssetStockCreateError extends StockState {}


class AssetStockDeleteLoading extends StockState {}
class AssetStockDeleteLoaded extends StockState {}
class AssetStockDeleteError extends StockState {}

class AssetStockEditLoading extends StockState {}
class AssetStockEditLoaded extends StockState {}
class AssetStockEditError extends StockState {}
