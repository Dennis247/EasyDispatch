import 'package:dispatch_app_client/src/lib_export.dart';

class AppSettings extends StatefulWidget {
  static final String routeName = "app-settings";
  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  TextEditingController _countryAbbvController = new TextEditingController();
  TextEditingController _currencySymbolController = new TextEditingController();
  TextEditingController _economyBaseFareCOntroller =
      new TextEditingController();
  TextEditingController _expressBaseFareController =
      new TextEditingController();
  TextEditingController _premiumnBaseFareController =
      new TextEditingController();
  TextEditingController _pricePerKmController = new TextEditingController();
  bool _isDemoMode = false;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  void initState() {
    _countryAbbvController.text =
        locator<SettingsServices>().appSettings.countryAbbrevation;
    _isDemoMode = locator<SettingsServices>().appSettings.isDemoMode;
    _currencySymbolController.text =
        locator<SettingsServices>().appSettings.currencySymbol;
    _economyBaseFareCOntroller.text =
        locator<SettingsServices>().appSettings.economyBaseFare.toString();
    _expressBaseFareController.text =
        locator<SettingsServices>().appSettings.expressBaseFare.toString();
    _premiumnBaseFareController.text =
        locator<SettingsServices>().appSettings.premiumBaseFare.toString();
    _pricePerKmController.text =
        locator<SettingsServices>().appSettings.pricePerKM.toString();
    super.initState();
  }

  void _startLoading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  @override
  void dispose() {
    _countryAbbvController.dispose();
    super.dispose();
  }

  void _saveSettings() async {
    dispatchList = [];
    bool isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _startLoading(true);
    try {
      Settings settings = new Settings(
          countryAbbrevation: _countryAbbvController.text,
          isDemoMode: _isDemoMode,
          currencySymbol: _currencySymbolController.text,
          economyBaseFare: double.parse(_economyBaseFareCOntroller.text),
          expressBaseFare: double.parse(_expressBaseFareController.text),
          premiumBaseFare: double.parse(_premiumnBaseFareController.text),
          pricePerKM: double.parse(_pricePerKmController.text),
          stopLocationService: false);
      final response =
          await locator<SettingsServices>().saveAppSettings(settings);
      if (response.isSUcessfull) {
        GlobalWidgets.showSuccessDialogue(response.responseMessage, context);
      } else {
        GlobalWidgets.showFialureDialogue(response.responseMessage, context);
      }
      _startLoading(false);
    } catch (e) {
      _startLoading(false);
      GlobalWidgets.showFialureDialogue(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appSzie = GlobalWidgets.getAppSize(context);
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      appBar: AppBar(
        title: Text(
          "APP SETTINGS",
          style: AppTextStyles.appLightHeaderTextStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[],
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        height: appSzie.height,
        width: appSzie.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.settings, color: Constants.primaryColorDark),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Settings",
                        style: AppTextStyles.orangeTextStyle,
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Country Abbrevation",
                                  style: AppTextStyles.appTextStyle,
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: AppTextInputWIdget(
                                    obscureText: false,
                                    controller: _countryAbbvController,
                                    validator: (value) {
                                      return Constants.stringValidator(
                                          value, "Country Abbrevation");
                                    },
                                  ))
                            ],
                          ),
                          Divider(),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Demo Mode",
                                  style: AppTextStyles.appTextStyle,
                                ),
                              ),
                              Switch(
                                  value: _isDemoMode,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _isDemoMode = value;
                                    });
                                  })
                            ],
                          ),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Currency Symbol",
                                  style: AppTextStyles.appTextStyle,
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: AppTextInputWIdget(
                                    obscureText: false,
                                    controller: _currencySymbolController,
                                    validator: (value) {
                                      return Constants.stringValidator(
                                          value, "currency symbol");
                                    },
                                  ))
                            ],
                          ),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Economy BaseFare",
                                  style: AppTextStyles.appTextStyle,
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: AppTextInputWIdget(
                                    obscureText: false,
                                    controller: _economyBaseFareCOntroller,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      return Constants.stringValidator(
                                          value, "economy basefare");
                                    },
                                  ))
                            ],
                          ),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Express BaseFare",
                                  style: AppTextStyles.appTextStyle,
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: AppTextInputWIdget(
                                    obscureText: false,
                                    controller: _expressBaseFareController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      return Constants.stringValidator(
                                          value, "express basefare");
                                    },
                                  ))
                            ],
                          ),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Premiumn BaseFare",
                                  style: AppTextStyles.appTextStyle,
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: AppTextInputWIdget(
                                    obscureText: false,
                                    controller: _premiumnBaseFareController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      return Constants.stringValidator(
                                          value, "premiun basefare");
                                    },
                                  ))
                            ],
                          ),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Price Per KM",
                                  style: AppTextStyles.appTextStyle,
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: AppTextInputWIdget(
                                    obscureText: false,
                                    controller: _pricePerKmController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      return Constants.stringValidator(
                                          value, "price per km");
                                    },
                                  ))
                            ],
                          ),
                          _isLoading
                              ? GlobalWidgets.circularInidcator()
                              : Text("")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: AppRectButtonWidget(
              width: appSzie.width,
              buttonText: "SAVE SETTINGS",
              function: _saveSettings),
        ),
      ),
    );
  }
}
