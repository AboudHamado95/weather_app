// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weatherapp/models/current.dart';
import 'package:weatherapp/presentation/screens/settings.dart';
import 'package:weatherapp/presentation/screens/weather_page.dart';

class HomePage extends StatefulWidget {
  final WeatherResponse city;
  const HomePage({Key? key, required this.city}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TabBarView(
          children: [WeatherPage(city: widget.city), SettingsPage()],
          controller: tabController,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            child: Container(
              color: Colors.black54,
              child: TabBar(
                controller: tabController,
                indicatorColor: Colors.red,
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  Tab(
                    icon: Icon(MdiIcons.weatherCloudyClock,color: Colors.red[400],),
                    text: 'Home',
                  ),
                  Tab(
                    icon: Icon(Icons.settings,color: Colors.grey[350],),
                    text: 'Settings',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
