import 'package:flutter/material.dart';

class Constants {
  static Color primaryColorDark = Color(0xff0d1724);
  static Color primaryColorLight = Colors.white;
  static Color backGroundColor = Colors.grey.shade200;
  static String flutterPublicKey =
      "FLWPUBK_TEST-3319851d5f4b03884a12cf8afe1d53a8-X";
  static String flutterEncryptionKey = "FLWSECK_TESTdd604a255d3c";
  static final String baseSearchUrl =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
  static final String apiKey = 'AIzaSyBaSy0NPJ63AzVrji8aIqYx0Ilwm1acUZw';
  static final String dispatchPendingStatus = "penidng";
  static final String dispatchActiveStatus = "active";
  static final String dispatchCompletedStatus = "completed";
  static final String dispatchCancelledStatus = "cancelled";
  static final String dispatchTypeEconomy = "Economy";
  static final String dispatchTypeExpress = "Express";
  static final String dispatchTypePremiun = "Premiun";
  static final double dispatchBaseFare = 500.00;
  static final String dispatchPickIpAddress = "18 Mushin Avenue Lagos";
  static final String dispatchDestinationAddress = "22 Yaba Education Centre";
  static final String pickUp = "PickUp Address";
  static final String deliveryAddress = "Delivery Address";
  static final String processDispatchMessage =
      "Your Request was sucessfull, Dispatch Rider is on the way for pick up";
  static final String cancellDispatchMessage =
      "Your Request was sucessfull, Your Dispatch has been Cancelled";
  static final String autoLogOnData = "auto log data";
  static final String settingsData = "settings data";
  static final String onBoardingData = "on boarding data";
  static final String hiveData = "hive data";
  static final String userTypeUser = "user";
  static final String userTypeDriver = "driver";
  static final String pendingDispatchMessage =
      "Pick up is waiting for {{user}}";
  static final String completedDispatchMessage = "Dispatch Completed for  ";
  static final String pendingDispatchNotification = "pending dispatch";
  static final String completedDispatchNotification = "completed dispatch";
  static final String pickUpDispatchMessage =
      "Dispatch Rider {{Rider}} is on it way for pick up";
  static final String pickUpDispatchNotification = "Rider PickUp";
  static final String payOnDelivery = "Pay On Delivery";
  static final String payOnline = "Pay Online";

  static String stringValidator(String value, String controllerName) {
    if (value.isEmpty) {
      return "$controllerName cannot be empty";
    }
    return null;
  }
}
