import 'package:dispatch_lib/src/models/constants.dart';
import 'package:dispatch_lib/src/models/dispatch.dart';
import 'package:dispatch_lib/src/models/notification.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uuid/uuid.dart';

import 'authProvider.dart';

final notificationRef =
    FirebaseDatabase.instance.reference().child('notification');

class NotificationProvider with ChangeNotifier {
  void displayNotification(String title, String notificationMessage) async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android, iOS);
    flp.initialize(initSetttings);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'dispatch notifications',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flp.show(0, title, notificationMessage, platformChannelSpecifics,
        payload: notificationMessage);
  }

  List<DispatchNotification> getStreamDIspatchList(DataSnapshot dataSnapshot) {
    List<DispatchNotification> allNotification = [];
    Map<dynamic, dynamic> dbNotificationLIst = dataSnapshot.value;
    if (dataSnapshot.value != null) {
      dbNotificationLIst.forEach((key, value) {
        final notification = DispatchNotification(
            id: value['id'],
            message: value['message'],
            dispatchId: value['dispatchId'],
            userId: value['userId'],
            notificationType: value['notificationType'],
            pickUp: value['pickUp'],
            recipientPhone: value['recipientPhone'],
            isUserNotification: value['isUserNotification'],
            notificationDate: DateTime.parse(value['notificationDate']),
            isNotificationSent: value['isNotificationSent'],
            tokens: value['tokens'],
            riderId: value['riderId']);
        allNotification.add(notification);
      });
      allNotification =
          allNotification.where((e) => e.userId == loggedInUser.id).toList();
      allNotification
          .sort((b, a) => a.notificationDate.compareTo(b.notificationDate));
      return allNotification;
    }
    return List<DispatchNotification>();
  }

  Future<void> createCompletedNotification(Dispatch dispatch) async {
    try {
      String userToken;
      await userRef.child(dispatch.userId).once().then((dataSnapshot) {
        Map<dynamic, dynamic> snapSHotList = dataSnapshot.value;
        userToken = snapSHotList['token'];
      });
      String notificationMessage =
          Constants.completedDispatchMessage + dispatch.dispatchReciever;

      final DispatchNotification dispatchNotification =
          new DispatchNotification(
              id: Uuid().v4(),
              message: notificationMessage,
              dispatchId: dispatch.id,
              userId: dispatch.userId,
              notificationType: Constants.completedDispatchNotification,
              pickUp: dispatch.pickUpLocation,
              notificationDate: DateTime.now(),
              recipientPhone: dispatch.dispatchRecieverPhone,
              isUserNotification: false,
              isNotificationSent: false,
              tokens: userToken,
              riderId: loggedInRider.id);
      await notificationRef.child(dispatchNotification.id).set({
        "id": dispatchNotification.id,
        "message": dispatchNotification.message,
        "dispatchId": dispatchNotification.dispatchId,
        "userId": dispatchNotification.userId,
        "notificationType": dispatchNotification.notificationType,
        "pickUp": dispatchNotification.pickUp,
        "recipientPhone": dispatchNotification.recipientPhone,
        "isNotificationSent": dispatchNotification.isNotificationSent,
        "isUserNotification": dispatchNotification.isUserNotification,
        "notificationDate": dispatchNotification.notificationDate.toString(),
        "tokens": dispatchNotification.tokens,
        "riderId": dispatchNotification.riderId
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createPickUpNotification(Dispatch dispatch) async {
    try {
      String userToken;
      await userRef.child(dispatch.userId).once().then((dataSnapshot) {
        Map<dynamic, dynamic> snapSHotList = dataSnapshot.value;
        userToken = snapSHotList['token'];
      });
      String notificationMessage = Constants.pickUpDispatchMessage
          .replaceAll("{{Rider}}", loggedInRider.fullName);
      final DispatchNotification dispatchNotification =
          new DispatchNotification(
              id: Uuid().v4(),
              message: notificationMessage,
              dispatchId: dispatch.id,
              userId: dispatch.userId,
              notificationType: Constants.pickUpDispatchNotification,
              pickUp: dispatch.pickUpLocation,
              notificationDate: DateTime.now(),
              recipientPhone: dispatch.dispatchRecieverPhone,
              isUserNotification: false,
              isNotificationSent: false,
              tokens: userToken,
              riderId: loggedInRider.id);
      await notificationRef.child(dispatchNotification.id).set({
        "id": dispatchNotification.id,
        "message": dispatchNotification.message,
        "dispatchId": dispatchNotification.dispatchId,
        "userId": dispatchNotification.userId,
        "notificationType": dispatchNotification.notificationType,
        "pickUp": dispatchNotification.pickUp,
        "recipientPhone": dispatchNotification.recipientPhone,
        "isNotificationSent": dispatchNotification.isNotificationSent,
        "isUserNotification": dispatchNotification.isUserNotification,
        "notificationDate": dispatchNotification.notificationDate.toString(),
        "tokens": dispatchNotification.tokens,
        "riderId": dispatchNotification.riderId
      });
    } catch (e) {
      print(e.toString());
    }
  }

  List<DispatchNotification> getStreamNotificationhList(
      DataSnapshot dataSnapshot) {
    List<DispatchNotification> allNotification = [];
    Map<dynamic, dynamic> dbNotificationLIst = dataSnapshot.value;
    if (dataSnapshot.value != null) {
      dbNotificationLIst.forEach((key, value) {
        final notification = DispatchNotification(
            id: value['id'],
            message: value['message'],
            dispatchId: value['dispatchId'],
            userId: value['userId'],
            notificationType: value['notificationType'],
            pickUp: value['pickUp'],
            recipientPhone: value['recipientPhone'],
            notificationDate: DateTime.parse(value['notificationDate']),
            isNotificationSent: value['isNotificationSent'],
            isUserNotification: value['isUserNotification'],
            tokens: "",
            riderId: value['riderId']);
        allNotification.add(notification);
      });
      allNotification = allNotification
          .where((d) => d.riderId == loggedInRider.id || d.riderId == "all")
          .toList();
      allNotification
          .sort((a, b) => a.notificationDate.compareTo(b.notificationDate));
      return allNotification.reversed.toList();
    }
    return List<DispatchNotification>();
  }
}
