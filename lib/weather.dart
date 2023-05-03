import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meteo/data/ressources/database/weather_data.dart';

Future<WeatherData> getWeatherByLatLon(double? lat, double? lon) async {
  WeatherData weatherData;

  http.Response response = await http.get(
    Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&hourly=temperature_2m,relativehumidity_2m&current_weather=true&timezone=auto',
    ),
  );
  var result = jsonDecode(response.body);
  if (result["error"] == null) {
    weatherData = WeatherData(
      currentTemp: result["current_weather"]["temperature"].toString(),
      weatherCode: result["current_weather"]["weathercode"].toString(),
      windSpeed: result["current_weather"]["windspeed"].toString(),
      windDegrees: result["current_weather"]["winddirection"].toString(),
      isDay: result["current_weather"]["is_day"] == 1 ? true : false,
      time: (result["hourly"]["time"] as List<dynamic>).cast<String>(),
      humidity: (result["hourly"]["relativehumidity_2m"] as List<dynamic>)
          .cast<String>(),
      temperature:
          (result["hourly"]["temperature_2m"] as List<dynamic>).cast<String>(),
    );
    return weatherData;
  }
  throw "error : weather api may be down or you are not connected to the internet";
}

Future<WeatherData> getWeatherByTown(String search) async {
  search = search.replaceAll(" ", "+");
  http.Response result = await http.get(
    Uri.parse(
      "https://geocoding-api.open-meteo.com/v1/search?name=$search&count=1&language=fr&format=json",
    ),
  );
  var json = jsonDecode(result.body);
  if (json["results"] != null) {
    double latitude = json["results"][0]["latitude"];
    double longitude = json["results"][0]["longitude"];
    return getWeatherByLatLon(latitude, longitude);
  }
  throw "error : can't get weather api may be down or you are not connected to the internet";
}

String weatherCodeDecode(String weatherCode) {
  switch (weatherCode) {
    case "0":
      return "Clear sky";
    case "1":
      return "Mainly clear";
    case "2":
      return "Partly cloudy";
    case "3":
      return "Overcast";
    case "45":
      return "Fog";
    case "48":
      return "Freezing fog";
    case "51":
      return "Light rain shower";
    case "53":
      return "Moderate rain shower";
    case "55":
      return "Heavy rain shower";
    case "56":
      return "Light freezing rain shower";
    case "57":
      return "Dense freezing rain shower";
    case "61":
      return "Light rain";
    case "63":
      return "Moderate rain";
    case "65":
      return "Heavy rain";
    case "66":
      return "Light freezing rain";
    case "67":
      return "Dense freezing rain";
    case "71":
      return "Light snow fall";
    case "73":
      return "Moderate snow fall";
    case "75":
      return "Heavy snow fall";
    case "77":
      return "Snow grains";
    case "80":
      return "Light rain shower";
    case "81":
      return "Moderate rain shower";
    case "82":
      return "Heavy rain shower";
    case "85":
      return "slight Snow shower";
    case "86":
      return "Heavy snow shower";
    case "95":
      return "Thunderstorm";
    case "96":
      return "Thunderstorm with slight hail";
    case "97":
      return "Thunderstorm with heavy hail";
    default:
      return "An error as occured";
  }
}
