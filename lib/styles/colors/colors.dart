// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

const defaultColor = Colors.blue;
List<Color> lightWeatherColor = <Color>[Color(0xffF8B8A0), 
Color(0xffE87098)];
final Shader linearGradient = LinearGradient(
  colors: <Color>[Color(0xffF8B098), Color(0xffF06898)],
).createShader(Rect.fromLTWH(0.0, 0.0, 0.0, 0.0));

List<Color> moonColor = <Color>[
  Color(0xff182860),
  // Color(0xffD8D8E0),
  Color(0xff485078)
];
