import 'package:dispatch_app_rider/src/lib_export.dart';
import 'package:dispatch_app_rider/ui/pages/settings/myProfilePage.dart';
import 'package:dispatch_app_rider/ui/pages/settings/updatePasswordPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatelessWidget {
  _buildRowWidget(IconData iconData, String title, Function function) {
    return GestureDetector(
      onTap: function,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    iconData,
                    color: Constants.primaryColorDark,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    title,
                    style: AppTextStyles.appTextStyle,
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 30),
                height: 30,
                width: 75,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Constants.primaryColorDark,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Edit',
                    style: AppTextStyles.smallprimaryColorTextStyle,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            endIndent: 25,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  static final routeName = "settings-page";
  @override
  Widget build(BuildContext context) {
    final appSize = GlobalWidgets.getAppSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SETTINGS",
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
          child: ListView(
            children: <Widget>[
              Icon(
                Icons.settings,
                size: 150,
                color: Constants.primaryColorDark,
              ),
              Text(
                "User Settings",
                textAlign: TextAlign.center,
                style: AppTextStyles.smallprimaryColorTextStyle,
              ),
              SizedBox(
                height: appSize.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 30),
                child: Column(
                  children: <Widget>[
                    _buildRowWidget(FontAwesomeIcons.user, "My Profile", () {
                      Navigator.of(context).pushNamed(MyProfilePage.routeName);
                    }),
                    SizedBox(
                      height: appSize.height * 0.04,
                    ),
                    _buildRowWidget(FontAwesomeIcons.lock, "Update Password",
                        () {
                      Navigator.of(context).pushNamed(UpdatePassowrd.routeName);
                    }),
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
