import 'package:dispatch_app_rider/ui/pages/home/homePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dispatch_app_rider/src/lib_export.dart';
import 'loginPage.dart';

class SignUpPage extends StatefulWidget {
  static final String routeName = "signup-page";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _fullNameController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _startLoading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  void _signUpUser() async {
    bool isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _startLoading(true);

    try {
      //do firebase sign up
      final rider = new Rider(
          id: null,
          fullName: _fullNameController.text.trim(),
          phoneNumber: _phoneNumberController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          hasActiveDispatch: false,
          token: "",
          latitude: 0.0,
          longitude: 0.0);
      final response = await Provider.of<AUthProvider>(context, listen: false)
          .signUpRider(rider);
      if (response.isSUcessfull) {
        _startLoading(false);
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
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
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/on_the_way.png',
                  scale: 2.5,
                ),
                SizedBox(
                  height: appSzie.height * 0.03,
                ),
                Text.rich(
                  AppTextWidget.appTextSpan("sign up on ", "Easy Dispatch"),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: appSzie.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: AppTextInputWIdget(
                    labelText: "full name",
                    prefixIcon: FontAwesomeIcons.user,
                    obscureText: false,
                    controller: _fullNameController,
                    validator: (value) {
                      return Constants.stringValidator(value, "full name");
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                    child: AppTextInputWIdget(
                      labelText: "phone number",
                      controller: _phoneNumberController,
                      prefixIcon: FontAwesomeIcons.phone,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        return Constants.stringValidator(value, "phone number");
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                    child: AppTextInputWIdget(
                      labelText: "email",
                      controller: _emailController,
                      prefixIcon: FontAwesomeIcons.envelope,
                      obscureText: false,
                      validator: (value) {
                        return Constants.stringValidator(value, "email");
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                    child: AppTextInputWIdget(
                      labelText: "password",
                      controller: _passwordController,
                      prefixIcon: FontAwesomeIcons.lock,
                      obscureText: true,
                      validator: (value) {
                        return Constants.stringValidator(value, "full name");
                      },
                    )),
                SizedBox(
                  height: appSzie.height * 0.04,
                ),
                _isLoading
                    ? GlobalWidgets.circularInidcator()
                    : AppButtonWudget(
                        buttonText: "Sign Up",
                        function: () {
                          _signUpUser();
                        },
                      ),
                SizedBox(
                  height: appSzie.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(LoginPage.routeName);
                  },
                  child: Text.rich(
                    AppTextWidget.appSmallTextSpan(
                        "already have an account? ", "Log In"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
