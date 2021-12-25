import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/cache/cache_helper.dart';
import 'package:weatherapp/constants/constants.dart';
import 'package:weatherapp/cubit/login/login_cubit.dart';
import 'package:weatherapp/cubit/register/register_cubit.dart';
import 'package:weatherapp/presentation/screens/choose_city.dart';
import './cubit/bloc_observe.dart';
import 'package:weatherapp/presentation/auth/login_screen.dart';
import 'package:weatherapp/styles/themes/themes.dart';

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
    () {
      LoginCubit();
      RegisterCubit();
    },
    blocObserver: MyBlocObserver(),
  );
  await CacheHelper.init();
  Widget? widget;
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = const  ChooseCity();
  } else {
    widget = LoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      // darkTheme: darkTheme,
      home: startWidget,
    );
  }
}
