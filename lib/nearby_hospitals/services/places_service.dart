import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:self_care/nearby_hospitals/constants/error_messages.dart';
import 'package:self_care/nearby_hospitals/customError/fault.dart';
import 'package:self_care/nearby_hospitals/models/venue.dart';

class PlacesService {
  static final PlacesService _placesService = PlacesService._internal();

  factory PlacesService() {
    return _placesService;
  }

  PlacesService._internal();

  getNearestPlaces(
    String clientId,
    String clientSecret,
    String apiVersion,
    String lat,
    String long,
    String radius,
  ) async {
    String venueSearchEndPoint =
        "https://api.foursquare.com/v2/venues/search?ll=$lat,$long &query=heart hospital &radius=$radius&client_id=$clientId&client_secret=$clientSecret&v=$apiVersion";
    try {
      var response = await http.get(Uri.parse(venueSearchEndPoint));
      var venue = venueFromJson(response.body);
      return venue;
    } on SocketException {
      throw Fault(message: NO_INTERNET_CONNECTION);
    } on HttpException {
      throw Fault(message: CAN_NOT_REACH_SERVER);
    }
  }
}
