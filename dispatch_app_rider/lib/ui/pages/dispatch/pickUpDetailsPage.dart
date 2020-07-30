import 'package:dispatch_app_rider/src/lib_export.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PickUpDetailsPage extends StatelessWidget {
  final Dispatch dispatch;
  final Rider rider;

  const PickUpDetailsPage({Key key, this.dispatch, this.rider})
      : super(key: key);

  _buildRowItem(String title, String subTitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: AppTextStyles.smallgreyTextStyle,
        ),
        Text(
          subTitle,
          style: AppTextStyles.appTextStyle,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appSzie = GlobalWidgets.getAppSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PICKUP DETAILS",
          style: AppTextStyles.appLightHeaderTextStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: appSzie.width,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.user,
                        size: 120,
                        color: Constants.primaryColorDark,
                      ),
                      SizedBox(
                        height: appSzie.height * 0.02,
                      ),
                      Text(
                        "Rider",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.smallprimaryColorTextStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: appSzie.height * 0.03,
                ),
                _buildRowItem("Rider Name", rider.fullName),
                Divider(),
                _buildRowItem("Rider PhoneNumber", rider.phoneNumber),
                Divider(),
                _buildRowItem("Pick up Address", dispatch.pickUpLocation),
                Divider(),
                _buildRowItem("Delivery Address", dispatch.dispatchDestination),
                Divider(),
                _buildRowItem("Recipient Name", dispatch.dispatchReciever),
                Divider(),
                _buildRowItem(
                    "Recipient PhoneNumber", dispatch.dispatchRecieverPhone),
                Divider(),
                _buildRowItem(
                    "Package Description", dispatch.dispatchDescription),
                SizedBox(
                  height: appSzie.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
