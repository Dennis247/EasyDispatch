import 'package:dispatch_app_client/src/lib_export.dart';
import 'package:dispatch_app_client/ui/pages/auth/loginPage.dart';
import 'package:dispatch_app_client/ui/pages/dispatch/dispatchHistoryPage.dart';
import 'package:dispatch_app_client/ui/pages/notification/notificationPage.dart';
import 'package:dispatch_app_client/ui/pages/settings/appSettings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:dispatch_app_client/ui/pages/support/supportPage.dart';
import 'package:dispatch_app_client/ui/pages/settings/settingsPage.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AUthProvider>(context, listen: false);
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.user,
                color: Constants.primaryColorDark,
                size: 50,
              ),
              title: Text(
                "Good Morning",
                style: AppTextStyles.smallprimaryColorTextStyle,
              ),
              subtitle: Text(
                loggedInUser.fullName,
                style: AppTextStyles.appDarkHeaderTextStyle,
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushNamed(DispatchHistoryPage.routeName);
                  },
                  child: Text(
                    "Dispatch History",
                    style: AppTextStyles.appDarkHeaderTextStyle,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(NotificationPage.routeName);
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Notifications",
                        style: AppTextStyles.appDarkHeaderTextStyle,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Chip(
                          backgroundColor: Colors.green,
                          label: Text(
                            "2",
                            style: AppTextStyles.appboldWhiteTextStyle,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Share.share(
                      "https://github.com/Dennis247/DispatchApp_Client",
                      subject: "Invite Your Friend To Dispatch App",
                    );
                  },
                  child: Text(
                    "Invite Friends",
                    style: AppTextStyles.appDarkHeaderTextStyle,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(SettingsPage.routeName);
                  },
                  child: Text(
                    "Settings",
                    style: AppTextStyles.appDarkHeaderTextStyle,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(AppSettings.routeName);
                  },
                  child: Text(
                    "App Settings",
                    style: AppTextStyles.appDarkHeaderTextStyle,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(SupportPage.routeName);
                  },
                  child: Text(
                    "Support",
                    style: AppTextStyles.appDarkHeaderTextStyle,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginPage.routeName);
                    authProvider.logOut();
                  },
                  child: Text("Log Out",
                      style: AppTextStyles.appDarkHeaderTextStyle),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
