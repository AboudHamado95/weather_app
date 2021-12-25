// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weatherapp/cache/cache_helper.dart';
import 'package:weatherapp/components/components.dart';
import 'package:weatherapp/presentation/screens/choose_city.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Color(0xff485078).withOpacity(0.5),
        elevation: 0.0,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          InkWell(
            onTap: () {
              navigateAndFinish(context, ChooseCity());
            },
            child: ListTile(
              leading: Icon(
                Icons.arrow_back_ios_new,
                size: 24.0,
              ),
              title: Text(
                'Choose another city',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 24.0),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              CacheHelper.signOut(context);
            },
            child: ListTile(
              leading: Icon(
                Icons.arrow_back_ios_new,
                size: 24.0,
              ),
              title: Text(
                'Sign out',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 24.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
