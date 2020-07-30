import 'dart:convert';

import 'package:dispatch_lib/dispatch_lib.dart';
import 'package:dispatch_lib/src/models/constants.dart';
import 'package:dispatch_lib/src/models/placeDetail.dart';
import 'package:dispatch_lib/src/services/settingsServices.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GoogleMapServices {
  List<LatLng> _polylineCoordinates;
  List<LatLng> get polylineCoordinates {
    return _polylineCoordinates;
  }

  Set<Polyline> _polylines;
  Set<Polyline> get polylines {
    return _polylines;
  }

  PlaceDetail _startPlaceDetail;
  PlaceDetail get startPlaceDetail {
    return _startPlaceDetail;
  }

  PlaceDetail _endPlaceDetail;
  PlaceDetail get endPlaceDetail {
    return _endPlaceDetail;
  }

  LatLngBounds _bounds;
  LatLngBounds get bounds {
    return _bounds;
  }

  Future<List> getSuggestions(String query, String sessionToken) async {
    final country = locator<SettingsServices>()
        .appSettings
        .countryAbbrevation
        .toLowerCase();
    final String baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = 'establishment';
    String apiKey = Constants.apiKey;
    String url =
        '$baseUrl?input=$query&key=$apiKey&type=$type&language=en&components=country:$country&sessiontoken=$sessionToken';
    print('Autocomplete(sessionToken): $sessionToken');

    final http.Response response = await http.get(url);
    final responseData = json.decode(response.body);
    final predictions = responseData['predictions'];
    List<Place> suggestions = [];
    for (int i = 0; i < predictions.length; i++) {
      final place = Place.fromJson(predictions[i]);
      suggestions.add(place);
    }

    return suggestions;
  }

  Future<PlaceDetail> getPlaceDetail(
      String placeId, String sessionToken) async {
    final String baseUrl =
        'https://maps.googleapis.com/maps/api/place/details/json';
    String apiKey = Constants.apiKey;
    String url =
        '$baseUrl?key=$apiKey&place_id=$placeId&language=en&sessiontoken=$sessionToken';
    print('Place Detail(sessionToken): $sessionToken');
    final http.Response response = await http.get(url);
    final responseData = json.decode(response.body);
    final result = responseData['result'];

    final PlaceDetail placeDetail = PlaceDetail.fromJson(result);
    print(placeDetail.toMap());

    return placeDetail;
  }

  getLatLngBounds(LatLng from, LatLng to) {
    if (from.latitude > to.latitude && from.longitude > to.longitude) {
      _bounds = LatLngBounds(southwest: to, northeast: from);
    } else if (from.longitude > to.longitude) {
      _bounds = LatLngBounds(
          southwest: LatLng(from.latitude, to.longitude),
          northeast: LatLng(to.latitude, from.longitude));
    } else if (from.latitude > to.latitude) {
      _bounds = LatLngBounds(
          southwest: LatLng(to.latitude, from.longitude),
          northeast: LatLng(from.latitude, to.longitude));
    } else {
      _bounds = LatLngBounds(southwest: from, northeast: to);
    }
  }

  Future<List<LatLng>> getPolyLines(
      // PlaceDetail startPlaceDetail,
      //  PlaceDetail endPlaceDetail,

      double _startPlaceDetaillat,
      double _startPlaceDetaillng,
      double _endPlaceDetaillat,
      double _endPlaceDetaillng) async {
        final polyCordinates =
    _startPlaceDetail = startPlaceDetail;
    _endPlaceDetail = endPlaceDetail;
    PolylinePoints polylinePoints = PolylinePoints();
    _polylineCoordinates = [];
    _polylines = {};
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constants.apiKey,
        PointLatLng(_startPlaceDetaillat, _startPlaceDetaillng),
        PointLatLng(_endPlaceDetaillat, _endPlaceDetaillng),
        travelMode: TravelMode.driving,
        wayPoints: []);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      return _polylineCoordinates;
    }
  }

  Future<void> getDemoDetails(double riderLat, double riderLng,
      double destinationLat, double destinationLng) async {
    _polylineCoordinates = [];
    _polylines = {};
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constants.apiKey,
        PointLatLng(riderLat, riderLng),
        PointLatLng(destinationLat, destinationLng),
        travelMode: TravelMode.driving,
        wayPoints: []);

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      Polyline polyline = Polyline(
          polylineId: PolylineId('poly'),
          color: Constants.primaryColorDark,
          width: 4,
          points: polylineCoordinates);
      _polylines.add(polyline);
    }
  }
}
