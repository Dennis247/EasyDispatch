import 'package:flutter/material.dart';

class DeviceToken {
  final String token;
  DeviceToken(this.token);
}

class DispatchNotification {
  final String id;
  final String message;
  final String dispatchId;
  final String userId;
  final String riderId;
  final String notificationType;
  final String pickUp;
  final DateTime notificationDate;
  final String recipientPhone;
  final bool isNotificationSent;
  final bool isUserNotification;
  final String tokens;

  DispatchNotification(
      {@required this.id,
      @required this.message,
      @required this.dispatchId,
      @required this.userId,
      @required this.riderId,
      @required this.notificationType,
      @required this.pickUp,
      @required this.recipientPhone,
      @required this.isNotificationSent,
      @required this.isUserNotification,
      @required this.notificationDate,
      @required this.tokens});

  static List<DispatchNotification> nottificationtListFromJson(
      List collection) {
    List<DispatchNotification> notifications =
        collection.map((json) => DispatchNotification.fromJson(json)).toList();
    return notifications;
  }

  DispatchNotification.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        message = json['message'],
        dispatchId = json['dispatchId'],
        userId = json['userId'],
        riderId = json['riderId'],
        notificationType = json['notificationType'],
        pickUp = json['pickUp'],
        recipientPhone = json['recipientPhone'],
        isNotificationSent = json['isNotificationSent'],
        isUserNotification = json['isUserNotification'],
        notificationDate = json['notificationDate'],
        tokens = json['tokens'];
}
