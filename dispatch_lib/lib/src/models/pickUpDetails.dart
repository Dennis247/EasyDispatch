import 'package:flutter/cupertino.dart';

class PickUpDetail {
  final String id;
  final String userId;
  final String riderId;
  final String pickUpLocation;
  final String dispatchDestination;
  final DateTime pickUpDate;

  PickUpDetail(
      {@required this.id,
      @required this.userId,
      @required this.riderId,
      @required this.pickUpLocation,
      @required this.dispatchDestination,
      @required this.pickUpDate});

  static List<PickUpDetail> pickUpDetailListFromJson(List collection) {
    List<PickUpDetail> pickUpDetails =
        collection.map((json) => PickUpDetail.fromJson(json)).toList();
    return pickUpDetails;
  }

  PickUpDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['message'],
        riderId = json['message'],
        pickUpLocation = json['dispatchId'],
        dispatchDestination = json['userId'],
        pickUpDate = DateTime.parse(json['userId'].toString());
}
