import 'dart:convert';

import 'package:dispatch_lib/src/models/PlaceDistanceTime.dart';
import 'package:dispatch_lib/src/models/constants.dart';
import 'package:dispatch_lib/src/models/dispatch.dart';
import 'package:dispatch_lib/src/models/notification.dart';
import 'package:dispatch_lib/src/models/placeDetail.dart';
import 'package:dispatch_lib/src/models/response.dart';
import 'package:dispatch_lib/src/providers/authProvider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

import 'notificatiomProvider.dart';

Dispatch currentDispatch;
List<Dispatch> dispatchList;
String recieverPhone;
String recieverName;
String dispatchDescription;

class DispatchProvider with ChangeNotifier {
  Uuid uuid = Uuid();
  Future<ResponseModel> getDispatchList() async {
    ResponseModel responseModel;
    dispatchList = dispatchList == null ? [] : dispatchList;
    List<Dispatch> alldispatch = [];
    try {
      dispatchList.clear();
      await dispatchRef
          .orderByChild("userId")
          .equalTo(loggedInUser.id)
          .once()
          .then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> dbDispatchLIst = dataSnapshot.value;
        if (dbDispatchLIst != null) {
          dbDispatchLIst.forEach((key, value) {
            final dispatch = Dispatch(
                id: value['id'],
                userId: value['userId'],
                trackingNo: value['trackingNo'],
                dispatchRiderId: value['dispatchRiderId'],
                dispatchDate: DateTime.parse(value['dispatchDate']),
                pickUpLocation: value['pickUpLocation'],
                dispatchDestination: value['dispatchDestination'],
                dispatchBaseFare:
                    double.parse(value['dispatchBaseFare'].toString()),
                dispatchTotalFare:
                    double.parse(value['dispatchTotalFare'].toString()),
                dispatchType: value['dispatchType'],
                dispatchStatus: value['dispatchStatus'],
                currentLocation: value['currentLocation'],
                estimatedDIspatchDuration: value['estimatedDIspatchDuration'],
                estimatedDistance: value['estimatedDistance'],
                dispatchReciever: value['dispatchReciever'],
                dispatchRecieverPhone: value['dispatchRecieverPhone'],
                dispatchDescription: value['dispatchDescription'],
                destinationLatitude: value['destinationLatitude'],
                destinationLongitude: value['destinationLongitude'],
                paymentOption: value['paymentOption']);
            alldispatch.add(dispatch);
          });
          dispatchList = alldispatch;
          dispatchList.sort((b, a) => a.dispatchDate.compareTo(b.dispatchDate));
          responseModel =
              ResponseModel(true, "Disatch list gotten sucessfully");
        } else {
          responseModel = ResponseModel(true, "Disatch list is empty");
        }
      });
      return responseModel;
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      return responseModel;
    }
  }

  List<Dispatch> getDispatchLIst(String dispatchStatus, List<Dispatch> list) {
    List<Dispatch> dispatchReturn = [];
    if (dispatchStatus == Constants.dispatchPendingStatus) {
      dispatchReturn = list
          .where((ds) => ds.dispatchStatus == Constants.dispatchPendingStatus)
          .toList();
    }
    if (dispatchStatus == Constants.dispatchActiveStatus) {
      dispatchReturn = list
          .where((ds) => ds.dispatchStatus == Constants.dispatchActiveStatus)
          .toList();
    }
    if (dispatchStatus == Constants.dispatchCompletedStatus) {
      dispatchReturn = list
          .where((ds) => ds.dispatchStatus == Constants.dispatchCompletedStatus)
          .toList();
    }
    if (dispatchStatus == Constants.dispatchCancelledStatus) {
      dispatchReturn = list
          .where((ds) => ds.dispatchStatus == Constants.dispatchCancelledStatus)
          .toList();
    }
    dispatchReturn.sort((b, a) => a.dispatchDate.compareTo(b.dispatchDate));
    return dispatchReturn;
  }

  Future<ResponseModel> addDispatch(Dispatch dispatch) async {
    dispatchList = dispatchList == null ? [] : dispatchList;
    try {
      await dispatchRef.child(dispatch.id).set({
        "id": dispatch.id,
        "userId": dispatch.userId,
        "trackingNo": dispatch.trackingNo,
        "dispatchRiderId": dispatch.dispatchRiderId,
        "dispatchDate": DateTime.now().toIso8601String(),
        "pickUpLocation": dispatch.pickUpLocation,
        "dispatchDestination": dispatch.dispatchDestination,
        "dispatchBaseFare": dispatch.dispatchBaseFare,
        "dispatchType": dispatch.dispatchType,
        "dispatchStatus": dispatch.dispatchStatus,
        "currentLocation": dispatch.currentLocation,
        "estimatedDIspatchDuration": dispatch.estimatedDIspatchDuration,
        "estimatedDistance": dispatch.estimatedDistance,
        "dispatchTotalFare": dispatch.dispatchTotalFare,
        "dispatchReciever": dispatch.dispatchReciever,
        "dispatchRecieverPhone": dispatch.dispatchRecieverPhone,
        "dispatchDescription": dispatch.dispatchDescription,
        "destinationLatitude": dispatch.destinationLatitude,
        "destinationLongitude": dispatch.destinationLongitude,
        "paymentOption": dispatch.paymentOption
      });
      dispatchList.add(dispatch);
      await createPendingDispatchNotification(dispatch);
      return ResponseModel(true, "Dispatch Created Sucessfully");
    } catch (e) {
      return ResponseModel(false, e.toString());
    }
  }

  Future<ResponseModel> createDispatch(
      String dispatchType,
      String pickUpLocation,
      String dispatchDestination,
      String token,
      PlaceDetail endPlaceDetail,
      String paymentOption) async {
    try {
      final placeDistanceTime = await getPlaceDistanceTimeWithAddress(
          pickUpLocation, dispatchDestination, token);
      final Dispatch dispatch = new Dispatch(
          id: uuid.v4(),
          userId: loggedInUser.id,
          trackingNo: uuid.v4().substring(0, 5),
          dispatchRiderId: uuid.v4(),
          dispatchDate: DateTime.now(),
          pickUpLocation: pickUpLocation,
          dispatchDestination: dispatchDestination,
          dispatchBaseFare: Constants.dispatchBaseFare,
          dispatchType: dispatchType,
          dispatchStatus: Constants.dispatchPendingStatus,
          currentLocation: "",
          estimatedDIspatchDuration: placeDistanceTime.duration,
          estimatedDistance: placeDistanceTime.distance,
          dispatchTotalFare: 5000,
          dispatchReciever: recieverName,
          dispatchRecieverPhone: recieverPhone,
          dispatchDescription: dispatchDescription,
          destinationLatitude: endPlaceDetail.lat,
          destinationLongitude: endPlaceDetail.lng,
          paymentOption: paymentOption);
      currentDispatch = dispatch;
      return ResponseModel(true, "dispatch created sucessfully");
    } catch (e) {
      return ResponseModel(false, e.toString());
    }
  }

  Future<PlaceDistanceTime> getPlaceDistanceTimeWithAddress(
      String origin, String destination, String sessionToken) async {
    final String baseUrl =
        'https://maps.googleapis.com/maps/api/distancematrix/json';
    String url =
        '$baseUrl?origins=$origin&destinations=$destination&key=${Constants.apiKey}&travelMode=driving&sessiontoken=$sessionToken';
    final http.Response response = await http.get(url);
    final responseData = json.decode(response.body);
    final PlaceDistanceTime placeDistanceTime =
        PlaceDistanceTime.fromJson(responseData);
    return placeDistanceTime;
  }

  Future<PlaceDistanceTime> getPlaceDistanceTimeWIthCordinate(
      LatLng origin, LatLng destination, String sessionToken) async {
    final String baseUrl =
        'https://maps.googleapis.com/maps/api/distancematrix/json';
    String url =
        '$baseUrl?origins=${origin.latitude},${origin.longitude}&destinations=${destination.latitude},${destination.longitude}&key=${Constants.apiKey}&travelMode=driving&sessiontoken=$sessionToken';
    final http.Response response = await http.get(url);
    final responseData = json.decode(response.body);
    final PlaceDistanceTime placeDistanceTime =
        PlaceDistanceTime.fromJson(responseData);
    return placeDistanceTime;
  }

  Future<ResponseModel> updateDispatchStatus(
      String dispatchId, String status) async {
    try {
      dispatchRef.child(dispatchId).update({'dispatchStatus': status});
      return ResponseModel(true, "Dispatch Staus Updated Sucessfully");
    } catch (e) {
      return ResponseModel(false, e.toString());
    }
  }

  Future<void> createPendingDispatchNotification(Dispatch dispatch) async {
    try {
      var tokenArray = [];
      await riderRef.once().then((dataSnapshot) {
        Map<dynamic, dynamic> riderList = dataSnapshot.value;
        riderList.forEach((key, value) {
          tokenArray.add(value['token']);
        });
      });
      String tokenList = tokenArray.join(",");
      String notificationMessage = Constants.pendingDispatchMessage
          .replaceAll("{{user}}", loggedInUser.fullName);

      final DispatchNotification dispatchNotification =
          new DispatchNotification(
              id: uuid.v4(),
              message: notificationMessage,
              dispatchId: dispatch.id,
              userId: dispatch.userId,
              notificationType: Constants.pendingDispatchNotification,
              pickUp: dispatch.pickUpLocation,
              notificationDate: DateTime.now(),
              recipientPhone: dispatch.dispatchRecieverPhone,
              isUserNotification: false,
              isNotificationSent: false,
              tokens: tokenList,
              riderId: "all");

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
        "riderId": "all"
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Tuple2<ResponseModel, Dispatch>> getDispatch(String dispatchId) async {
    Dispatch dispatch;
    Tuple2<ResponseModel, Dispatch> responseModel;
    try {
      await dispatchRef
          .child(dispatchId)
          .once()
          .then((DataSnapshot dataSnapshot) {
        final value = dataSnapshot.value as Map<dynamic, dynamic>;
        dispatch = new Dispatch(
            id: value['id'],
            userId: value['userId'],
            trackingNo: value['trackingNo'],
            dispatchRiderId: value['dispatchRiderId'],
            dispatchDate: DateTime.parse(value['dispatchDate'].toString()),
            pickUpLocation: value['pickUpLocation'],
            dispatchDestination: value['dispatchDestination'],
            dispatchBaseFare:
                double.parse(value['dispatchBaseFare'].toString()),
            dispatchTotalFare:
                double.parse(value['dispatchTotalFare'].toString()),
            dispatchType: value['dispatchType'],
            dispatchStatus: value['dispatchStatus'],
            currentLocation: value['currentLocation'],
            estimatedDIspatchDuration: value['estimatedDIspatchDuration'],
            estimatedDistance: value['estimatedDistance'],
            dispatchReciever: value['dispatchReciever'],
            dispatchRecieverPhone: value['dispatchRecieverPhone'],
            dispatchDescription: value['dispatchDescription'],
            destinationLatitude: value['destinationLatitude'],
            destinationLongitude: value['destinationLongitude'],
            paymentOption: value['paymentOption']);
      });
      responseModel = Tuple2<ResponseModel, Dispatch>(
          ResponseModel(true, "dispatch Fetched Sucessfull"), dispatch);
    } catch (e) {
      responseModel = Tuple2<ResponseModel, Dispatch>(
          ResponseModel(false, e.toString()), null);
    }
    return responseModel;
  }

  List<Dispatch> getStreamDIspatchList(DataSnapshot dataSnapshot) {
    List<Dispatch> alldispatch = [];
    Map<dynamic, dynamic> dbDispatchLIst = dataSnapshot.value;
    dbDispatchLIst.forEach((key, value) {
      final dispatch = Dispatch(
          id: value['id'],
          userId: value['userId'],
          trackingNo: value['trackingNo'],
          dispatchRiderId: value['dispatchRiderId'],
          dispatchDate: DateTime.parse(value['dispatchDate']),
          pickUpLocation: value['pickUpLocation'],
          dispatchDestination: value['dispatchDestination'],
          dispatchBaseFare: double.parse(value['dispatchBaseFare'].toString()),
          dispatchTotalFare:
              double.parse(value['dispatchTotalFare'].toString()),
          dispatchType: value['dispatchType'],
          dispatchStatus: value['dispatchStatus'],
          currentLocation: value['currentLocation'],
          estimatedDIspatchDuration: value['estimatedDIspatchDuration'],
          estimatedDistance: value['estimatedDistance'],
          dispatchReciever: value['dispatchReciever'],
          dispatchRecieverPhone: value['dispatchRecieverPhone'],
          dispatchDescription: value['dispatchDescription'],
          destinationLatitude: value['destinationLatitude'],
          destinationLongitude: value['destinationLongitude'],
          paymentOption: value['paymentOption']);
      alldispatch.add(dispatch);
    });
    return alldispatch.reversed.toList();
  }

  ///form rider app
  Future<ResponseModel> assignDispatchToRider(
      String dispatchId, String riderId) async {
    try {
      dispatchRef.child(dispatchId).update({
        'dispatchStatus': Constants.dispatchActiveStatus,
        "dispatchRiderId": riderId
      });
      return ResponseModel(true, "Dispatch Staus Updated Sucessfully");
    } catch (e) {
      return ResponseModel(false, e.toString());
    }
  }

  List<Dispatch> getRiderDispatchLIst(
      String dispatchStatus, List<Dispatch> list,
      {String riderId}) {
    List<Dispatch> dispatchReturn = [];
    if (dispatchStatus == Constants.dispatchPendingStatus) {
      dispatchReturn = list
          .where((ds) => ds.dispatchStatus == Constants.dispatchPendingStatus)
          .toList();
      //  return dispatchReturn;
    }
    if (dispatchStatus == Constants.dispatchActiveStatus) {
      dispatchReturn = list
          .where((ds) =>
              ds.dispatchStatus == Constants.dispatchActiveStatus &&
              ds.dispatchRiderId == riderId)
          .toList();
      //  return dispatchReturn;
    }
    if (dispatchStatus == Constants.dispatchCompletedStatus) {
      dispatchReturn = list
          .where((ds) =>
              ds.dispatchStatus == Constants.dispatchCompletedStatus &&
              ds.dispatchRiderId == riderId)
          .toList();
      //  return dispatchReturn;
    }
    if (dispatchStatus == Constants.dispatchCancelledStatus) {
      dispatchReturn = list
          .where((ds) =>
              ds.dispatchStatus == Constants.dispatchCancelledStatus &&
              ds.dispatchRiderId == riderId)
          .toList();
      // return dispatchReturn;
    }
    dispatchReturn.sort((a, b) => a.dispatchDate.compareTo(b.dispatchDate));
    return dispatchReturn.reversed.toList();
  }
}
