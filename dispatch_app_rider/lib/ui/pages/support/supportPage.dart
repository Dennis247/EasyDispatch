import 'package:dispatch_app_rider/src/lib_export.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SupportPage extends StatelessWidget {
  static final routeName = "support-page";

  _buildRowWidgets(IconData iconData, String title, String subtitle) {
    return Row(
      children: <Widget>[
        Icon(
          iconData,
          color: Constants.primaryColorDark,
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: AppTextStyles.smallprimaryColorTextStyle,
            ),
            new Text(subtitle, style: AppTextStyles.appTextStyle)
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SUPPORT",
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
              Center(
                child: Icon(
                  Icons.headset,
                  color: Constants.primaryColorDark,
                  size: 150,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Contact us@",
                textAlign: TextAlign.center,
                style: AppTextStyles.smallprimaryColorTextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Column(
                  children: <Widget>[
                    _buildRowWidgets(FontAwesomeIcons.facebook, "facebook",
                        "facebook.com/osagiededennis"),
                    SizedBox(
                      height: 25,
                    ),
                    _buildRowWidgets(FontAwesomeIcons.twitter, "twitter",
                        "twitter.com/Xource_Code"),
                    SizedBox(
                      height: 25,
                    ),
                    _buildRowWidgets(FontAwesomeIcons.instagram, "instagram",
                        "instagram.com/xource_code"),
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
