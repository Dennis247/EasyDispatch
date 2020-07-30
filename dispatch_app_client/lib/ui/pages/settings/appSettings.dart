import 'package:dispatch_app_client/src/lib_export.dart';

class AppSettings extends StatefulWidget {
  static final String routeName = "app-settings";
  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  TextEditingController _countryAbbvController = new TextEditingController();
  bool _isDemoMode = false;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  void initState() {
    _countryAbbvController.text =
        locator<SettingsServices>().appSettings.countryAbbrevation;
    _isDemoMode = locator<SettingsServices>().appSettings.isDemoMode;
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
          isDemoMode: _isDemoMode);
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
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text(
            "APP SETTINGS",
            style: AppTextStyles.appLightHeaderTextStyle,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.save,
                  size: 25,
                ),
                onPressed: () {
                  _saveSettings();
                })
          ],
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
                  child: Card(
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
                        _isLoading
                            ? GlobalWidgets.circularInidcator()
                            : Text("")
                      ],
                    ),
                  ),
                ),
              ))),
        ));
  }
}
