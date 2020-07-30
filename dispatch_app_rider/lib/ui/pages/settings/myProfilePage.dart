import 'package:dispatch_app_rider/src/lib_export.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyProfilePage extends StatelessWidget {
  static final String routeName = "myprofile";
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
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.save,
                size: 30,
              ),
              onPressed: () {})
        ],
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
                    ),
                    SizedBox(
                      height: appSize.height * 0.02,
                    ),
                    AppTextInputWIdget(
                      labelText: "email",
                      prefixIcon: FontAwesomeIcons.envelope,
                      obscureText: false,
                    ),
                    SizedBox(
                      height: appSize.height * 0.02,
                    ),
                    AppTextInputWIdget(
                      labelText: "phone",
                      prefixIcon: FontAwesomeIcons.phone,
                      obscureText: false,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
