import 'dart:async';
import 'package:dispatch_app_client/src/lib_export.dart';
import 'package:dispatch_app_client/ui/widgets/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DispatchLocation extends StatefulWidget {
  static final routeName = "dispatch-location";
  final Dispatch dispatch;
  const DispatchLocation({Key key, this.dispatch}) : super(key: key);
  @override
  _DispatchLocationState createState() => _DispatchLocationState();
}

class _DispatchLocationState extends State<DispatchLocation> {
  double _currentRiderLatitude = 0.0;
  double _currentRiderLongitude;
  StreamSubscription subscription;

  LatLng myLocation = LatLng(6.5244, 3.3792);
  Completer<GoogleMapController> _controller = Completer();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  BitmapDescriptor _start;
  BitmapDescriptor _end;
  // PlaceDetail _startPlaceDetail = new PlaceDetail();
  //PlaceDetail _endPlaceDetail = new PlaceDetail();
  Set<Marker> _markers = {};
  LatLngBounds bound;
  String _mapStyle;

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/start.png')
        .then((onValue) {
      _start = onValue;
    });

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/end.png')
        .then((onValue) {
      _end = onValue;
    });

    rootBundle.loadString('assets/images/map_style.txt').then((string) {
      _mapStyle = string;
    });

    subscription =
        riderRef.child(widget.dispatch.dispatchRiderId).onValue.listen((event) {
      setState(() {
        _currentRiderLatitude = event.snapshot.value['latitude'];
        _currentRiderLongitude = event.snapshot.value['longitude'];
      });
      //animate camera here
      _markers = {
        Marker(
          markerId: MarkerId("xxx"),
          position: LatLng(_currentRiderLatitude, _currentRiderLongitude),
          icon: _start,
          infoWindow: InfoWindow(
            title: "Rider",
            snippet: "",
          ),
        ),
        Marker(
          markerId: MarkerId("zzz"),
          position: LatLng(widget.dispatch.destinationLatitude,
              widget.dispatch.destinationLongitude),
          icon: _end,
          infoWindow: InfoWindow(
            title: "destination",
            snippet: widget.dispatch.dispatchDestination,
          ),
        ),
      };

      _moveCamera();
    });
    super.initState();
  }

  void _getLatLngBounds(LatLng from, LatLng to) {
    if (from.latitude > to.latitude && from.longitude > to.longitude) {
      bound = LatLngBounds(southwest: to, northeast: from);
    } else if (from.longitude > to.longitude) {
      bound = LatLngBounds(
          southwest: LatLng(from.latitude, to.longitude),
          northeast: LatLng(to.latitude, from.longitude));
    } else if (from.latitude > to.latitude) {
      bound = LatLngBounds(
          southwest: LatLng(to.latitude, from.longitude),
          northeast: LatLng(from.latitude, to.longitude));
    } else {
      bound = LatLngBounds(southwest: from, northeast: to);
    }
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
      check(u, c);
  }

  void _moveCamera() async {
    setState(() {
      _markers.remove(_markers.elementAt(0));
    });
    _getLatLngBounds(
        LatLng(_currentRiderLatitude, _currentRiderLongitude),
        LatLng(widget.dispatch.destinationLatitude,
            widget.dispatch.destinationLongitude));
    GoogleMapController controller = await _controller.future;
    CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 50);
    controller.animateCamera(u2).then((void v) {
      check(u2, controller);
    });
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("xxx"),
          position: LatLng(_currentRiderLatitude, _currentRiderLongitude),
          icon: _start,
          infoWindow: InfoWindow(
            title: "Rider",
            snippet: "",
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final appSize = GlobalWidgets.getAppSize(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "CURRENT LOCATION",
            style: AppTextStyles.appLightHeaderTextStyle,
          ),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        key: _scaffoldKey,
        drawer: AppDrawer(),
        body: Container(
          width: appSize.width,
          height: appSize.height,
          child: GoogleMap(
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            markers: _markers,
            //  polylines: _polylines,
            initialCameraPosition: CameraPosition(target: myLocation, zoom: 12),
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(_mapStyle);
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }
}
