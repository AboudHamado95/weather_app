// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:weatherapp/cache/cache_helper.dart';
import 'package:weatherapp/models/current.dart';
import 'package:weatherapp/models/forcast.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/networks/data_service.dart';
import 'package:weatherapp/styles/colors/colors.dart';

class WeatherPage extends StatefulWidget {
  final WeatherResponse city;
  const WeatherPage({Key? key, required this.city}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(child: getCurrentWeatherWidget(widget.city));
  }

  Widget forcastViewsHourly(WeatherResponse location) {
    Forecast? _forcast;

    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _forcast = snapshot.data as Forecast?;
          if (_forcast == null) {
            return Text("Error getting weather");
          } else {
            return hourlyBoxes(_forcast!);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
      future: getForecast(widget.city),
    );
  }

  Widget hourlyBoxes(Forecast _forecast) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 0.0),
        height: 140.0,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 0, bottom: 0, right: 8),
            scrollDirection: Axis.horizontal,
            itemCount: _forecast.hourly.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 15, bottom: 15, right: 10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 1), // changes position of shadow
                        )
                      ]),
                  child: Column(children: [
                    Text(
                      "${_forecast.hourly[index].temp}°",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.black),
                    ),
                    getWeatherIcon(_forecast.hourly[index].icon),
                    Text(
                      getTimeFromTimestamp(_forecast.hourly[index].dt),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                  ]));
            }));
  }

  String getTimeFromTimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = DateFormat('h:mm a');
    return formatter.format(date);
  }

  Image getWeatherIcon(String _icon) {
    String path = 'assets/images/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 50,
      height: 50,
    );
  }

  Image getWeatherIconSmall(String _icon) {
    String path = 'assets/images/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 40,
      height: 40,
    );
  }

  Widget getCurrentWeatherWidget(WeatherResponse location) {
    Weather? weather;
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          weather = snapshot.data as Weather?;
          if (weather == null) {
            return Text("Error getting weather");
          } else {
            return currentWeatherWidget(weather!, context);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
      future: getCurrentWeather(location.cityName),
    );
  }

  Widget currentWeatherWidget(Weather weather, context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.city.cityName,
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                    child: Text(
                      '${weather.temp}\u00B0',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  Container(
                    height: 25.0,
                    margin: EdgeInsets.only(top: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text(
                        weather.description,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                MdiIcons.waterOutline,
                                color: Color(0xff182860),
                              ),
                              SizedBox(width: 12.0),
                              Text('${weather.humidity / 100}%')
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.info_outline),
                              SizedBox(width: 12.0),
                              Text('${weather.pressure / 1000} mBar')
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.air),
                              SizedBox(width: 12.0),
                              Text('${weather.wind}km/m')
                            ],
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    children: [
                      Container(
                        child: getWeatherIcon('01d'),
                        height: 20.0,
                        width: 20.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffFFF9C4),
                              blurRadius: 40.0,
                              spreadRadius: 20.0,
                              offset: Offset(
                                -10.0,
                                5.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Text(getTimeFromTimestamp(widget.city.sys.sunrise))
                    ],
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: getWeatherIcon('01n'),
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff182860),
                              blurRadius: 40.0,
                              spreadRadius: 0.5,
                              offset: Offset(
                                -10.0,
                                5.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      // Icon(Icons.wb_sunny_sharp),
                      SizedBox(width: 12.0),
                      Text(getTimeFromTimestamp(widget.city.sys.sunset))
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              Text('Today',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontSize: 20.0)),
              SizedBox(
                height: 12.0,
              ),
              forcastViewsHourly(widget.city),
              forcastViewsDaily(widget.city),
            ],
          ),
        ),
        Positioned(
          top: -40.0,
          right: -60.0,
          child: Container(
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: lightWeatherColor[0],
                    blurRadius: 40.0, // has the effect of softening the shadow
                    spreadRadius:
                        15.0, // has the effect of extending the shadow
                    offset: Offset(
                      -10.0, // horizontal, move right 10
                      5.0, // vertical, move down 10
                    ),
                  )
                ],
                gradient: LinearGradient(
                    colors: lightWeatherColor,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                shape: BoxShape.circle),
          ),
        ),
        Positioned(
          top: 45.0,
          right: 25.0,
          child: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: moonColor,
                    end: Alignment.centerLeft,
                    begin: Alignment.topRight),
                shape: BoxShape.circle),
          ),
        ),
        Positioned(
          top: 30.0,
          right: -20.0,
          child: Container(
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: moonColor,
                    end: Alignment.centerLeft,
                    begin: Alignment.topRight),
                shape: BoxShape.circle),
          ),
        ),
        Positioned(
          right: 70.0,
          top: 40.0,
          child: Icon(
            Icons.cloud,
            size: 144.0,
            color: Color(0xff485078),
          ),
        )
      ],
    );
  }

  Widget forcastViewsDaily(WeatherResponse location) {
    Forecast? _forcast;

    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _forcast = snapshot.data as Forecast?;
          if (_forcast == null) {
            return Text("Error getting weather");
          } else {
            return dailyBoxes(_forcast!);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
      future: getForecast(location),
    );
  }

  Widget dailyBoxes(Forecast _forcast) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
        itemCount: _forcast.daily.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding:
                  const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
              margin: const EdgeInsets.all(5),
              child: Row(children: [
                Expanded(
                    child: Text(
                  getDateFromTimestamp(_forcast.daily[index].dt),
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
                Expanded(
                    child: getWeatherIconSmall(_forcast.daily[index].icon)),
                Expanded(
                    child: Text(
                  "${_forcast.daily[index].high.toInt()}/${_forcast.daily[index].low.toInt()}",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                )),
              ]));
        });
  }

  String getDateFromTimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = DateFormat('E');
    return formatter.format(date);
  }
}


