import 'package:flutter/material.dart';

class Rider {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String password;
  final bool hasActiveDispatch;
  final String token;
  final double latitude;
  final double longitude;

  Rider(
      {@required this.id,
      @required this.fullName,
      @required this.phoneNumber,
      @required this.email,
      @required this.password,
      @required this.hasActiveDispatch,
      @required this.token,
      @required this.latitude,
      @required this.longitude});

  static List<Rider> ridertListFromJson(List collection) {
    List<Rider> riderlist =
        collection.map((json) => Rider.fromJson(json)).toList();
    return riderlist;
  }

  Rider.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fullName = json['fullName'],
        phoneNumber = json['phoneNumber'],
        email = json['email'],
        hasActiveDispatch = json['hasActiveDispatch'],
        password = '*************',
        token = json['token'],
        latitude = json['latitude'],
        longitude = json['longitude'];
}
