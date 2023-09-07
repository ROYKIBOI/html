import 'dart:convert';
import 'package:http/http.dart' as http;

Future<double> getDistanceFromGoogleMaps(String origin, String destination) async {
  // Replace with your own API key
  String apiKey = 'YOUR_API_KEY_HERE';
  String url = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$origin&destinations=$destination&key=$apiKey';
  http.Response response = await http.get(Uri.parse(url));
  Map<String, dynamic> data = jsonDecode(response.body);
  double distanceInMeters = data['rows'][0]['elements'][0]['distance']['value'];
  double distanceInKm = distanceInMeters / 1000;
  return distanceInKm;
}

Future<double> calculateCost(String location, String businessLocation) async {
  // Calculate the distance between the business location and the customer location
  double distance = await getDistanceFromGoogleMaps(businessLocation, location);

  // Calculate the cost based on your algorithm
  double cost;
  if (distance <= 4) {
    cost = 100;
  } else {
    cost = distance * 25;
    if (cost % 10 == 5) {
      cost = (cost / 10).ceil() * 10;
    }
  }

  return cost;
}
