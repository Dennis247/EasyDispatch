import 'package:flutter/cupertino.dart';

class Settings {
  final String countryAbbrevation;
  final bool isDemoMode;
  final bool stopLocationService;
  final String currencySymbol;
  final double economyBaseFare;
  final double expressBaseFare;
  final double premiumBaseFare;
  final double pricePerKM;

  Settings(
      {@required this.countryAbbrevation,
      @required this.isDemoMode,
      @required this.currencySymbol,
      @required this.stopLocationService,
      @required this.economyBaseFare,
      @required this.expressBaseFare,
      @required this.premiumBaseFare,
      @required this.pricePerKM});
}
