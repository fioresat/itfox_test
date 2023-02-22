import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itfox_test/bloc/app_bloc.dart';
import 'package:itfox_test/screens/widgets/weather_card.dart';
import 'package:itfox_test/screens/widgets/weather_case.dart';

class WeatherView extends StatelessWidget {
  WeatherView({
    Key? key,
  }) : super(key: key);

  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<AppBloc>(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: weatherBloc.state.color,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          color: Colors.green[900],
          onPressed: () {
            context.read<AppBloc>().add(
              const AppEventGoToLogin(),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.place_outlined),
            color: Colors.green[900],
            onPressed: () {
              context.read<AppBloc>().add(
                const AppEventLocationWeather(),
              );
            },
          ),
        ],
      ),
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0, 1.0],
            colors: [weatherBloc.state.color, Colors.white],
          ),
        ),
        child: WeatherCase(
          cityController: _cityController,
          onSearch: (city) => weatherBloc.add(
            AppEventGetWeather(city: city),
          ),
          widget: WeatherCard(
            weatherData: weatherBloc.state.weatherData!,
            isConnected: weatherBloc.state.isConnected,
          ),
        ),
      ),
    );
  }
}
