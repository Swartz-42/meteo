import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:meteo/database/weather_data.dart';

class WeatherUtil {
  Map<String, String> weatherCodeMap = {
    "0": "Ciel dégagé",
    "1": "Principalement dégagé",
    "2": "Partiellement nuageux",
    "3": "Couvert",
    "45": "Brouillard",
    "48": "Brouillard givrant",
    "51": "Légère averse de pluie",
    "53": "Averse de pluie modérée",
    "55": "Averse de pluie forte",
    "56": "Légère averse de pluie verglaçante",
    "57": "Averse de pluie verglaçante dense",
    "61": "Légère pluie",
    "63": "Pluie modérée",
    "65": "Pluie forte",
    "66": "Légère pluie verglaçante",
    "67": "Pluie verglaçante dense",
    "71": "Légère chute de neige",
    "73": "Chute de neige modérée",
    "75": "Chute de neige forte",
    "77": "Grains de neige",
    "80": "Légère averse de pluie",
    "81": "Averse de pluie modérée",
    "82": "Averse de pluie forte",
    "85": "Légère chute de neige",
    "86": "Chute de neige forte",
    "95": "Orage",
    "96": "Orage avec légère grêle",
    "97": "Orage avec grêle forte"
  };

  Future<WeatherHourlyData> getWeatherDataByCurrentLocation() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      final position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
      );
      return await getWeatherByLatLon(position.latitude, position.longitude);
    } else {
      throw Exception('Location permission not granted');
    }
  }

  Future<WeatherHourlyData> getWeatherDataByTown(String town) async {
    final weatherData = await getWeatherByTown(town);
    return weatherData;
  }

  Future<WeatherHourlyData> getWeatherByLatLon(double? lat, double? lon) async {
    WeatherHourlyData weatherData;

    http.Response response = await http.get(
      Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&hourly=temperature_2m,relativehumidity_2m&current_weather=true&timezone=auto',
      ),
    );
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      weatherData = WeatherHourlyData(
        currentTemp: result["current_weather"]["temperature"].toString(),
        weatherCode: result["current_weather"]["weathercode"].toString(),
        windSpeed: result["current_weather"]["windspeed"].toString(),
        windDegrees: result["current_weather"]["winddirection"].toString(),
        isDay: result["current_weather"]["is_day"] == 1 ? true : false,
        time: (result["hourly"]["time"] as List<dynamic>).cast<String>(),
        humidity: (result["hourly"]["relativehumidity_2m"] as List<dynamic>)
            .cast<String>(),
        temperature: (result["hourly"]["temperature_2m"] as List<dynamic>)
            .cast<String>(),
      );
      return weatherData;
    }
    throw Exception("Failed to communicate with weather api : ");
  }

  Future<WeatherHourlyData> getWeatherByTown(String search) async {
    search = search.replaceAll(" ", "+");
    http.Response response = await http.get(
      Uri.parse(
        "https://geocoding-api.open-meteo.com/v1/search?name=$search&count=1&language=fr&format=json",
      ),
    );
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      double latitude = json["results"][0]["latitude"];
      double longitude = json["results"][0]["longitude"];
      return getWeatherByLatLon(latitude, longitude);
    }
    throw Exception("Failed to communicate with weather api : ");
  }

  Future<List<WeatherDailyData>> getWeekWeather(
      double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&daily=weathercode,temperature_2m_max,temperature_2m_min,precipitation_probability_max&timezone=auto',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load weather data');
    }

    final daily = jsonDecode(response.body)['daily'];
    List<dynamic> time = daily['time'] as List<dynamic>;
    List<dynamic> weatherCodes = daily['weathercode'] as List<dynamic>;
    List<dynamic> maxTemps = daily['temperature_2m_max'] as List<dynamic>;
    List<dynamic> minTemps = daily['temperature_2m_min'] as List<dynamic>;
    List<dynamic> precipitations =
        daily['precipitation_probability_max'] as List<dynamic>;

    final weatherForecast = <WeatherDailyData>[];
    for (var i = 0; i < time.length; i++) {
      final weatherData = WeatherDailyData(
        date: time[i] as String,
        weatherCode: weatherCodeMap[weatherCodes[i].toString()]!,
        maxTemp: maxTemps[i] as double,
        minTemp: minTemps[i] as double,
        precipitation: precipitations[i] as int,
      );
      weatherForecast.add(weatherData);
    }
    return weatherForecast;
  }
}
