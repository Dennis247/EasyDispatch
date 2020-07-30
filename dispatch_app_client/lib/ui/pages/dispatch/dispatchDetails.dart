import 'package:dispatch_app_client/src/lib_export.dart';
import 'package:dispatch_app_client/ui/pages/dispatch/demoDispatchLocation.dart';
import 'package:dispatch_app_client/ui/pages/dispatch/dispatchStausPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'dispatchLocation.dart';

class DispatchDetails extends StatefulWidget {
  final Dispatch dispatch;
  final bool isNotificationType;
  const DispatchDetails({Key key, this.dispatch, this.isNotificationType})
      : super(key: key);

  @override
  _DispatchDetailsState createState() => _DispatchDetailsState();
}

class _DispatchDetailsState extends State<DispatchDetails> {
  bool _isLoading = false;

  void _startLoading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  _buildRowDetails(String title, String subTitle) {
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

  _buildRowDetails2(String title, String subTitle, IconData iconData,
      String iconTitle, Function function) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Column(
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
          ),
        ),
        _showCancelMapButton() == true
            ? SizedBox(
                width: 100,
                child: RaisedButton.icon(
                    color: Constants.primaryColorLight,
                    shape: StadiumBorder(),
                    onPressed: function,
                    icon: Icon(
                      iconData,
                      size: 16,
                      color: Constants.primaryColorDark,
                    ),
                    label: Text(
                      iconTitle,
                      style: AppTextStyles.smallDarkTextStyle,
                    )),
              )
            : Text("")
      ],
    );
  }

  _showCancelMapButton() {
    if (widget.isNotificationType) {
      return false;
    }
    if (widget.dispatch.dispatchStatus == Constants.dispatchCompletedStatus ||
        widget.dispatch.dispatchStatus == Constants.dispatchCancelledStatus)
      return false;
    return true;
  }

  _showCurrentLocation() {
    if (widget.dispatch.dispatchStatus == Constants.dispatchCompletedStatus ||
        widget.dispatch.dispatchStatus == Constants.dispatchCancelledStatus ||
        widget.dispatch.dispatchStatus == Constants.dispatchPendingStatus)
      return false;
    return true;
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Reciever",
                      style: AppTextStyles.orangeTextStyle,
                    ),
                    Card(
                      child: Container(
                        width: appSzie.width,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildRowDetails(
                                  "Name", widget.dispatch.dispatchReciever),
                              Divider(),
                              _buildRowDetails("Phone Number",
                                  widget.dispatch.dispatchRecieverPhone),
                              Divider(),
                              _buildRowDetails("Location",
                                  widget.dispatch.dispatchDestination),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                // _buildRowDetails("Pick Up", widget.dispatch.pickUpLocation),
                // Divider(),
                // _buildRowDetails(
                //     "Delivery Location", widget.dispatch.dispatchDestination),
                // Divider(),
                // _buildRowDetails(
                //     "Dispatch Description",
                //     widget.dispatch.dispatchDescription != null
                //         ? widget.dispatch.dispatchDescription
                //         : ""),
                // Divider(),
                // _buildRowDetails("Dispatch Type", widget.dispatch.dispatchType),
                // Divider(),
                // _buildRowDetails(
                //     "Total Distance", widget.dispatch.estimatedDistance),
                // Divider(),
                // _isLoading
                //     ? GlobalWidgets.circularInidcator()
                //     : _buildRowDetails2(
                //         "Delivery Status",
                //         widget.dispatch.dispatchStatus,
                //         Icons.cancel,
                //         "CANCEL", () async {
                //         //   _startLoading(true);
                //         //show warning dialogue
                //         GlobalWidgets.showConfirmationDialogue(
                //             "Please Confirm Cancel DIspatch", context,
                //             () async {
                //           final response = await Provider.of<DispatchProvider>(
                //                   context,
                //                   listen: false)
                //               .updateDispatchStatus(widget.dispatch.id,
                //                   Constants.dispatchCancelledStatus);
                //           if (response.isSUcessfull == true) {
                //             Navigator.of(context).pushAndRemoveUntil(
                //                 MaterialPageRoute(
                //                     builder: (context) => DispatchStatus(
                //                           dispatchMessage:
                //                               Constants.cancellDispatchMessage,
                //                           imageUrl: "assets/images/premiun.png",
                //                           isDispatchProcessing: false,
                //                         )),
                //                 (Route<dynamic> route) => false);
                //           } else {
                //             _startLoading(false);
                //             GlobalWidgets.showFialureDialogue(
                //                 response.responseMessage, context);
                //           }
                //         });
                //       }),
                // _showCurrentLocation() ? Divider() : SizedBox(),
                // _showCurrentLocation()
                //     ? _buildRowDetails2(
                //         "current location",
                //         widget.dispatch.currentLocation,
                //         FontAwesomeIcons.mapPin,
                //         "Map", () {
                //         //check to see if it demo mode and display demo else use real time
                //         final settings =
                //             locator<SettingsServices>().appSettings;
                //         if (settings.isDemoMode) {
                //           Navigator.of(context).push(MaterialPageRoute(
                //               builder: (context) => DemoDispatchLocation(
                //                     dispatch: widget.dispatch,
                //                   )));
                //         } else {
                //           Navigator.of(context).push(MaterialPageRoute(
                //               builder: (context) => DispatchLocation(
                //                     dispatch: widget.dispatch,
                //                   )));
                //         }
                //       })
                //     : SizedBox(),
                // Divider(),
                // _buildRowDetails("Base Delivery Fee",
                //     widget.dispatch.dispatchBaseFare.toString()),
                // Divider(),
                // _buildRowDetails("Total Delivery Fee",
                //     widget.dispatch.dispatchTotalFare.toString()),
                // Divider(),
                // _buildRowDetails(
                //     "Reciever Name", widget.dispatch.dispatchReciever),
                // Divider(),
                // _buildRowDetails("Reciever PhoneNumber",
                //     widget.dispatch.dispatchRecieverPhone),
                // SizedBox(
                //   height: appSzie.height * 0.04,
                // ),
                // SizedBox(
                //   height: appSzie.height * 0.02,
                // ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: !widget.isNotificationType
          ? (widget.dispatch.dispatchStatus == Constants.dispatchActiveStatus
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: AppRectButtonWidget(
                      width: appSzie.width,
                      buttonText: "COMPLTE DISPATCH",
                      function: () {
                        GlobalWidgets.showConfirmationDialogue(
                            "Confirm that your dispatch is complete", context,
                            () async {
                          Provider.of<DispatchProvider>(context, listen: false)
                              .updateDispatchStatus(widget.dispatch.id,
                                  Constants.dispatchCompletedStatus);
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => DispatchStatus(
                                        dispatchMessage:
                                            "Dispatch Complted Sucessfully",
                                        isDispatchProcessing: false,
                                        imageUrl: "assets/images/express.png",
                                      )));
                        });
                      },
                    ),
                  ),
                )
              : Text(""))
          : Text(""),
    );
  }
}
