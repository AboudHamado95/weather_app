class Coord {
  late double lon;
  late double lat;

  Coord({required this.lon, required this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'] ?? 0;
    lat = json['lat'] ?? 0;
  }
}

class Sys {
  late int type;
  late int id;
  late String country;
  late int sunrise;
  late int sunset;

  Sys(
      {required this.type,
      required this.id,
      required this.country,
      required this.sunrise,
      required this.sunset});

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? 0;
    id = json['id'] ?? 0;
    country = json['country'] ?? "";
    sunrise = json['sunrise'] ?? "";
    sunset = json['sunset'] ?? "";
  }
}

class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'] ?? '';
    final icon = json['icon'] ?? '';
    return WeatherInfo(description: description, icon: icon);
  }
}

class TemperatureInfo {
  final double temperature;

  TemperatureInfo({required this.temperature});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'] ?? 0;
    return TemperatureInfo(temperature: temperature);
  }
}

class WeatherResponse {
  final String cityName;
  final Coord coord;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;
  final Sys sys;
  final int cod;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse(
      {required this.cityName,
      required this.coord,
      required this.tempInfo,
      required this.weatherInfo,
      required this.sys,
      required this.cod});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'] ?? '';
    final coordJson = json['coord'];
    final coord = Coord.fromJson(coordJson);
    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);
    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);
    final sys = Sys.fromJson(json['sys']);
    final cod = json['cod'];

    return WeatherResponse(
        cityName: cityName,
        coord: coord,
        tempInfo: tempInfo,
        weatherInfo: weatherInfo,
        sys: sys,
        cod: cod);
  }
}
