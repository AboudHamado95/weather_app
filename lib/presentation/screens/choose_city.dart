import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weatherapp/components/components.dart';
import 'package:weatherapp/models/current.dart';
import 'package:weatherapp/networks/data_service.dart';
import 'package:weatherapp/presentation/layouts/home_page.dart';
import 'package:weatherapp/presentation/screens/weather_page.dart';

class ChooseCity extends StatefulWidget {
  const ChooseCity({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChooseCityState();
}

class _ChooseCityState extends State<ChooseCity> {
  final _cityTextController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  WeatherResponse? weatherResponse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          defaultFormFeild(
                              controller: _cityTextController,
                              type: TextInputType.name,
                              returnValidate: 'please enter the city!',
                              label: 'City',
                              prefix: MdiIcons.cityVariant,
                              onSubmit: (text) {}),
                          const SizedBox(height: 15.0),
                          defaultButton(
                            function: () async {
                              if (formKey.currentState!.validate()) {
                                await _search();
                                Future.delayed(const Duration(seconds: 2));
                                if (weatherResponse != null) {
                                  navigateAndFinish(
                                      context,
                                      HomePage(
                                        city: weatherResponse!,
                                      ));
                                }
                              }
                            },
                            text: 'Search',
                            isUpperCase: true,
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _search() async {
    await getWeather(_cityTextController.text).then((value) {
      setState(() => weatherResponse = value);
    }).catchError((error) {
      showToast(message: 'The city not found!', state: ToastStates.ERROR);
    });
  }
}
