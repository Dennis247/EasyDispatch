import 'package:dispatch_app_client/src/lib_export.dart';
import 'package:dispatch_app_client/ui/pages/dispatch/demoDispatchLocation.dart';
import 'package:dispatch_app_client/ui/pages/dispatch/dispatchStausPage.dart';
import 'package:dispatch_app_client/ui/pages/home/homePage.dart';
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

  _buildCardHeader(IconData iconData, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 0),
      child: Row(
        children: <Widget>[
          Icon(iconData, color: Constants.primaryColorDark),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: AppTextStyles.orangeTextStyle,
          ),
        ],
      ),
    );
  }

  _completeDispatch() async {
    //update dispatch Status as completed
    GlobalWidgets.showConfirmationDialogue(
        Constants.confirmDispatchCompleteMessage, context, () async {
      _startLoading(true);
      final ResponseModel responseModel =
          await Provider.of<DispatchProvider>(context, listen: false)
              .updateDispatchStatus(
                  widget.dispatch.id, Constants.dispatchCompletedStatus);
      if (!responseModel.isSUcessfull) {
        GlobalWidgets.showFialureDialogue(
            responseModel.responseMessage, context);
        return;
      } else {
        Provider.of<NotificationProvider>(context, listen: false)
            .displayNotification("Dispatch Completed",
                "Dispatch Completed for ${widget.dispatch.dispatchReciever}");

        // create completed dispatch Notification
        Provider.of<NotificationProvider>(context, listen: false)
            .createCompletedNotification(widget.dispatch);
      }
      _startLoading(false);
      //goto dashboard
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HompePage()),
          (Route<dynamic> route) => false);
    });
  }

  _buildCardInfo(Map<String, String> infoList, Size appSzie) {
    List<Widget> children = [];
    infoList.forEach((key, value) {
      children.add(Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_buildRowDetails(key, value), Divider()],
      ));
    });
    return Card(
      elevation: 2,
      child: Container(
        width: appSzie.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children),
        ),
      ),
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
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildCardHeader(
                      FontAwesomeIcons.solidAddressBook,
                      "Dispatch Recipient",
                    ),
                    _buildCardInfo({
                      "Name": widget.dispatch.dispatchReciever,
                      "Phone Number": widget.dispatch.dispatchRecieverPhone,
                      "Location": widget.dispatch.dispatchDestination,
                      "Package Descriptiuon":
                          widget.dispatch.dispatchDescription
                    }, appSzie),
                  ],
                ),
                SizedBox(
                  height: appSzie.height * 0.05,
                ),
                _buildCardHeader(Icons.location_on, "Dispatch Trip"),
                _buildCardInfo({
                  "Dispatch Type": widget.dispatch.dispatchType,
                  "Pick up": widget.dispatch.pickUpLocation,
                  "destination": widget.dispatch.dispatchDestination,
                  "estimated duration":
                      widget.dispatch.estimatedDIspatchDuration,
                  "Distance in KM": widget.dispatch.estimatedDistance,
                  "Cost Per KM": "N100 per KM",
                  "Total Cosst": "N5,000"
                }, appSzie),
                SizedBox(
                  height: appSzie.height * 0.05,
                ),
                _buildCardHeader(
                    FontAwesomeIcons.shippingFast, "Dispatch Status"),
                Card(
                  elevation: 2,
                  child: Container(
                    width: appSzie.width,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          _buildRowDetails2(
                              "Delivery Status",
                              widget.dispatch.dispatchStatus,
                              Icons.cancel,
                              "CANCEL", () async {
                            //   _startLoading(true);
                            //show warning dialogue
                            GlobalWidgets.showConfirmationDialogue(
                                "Please Confirm Cancel DIspatch", context,
                                () async {
                              final response =
                                  await Provider.of<DispatchProvider>(context,
                                          listen: false)
                                      .updateDispatchStatus(widget.dispatch.id,
                                          Constants.dispatchCancelledStatus);
                              if (response.isSUcessfull == true) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => DispatchStatus(
                                              dispatchMessage: Constants
                                                  .cancellDispatchMessage,
                                              imageUrl:
                                                  "assets/images/premiun.png",
                                              isDispatchProcessing: false,
                                            )),
                                    (Route<dynamic> route) => false);
                              } else {
                                _startLoading(false);
                                GlobalWidgets.showFialureDialogue(
                                    response.responseMessage, context);
                              }
                            });
                          }),
                          _showCurrentLocation() ? Divider() : SizedBox(),
                          _showCurrentLocation()
                              ? _buildRowDetails2(
                                  "current location",
                                  widget.dispatch.currentLocation,
                                  FontAwesomeIcons.mapPin,
                                  "Map", () {
                                  //check to see if it demo mode and display demo else use real time
                                  final settings =
                                      locator<SettingsServices>().appSettings;
                                  if (settings.isDemoMode) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DemoDispatchLocation(
                                                  dispatch: widget.dispatch,
                                                )));
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DispatchLocation(
                                                  dispatch: widget.dispatch,
                                                )));
                                  }
                                })
                              : SizedBox(),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                )
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
                        buttonText: "COMPLETE DISPATCH",
                        function: () {
                          _completeDispatch();
                        }),
                  ),
                )
              : Text(""))
          : Text(""),
    );
  }
}
