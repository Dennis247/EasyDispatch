// import 'dart:convert';

// import 'package:dispatch_lib/dispatch_lib.dart';
// import 'package:dispatch_lib/src/models/settings.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Settings appSettings;

// class SettingsProvider with ChangeNotifier {
//   Future<ResponseModel> saveAppSettings(Settings settings) async {
//     try {
//       appSettings = settings;
//       final sharedPrefs = await SharedPreferences.getInstance();
//       final settingsData = json.encode({
//         'countryAbbrevation': settings.countryAbbrevation,
//         'isDemoMode': settings.isDemoMode,
//       });
//       sharedPrefs.setString(Constants.settingsData, settingsData);
//       return ResponseModel(true, "settings saved sucessfully");
//     } catch (e) {
//       return ResponseModel(false, "settings saved Failed");
//     }
//   }

//   void getAppSettings() async {
//     final sharedPref = await SharedPreferences.getInstance();
//     final sharedData = sharedPref.getString(Constants.autoLogOnData);
//     final settingsData = json.decode(sharedData) as Map<String, Object>;
//     appSettings = new Settings(
//         countryAbbrevation: settingsData['countryAbbrevation'],
//         isDemoMode: settingsData['isDemoMode']);
//   }
// }
