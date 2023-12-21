
abstract class AssetEvent {}

class InitEvent extends AssetEvent {}
class ListAssetEvent extends AssetEvent {
  final String organization;
  final String  search;
  final int  pageNumber;
  final int  page_size;

  ListAssetEvent({
    required this.organization,
    required this.search,
    required this.pageNumber,
    required this.page_size,

  });}
class DeleteAssetEvent extends AssetEvent {
  final String organisation;

  final String id;

  DeleteAssetEvent({required this.organisation,required this.id});
}



class FetchOverViewAssetEvent extends AssetEvent {

  final String id;

  FetchOverViewAssetEvent({required this.id});
}

