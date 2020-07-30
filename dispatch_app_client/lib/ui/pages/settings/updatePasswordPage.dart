import 'package:dispatch_app_client/src/lib_export.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UpdatePassowrd extends StatefulWidget {
  static final String routeName = "update-password";

  @override
  _UpdatePassowrdState createState() => _UpdatePassowrdState();
}

class _UpdatePassowrdState extends State<UpdatePassowrd> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _newwPaswordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();

  @override
  void dispose() {
    _newwPaswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _startLoading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  void _updatePassword() async {
    bool isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _startLoading(true);
    try {
      final response = await Provider.of<AUthProvider>(context, listen: false)
          .updatePassword(_confirmPasswordController.text);
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
          "UPDATE PASSWORD",
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
                  FontAwesomeIcons.lock,
                  size: 150,
                  color: Constants.primaryColorDark,
                ),
                SizedBox(
                  height: appSize.height * 0.03,
                ),
                Text(
                  "password",
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
                        labelText: "New Password",
                        prefixIcon: Icons.lock_outline,
                        obscureText: true,
                        controller: _newwPaswordController,
                        validator: (value) {
                          if (_newwPaswordController.text !=
                              _confirmPasswordController.text) {
                            return "Password must be same as Confirm Password";
                          }
                          return Constants.stringValidator(
                              value, "new password");
                        },
                      ),
                      SizedBox(
                        height: appSize.height * 0.02,
                      ),
                      AppTextInputWIdget(
                        labelText: "Confrim Password",
                        prefixIcon: Icons.lock_outline,
                        obscureText: true,
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (_newwPaswordController.text !=
                              _confirmPasswordController.text) {
                            return "Password must be same as Confirm Password";
                          }
                          return Constants.stringValidator(
                              value, "confirm password");
                        },
                      ),
                      SizedBox(
                        height: appSize.height * 0.08,
                      ),
                      _isLoading
                          ? GlobalWidgets.circularInidcator()
                          : AppButtonWudget(
                              buttonText: "SAVE",
                              function: _updatePassword,
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
