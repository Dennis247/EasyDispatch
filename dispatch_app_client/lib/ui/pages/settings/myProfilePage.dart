import 'package:dispatch_app_client/src/lib_export.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyProfilePage extends StatefulWidget {
  static final String routeName = "myprofile";

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fullnameController = new TextEditingController();
  TextEditingController _phonenumberController = new TextEditingController();

  @override
  void initState() {
    _fullnameController.text = loggedInUser.fullName;
    _phonenumberController.text = loggedInUser.phoneNumber;
    super.initState();
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _phonenumberController.dispose();
    super.dispose();
  }

  void _startLoading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  void _updateProfile() async {
    bool isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _startLoading(true);
    try {
      final response = await Provider.of<AUthProvider>(context, listen: false)
          .updateProfile(_fullnameController.text, _phonenumberController.text);
      //update shared preference
      loggedInUser = User(
          loggedInUser.id,
          _fullnameController.text,
          _phonenumberController.text,
          loggedInUser.email,
          loggedInUser.password,
          loggedInUser.userType,
          loggedInUser.token);
      Provider.of<AUthProvider>(context, listen: false)
          .storeAutoData(loggedInUser);
      if (response.isSUcessfull) {
        _startLoading(false);
        GlobalWidgets.showSuccessDialogue(response.responseMessage, context);
      } else {
        _startLoading(false);
        GlobalWidgets.showFialureDialogue(response.responseMessage, context);
      }
    } catch (e) {
      _startLoading(false);
      GlobalWidgets.showFialureDialogue(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appSize = GlobalWidgets.getAppSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MY PROFILE",
          style: AppTextStyles.appLightHeaderTextStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
        child: Card(
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.user,
                  size: 150,
                  color: Constants.primaryColorDark,
                ),
                SizedBox(
                  height: appSize.height * 0.03,
                ),
                Text(
                  "profile",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.smallprimaryColorTextStyle,
                ),
                SizedBox(
                  height: appSize.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      AppTextInputWIdget(
                        labelText: "Full Name",
                        prefixIcon: FontAwesomeIcons.user,
                        obscureText: false,
                        controller: _fullnameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          return Constants.stringValidator(value, "full name");
                        },
                      ),
                      SizedBox(
                        height: appSize.height * 0.02,
                      ),
                      AppTextInputWIdget(
                        labelText: "phone number",
                        prefixIcon: FontAwesomeIcons.phone,
                        obscureText: false,
                        controller: _phonenumberController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return Constants.stringValidator(
                              value, "phone number");
                        },
                      ),
                      SizedBox(
                        height: appSize.height * 0.08,
                      ),
                      _isLoading
                          ? GlobalWidgets.circularInidcator()
                          : AppButtonWudget(
                              buttonText: "SAVE",
                              function: _updateProfile,
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
