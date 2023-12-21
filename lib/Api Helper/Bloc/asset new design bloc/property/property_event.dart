part of 'property_bloc.dart';

@immutable
abstract class PropertyEvent {}


class FetchCreatePropertyAssetEvent extends PropertyEvent {
  final String assetMasterId;
  final String propertyName;
  final String value;

  FetchCreatePropertyAssetEvent({
    required this.assetMasterId,
    required this.propertyName,
    required this.value,

  });}
class FetchDeletePropertyEvent extends PropertyEvent {

  final String propertyId;

  FetchDeletePropertyEvent({required this.propertyId});
}

class FetchEditPropertyEvent extends PropertyEvent {

  final String property_name;
  final String property_value;
  final String property_id;

  FetchEditPropertyEvent(
      {required this.property_name,
        required this.property_value,
        required this.property_id,

      });

}

