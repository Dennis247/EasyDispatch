import 'package:dispatch_app_rider/src/lib_export.dart';
import 'package:flutter/material.dart';

class ConfirmDispatch extends StatelessWidget {
  static final String routeName = "confirm-dispatch";

  _buildConfrimRowItem(String title, String subTitle) {
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
          "DISPATCH DETAILS",
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
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildConfrimRowItem(
                      Constants.pickUp, Constants.dispatchPickIpAddress),
                  Divider(),
                  _buildConfrimRowItem(Constants.deliveryAddress,
                      Constants.dispatchDestinationAddress),
                  Divider(),
                  _buildConfrimRowItem(
                      "Dispatch Type", currentDispatch.dispatchType),
                  Divider(),
                  _buildConfrimRowItem("Total Distance", "50 KM"),
                  Divider(),
                  _buildConfrimRowItem("Estimated Time", "1hr"),
                  Divider(),
                  _buildConfrimRowItem("Base Delivery Fee", "N 1000"),
                  Divider(),
                  _buildConfrimRowItem("Total Delivery Fee", "N 5000"),
                  Divider(),
                  _buildConfrimRowItem("Reciever Name", "Dennis Osagiede"),
                  Divider(),
                  _buildConfrimRowItem("Reciever PhoneNumber", "08167828256"),
                  SizedBox(
                    height: appSzie.height * 0.05,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: AppButtonWudget(
                      buttonText: "CONFIRM DISPATCH",
                      function: () {
                        Navigator.of(context).pushNamed("/");
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
