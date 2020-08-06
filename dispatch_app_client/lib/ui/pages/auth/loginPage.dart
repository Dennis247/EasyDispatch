import 'package:dispatch_app_client/src/lib_export.dart';
import 'package:dispatch_app_client/ui/pages/auth/signUpPage.dart';
import 'package:dispatch_app_client/ui/pages/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static final String routeName = "loginPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _startLoading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void _loginUser() async {
    dispatchList = [];
    bool isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _startLoading(true);
    try {
      final response = await Provider.of<AUthProvider>(context, listen: false)
          .login(_emailController.text.trim(), _passwordController.text.trim());
      if (response.isSUcessfull) {
        Navigator.of(context).pushReplacementNamed(HompePage.routeName);
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
    final appSzie = GlobalWidgets.getAppSize(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/order_delivered.png',
                    scale: 1.5,
                  ),
                  SizedBox(
                    height: appSzie.height * 0.04,
                  ),
                  Text.rich(
                    AppTextWidget.appTextSpan("Login to ", "Easy Dispatch"),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: appSzie.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: AppTextInputWIdget(
                      labelText: "email",
                      prefixIcon: FontAwesomeIcons.user,
                      obscureText: false,
                      controller: _emailController,
                      validator: (value) {
                        return Constants.stringValidator(value, "email");
                      },
                    ),
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: AppTextInputWIdget(
                        labelText: "password",
                        prefixIcon: FontAwesomeIcons.envelope,
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          return Constants.stringValidator(value, "password");
                        },
                      )),
                  SizedBox(
                    height: appSzie.height * 0.05,
                  ),
                  _isLoading
                      ? GlobalWidgets.circularInidcator()
                      : AppButtonWudget(
                          buttonText: "Login", function: _loginUser),
                  SizedBox(
                    height: appSzie.height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(SignUpPage.routeName);
                    },
                    child: Text.rich(
                      AppTextWidget.appSmallTextSpan(
                          "Don't have an Account? ", "Sign Up"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
