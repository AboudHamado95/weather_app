class Hourly {
  late int dt;
  late double temp;
  late double feelsLike;
  late double pressure;
  late double dewPoint;
  late double uvi;
  late double visibility;
  late double wind;
  late String description;
  late String icon;

  Hourly(
      {required this.dt,
      required this.temp,
      required this.feelsLike,
      required this.pressure,
      required this.dewPoint,
      required this.uvi,
      required this.visibility,
      required this.wind,
      required this.description,
      required this.icon});

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      dt: json['dt'].toInt(),
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      pressure: json['pressure'].toDouble(),
      dewPoint: json['dew_point'].toDouble(),
      uvi: json['uvi'].toDouble(),
      visibility: json['visibility'].toDouble(),
      wind: json['wind_speed'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
