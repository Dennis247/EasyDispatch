import 'package:flutter/material.dart';

class PlaceDistanceTime {
  final String destinationAddress;
  final String originAddress;
  final String distance;
  final String duration;

  PlaceDistanceTime(
      {@required this.destinationAddress,
      @required this.originAddress,
      @required this.distance,
      @required this.duration});

  PlaceDistanceTime.fromJson(Map<String, dynamic> json)
      : this.destinationAddress = json['destination_addresses'][0],
        this.distance = json['rows'][0]['elements'][0]['distance']['text'],
        this.originAddress = json['origin_addresses'][0],
        this.duration = json['rows'][0]['elements'][0]['duration']['text'];
}
