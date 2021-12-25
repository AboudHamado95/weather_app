import 'dart:convert';

import 'package:weatherapp/components/components.dart';
import 'package:weatherapp/models/current.dart';
import 'package:weatherapp/models/forcast.dart';
import 'package:weatherapp/models/location.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/models/weather.dart';

Future getCurrentWeather(String city) async {
  Weather? weather;
  String apiKey = "6af347f7298238e4454a2d4b5aed607f";
  var url =
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  }

  return weather!;
}

Future getForecast(WeatherResponse location) async {
  Forecast? forecast;
  String apiKey = "6af347f7298238e4454a2d4b5aed607f";
  double lat = location.coord.lat;
  double lon = location.coord.lon;
  var url =
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    forecast = Forecast.fromJson(jsonDecode(response.body));
  }

  return forecast!;
}

Future<dynamic> getWeather(String city) async {
  // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

  final queryParameters = {
    'q': city,
    'appid': '6af347f7298238e4454a2d4b5aed607f',
    'units': 'imperial'
  };

  final uri =
      Uri.https('api.openweathermap.org', '/data/2.5/weather', queryParameters);

  final response = await http.get(uri);

  print(response.body);
  final json = jsonDecode(response.body.toString());
  print(json['cod']);
  return WeatherResponse.fromJson(json);
}
