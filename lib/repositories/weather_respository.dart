import 'dart:async';

import 'package:meta/meta.dart';

import 'package:weather_app/repositories/weather_api_client.dart';
import 'package:weather_app/models/models.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocalId(city);

    return await weatherApiClient.fetchWeather(locationId);
  }
}