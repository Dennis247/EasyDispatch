import 'package:flutter/material.dart';

class Dispatch {
  final String id;
  final String userId;
  final String trackingNo;
  final String dispatchRiderId;
  final DateTime dispatchDate;
  final String pickUpLocation;
  final String dispatchDestination;
  final double dispatchBaseFare;
  final double dispatchTotalFare;
  final String dispatchType;
  final String dispatchStatus;
  final String currentLocation;
  final String estimatedDIspatchDuration;
  final String estimatedDistance;
  final String dispatchReciever;
  final String dispatchRecieverPhone;
  final String dispatchDescription;
  final double destinationLatitude;
  final double destinationLongitude;
  final String paymentOption;

  Dispatch(
      {@required this.id,
      @required this.userId,
      @required this.trackingNo,
      @required this.dispatchRiderId,
      @required this.dispatchDate,
      @required this.pickUpLocation,
      @required this.dispatchDestination,
      @required this.dispatchBaseFare,
      @required this.dispatchTotalFare,
      @required this.dispatchType,
      @required this.dispatchStatus,
      @required this.currentLocation,
      @required this.estimatedDIspatchDuration,
      @required this.estimatedDistance,
      @required this.dispatchReciever,
      @required this.dispatchRecieverPhone,
      @required this.dispatchDescription,
      @required this.destinationLatitude,
      @required this.destinationLongitude,
      @required this.paymentOption});

  static List<Dispatch> dispatchtListFromJson(List collection) {
    List<Dispatch> dispatchlist =
        collection.map((json) => Dispatch.fromJson(json)).toList();
    return dispatchlist;
  }

  Dispatch.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        trackingNo = json['trackingNo'],
        dispatchRiderId = json['dispatchRiderId'],
        dispatchDate = json['dispatchDate'],
        pickUpLocation = json['pickUpLocation'],
        dispatchDestination = json['dispatchDestination'],
        dispatchBaseFare = json['dispatchBaseFare'],
        dispatchTotalFare = json['dispatchTotalFare'],
        dispatchType = json['dispatchType'],
        dispatchStatus = json['dispatchStatus'],
        currentLocation = json['currentLocation'],
        estimatedDIspatchDuration = json['estimatedDIspatchDuration'],
        estimatedDistance = json['estimatedDistance'],
        dispatchReciever = json['dispatchReciever'],
        dispatchDescription = json['dispatchDescription'],
        dispatchRecieverPhone = json['dispatchRecieverPhone'],
        destinationLatitude = json['destinationLatitude'],
        destinationLongitude = json['destinationLongitude'],
        paymentOption = json['paymentOption'];
}
