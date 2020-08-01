import 'package:dispatch_lib/dispatch_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:background_location/background_location.dart';

class LocationProvider with ChangeNotifier {
  Future<void> getRiderLocationUpdate(BuildContext context) async {
    BackgroundLocation.getPermissions(
      onGranted: () {
        //get current device location
        BackgroundLocation.startLocationService();
        BackgroundLocation().getCurrentLocation().then((location) {
          //update the current location in database
          _updateCurrentRiderLocation(
              latitude: location.latitude, longitude: location.longitude);
        });
        //get device location as it changes
        BackgroundLocation.getLocationUpdates((location) {
          //update current location in database
          _updateCurrentRiderLocation(
              latitude: location.latitude, longitude: location.longitude);
        });
      },
      onDenied: () {
        // Show a message asking the user to reconsider or do something else
        //throw execption that location has been denied
        // GlobalWidgets.showFialureDialogue(
        //     "Failed To Turn On Location \n Turn On location", context);
      },
    );
  }

  Future<void> startLocationService({bool start}) async {
    BackgroundLocation.getPermissions(
      onGranted: () {
        //get current device location
        if (!start) {
          BackgroundLocation.startLocationService();
          BackgroundLocation().getCurrentLocation().then((location) {
            //update the current location in database
            _updateCurrentRiderLocation(
                latitude: location.latitude, longitude: location.longitude);
          });
          //get device location as it changes
          BackgroundLocation.getLocationUpdates((location) {
            //update current location in database
            _updateCurrentRiderLocation(
                latitude: location.latitude, longitude: location.longitude);
          });
        } else {
          BackgroundLocation.stopLocationService();
        }
      },
      onDenied: () {
        // Show a message asking the user to reconsider or do something else
        //throw execption that location has been denied
        // GlobalWidgets.showFialureDialogue(
        //     "Failed To Turn On Location \n Turn On location", context);
      },
    );
  }

  _updateCurrentRiderLocation({double latitude, double longitude}) {
    try {
      riderRef.child(loggedInRider.id).set({
        "id": loggedInRider.id,
        "email": loggedInRider.email,
        "fullname": loggedInRider.fullName,
        "phoneNumber": loggedInRider.phoneNumber,
        "token": loggedInRider.token,
        "latitude": latitude,
        "longitude": longitude
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
