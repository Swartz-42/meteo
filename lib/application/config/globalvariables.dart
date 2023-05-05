import 'package:flutter/material.dart';
import 'package:meteo/database/weather_data.dart';

class GlobalVariables extends ChangeNotifier {
  String town = "";
  double latitude = 0;
  double longitude = 0;
  WeatherHourlyData weather = const WeatherHourlyData(
    currentTemp: "-",
    humidity: [],
    isDay: true,
    temperature: [],
    time: [],
    weatherCode: "-",
    windDegrees: "0",
    windSpeed: "-",
  );

  WeatherDailyData weatherDaily = const WeatherDailyData(
    date: "-",
    maxTemp: 0,
    minTemp: 0,
    precipitation: 0,
    weatherCode: "-",
  );

  void setTown(String newTown) {
    town = newTown;
    notifyListeners();
  }

  void setWeather(WeatherHourlyData newWeather) {
    weather = newWeather;
    notifyListeners();
  }

  void setLongitude(double lon) {
    longitude = lon;
    notifyListeners();
  }

  void setLatitude(double lat) {
    latitude = lat;
    notifyListeners();
  }
}
