import 'package:dispatch_app_rider/ui/pages/dispatch/dispatchDetails.dart';
import 'package:dispatch_app_rider/ui/pages/dispatch/pickUpDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:dispatch_app_rider/src/lib_export.dart';

class NotificationWidget extends StatelessWidget {
  final DispatchNotification dispatchNotification;
  const NotificationWidget({Key key, this.dispatchNotification})
      : super(key: key);
  _buildRideInfo(
    String point,
    String title,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(
              FontAwesomeIcons.bell,
              size: 20,
              color: color,
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('$point', style: AppTextStyles.smallDarkTextStyle),
              SizedBox(
                height: 3,
              ),
              Text(
                title,
                style: AppTextStyles.appTextStyle,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildBottomInfo(IconData iconData, String title, Color statusColor) {
    return Row(
      children: <Widget>[
        Icon(
          iconData,
          size: 20,
          color: statusColor,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: AppTextStyles.smallgreyTextStyle,
        ),
      ],
    );
  }

  _navigateToNotificationDetails(
      DispatchNotification dispatchNotification, BuildContext context) async {
    if (dispatchNotification.notificationType ==
        Constants.pickUpDispatchNotification) {
      // go to pickUp Details Page with all required data
      var detailsResponse = await Provider.of<AUthProvider>(context,
              listen: false)
          .getPickUpDetails(
              dispatchNotification.riderId, dispatchNotification.dispatchId);
      if (!detailsResponse.item1.isSUcessfull) {
        GlobalWidgets.showFialureDialogue(
            detailsResponse.item1.responseMessage, context);
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PickUpDetailsPage(
                  dispatch: detailsResponse.item3,
                  rider: detailsResponse.item2,
                )));
      }
    } else {
      // go to dispatch Details Page using id
      var dispatchReponse =
          await Provider.of<DispatchProvider>(context, listen: false)
              .getDispatch(dispatchNotification.dispatchId);
      if (!dispatchReponse.item1.isSUcessfull) {
        GlobalWidgets.showFialureDialogue(
            dispatchReponse.item1.responseMessage, context);
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DispatchDetails(
                  dispatch: dispatchReponse.item2,
                  isNotificationType: true,
                )));
      }
    }
  }

  Color _getDispatchTypeColor(String notificationType) {
    if (notificationType == Constants.pickUpDispatchNotification) {
      return Colors.deepPurple;
    } else if (notificationType == Constants.completedDispatchNotification) {
      return Colors.green;
    } else if (notificationType == Constants.pendingDispatchNotification) {
      return Colors.red;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToNotificationDetails(dispatchNotification, context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
        child: Card(
          shadowColor: Constants.primaryColorDark,
          elevation: 2,
          child: Container(
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                      child: _buildRideInfo(
                          dispatchNotification.notificationType,
                          dispatchNotification.message,
                          _getDispatchTypeColor(
                              dispatchNotification.notificationType)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _buildBottomInfo(
                            Icons.phone,
                            dispatchNotification.recipientPhone,
                            Constants.primaryColorDark),
                        _buildBottomInfo(
                            FontAwesomeIcons.clock,
                            timeago
                                .format(dispatchNotification.notificationDate),
                            Constants.primaryColorDark)
                      ],
                    ),
                  ],
                ),
              ],
            ),
            margin: EdgeInsets.only(left: 5, right: 5),
            height: 150,
          ),
        ),
      ),
    );
  }
}
