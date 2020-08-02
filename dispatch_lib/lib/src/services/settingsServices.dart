import 'dart:convert';

import 'package:dispatch_lib/dispatch_lib.dart';
import 'package:dispatch_lib/src/models/settings.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

class SettingsServices {
  Settings _appSettings;
  Settings get appSettings {
    return _appSettings;
  }

  Future<ResponseModel> saveAppSettings(Settings settings) async {
    try {
      _appSettings = settings;
      final sharedPrefs = await SharedPreferences.getInstance();
      final settingsData = json.encode({
        'countryAbbrevation': settings.countryAbbrevation,
        'isDemoMode': settings.isDemoMode,
        'currencySymbol': settings.currencySymbol,
        'economyBaseFare': settings.economyBaseFare,
        'expressBaseFare': settings.expressBaseFare,
        'premiumBaseFare': settings.premiumBaseFare,
        'stopLocationService': settings.stopLocationService,
        'pricePerKM': settings.pricePerKM
      });
      sharedPrefs.setString(Constants.settingsData, settingsData);
      return ResponseModel(true, "settings saved sucessfully");
    } catch (e) {
      return ResponseModel(false, "settings saved Failed");
    }
  }

  void getAppSettings() async {
    final sharedPref = await SharedPreferences.getInstance();
    final sharedData = sharedPref.getString(Constants.settingsData);
    if (sharedData == null) {
      final appSettings = new Settings(
          countryAbbrevation: 'ng',
          isDemoMode: true,
          currencySymbol: 'NAR',
          economyBaseFare: 500,
          expressBaseFare: 1000,
          premiumBaseFare: 1500,
          stopLocationService: true,
          pricePerKM: 100);
      saveAppSettings(appSettings);
    } else {
      final settingsData = json.decode(sharedData) as Map<String, Object>;
      _appSettings = new Settings(
          countryAbbrevation: settingsData['countryAbbrevation'],
          isDemoMode: settingsData['isDemoMode'],
          currencySymbol: settingsData['currencySymbol'],
          economyBaseFare: settingsData['economyBaseFare'],
          expressBaseFare: settingsData['expressBaseFare'],
          premiumBaseFare: settingsData['premiumBaseFare'],
          stopLocationService: settingsData['stopLocationService'] == null
              ? true
              : settingsData['stopLocationService'],
          pricePerKM: settingsData['pricePerKM'] == null
              ? 100
              : settingsData['pricePerKM']);
    }
  }
}
