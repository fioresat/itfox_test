import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:itfox_test/screens/login_view.dart';
import 'package:itfox_test/screens/searching_view.dart';
import 'package:itfox_test/screens/splash_view.dart';
import 'package:itfox_test/screens/weather_view.dart';

import 'bloc/app_bloc.dart';
import 'model/weather_data.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(WeatherDataAdapter());
  await Hive.openBox('weather_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc()
        ..add(
          const AppEventInitialize(),
        ),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState) {
            if (appState is AppStateLoggedOut) {
              if (appState.message != '') {
                _showSnackBar(context, appState.message);
              }
            }
          },
          builder: (context, appState) {
            if (appState is AppStateSplashScreen) {
              return const SplashView();
            } else if (appState is AppStateLoggedOut) {
              return const LoginView();
            } else if (appState is InitWeatherState) {
              return SearchingView(
                widget: const SizedBox(),
              );
            } else if (appState is LoadingWeatherState) {
              return SearchingView(
                widget: const CircularProgressIndicator(),
              );
            } else if (appState is LoadedWeatherState) {
              return WeatherView();
            } else if (appState is ErrorWeatherState) {
              return SearchingView(
                widget: Text(
                  appState.errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: const TextStyle(color: Colors.redAccent),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
