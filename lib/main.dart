import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/blocs/bloc.dart';
import 'package:weather_app/repositories/repositories.dart';
import 'package:weather_app/widgets/widgets.dart';

import 'package:http/http.dart' as http;

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final WeatherRepository repository = WeatherRepository(
      weatherApiClient: WeatherApiClient(client: http.Client()));

  runApp(BlocProvider<ThemeBloc>(
    builder: (context) => ThemeBloc(),
    child: MyApp(repository: repository),
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepository repository;

  MyApp({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<ThemeBloc>(context),
        builder: (_, ThemeState themeState) {
          return MaterialApp(
            title: 'Flutter Weather',
            home: BlocProvider(
              builder: (context) => WeatherBloc(repository: repository),
              child: Weather(),
            ),
          );
        });
  }
}
