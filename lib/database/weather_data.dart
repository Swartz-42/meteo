class WeatherHourlyData {
  final String currentTemp;
  final String weatherCode;
  final String windSpeed;
  final String windDegrees;
  final bool isDay;
  final List<String> humidity;
  final List<String> time;
  final List<String> temperature;

  const WeatherHourlyData({
    required this.currentTemp,
    required this.weatherCode,
    required this.windSpeed,
    required this.windDegrees,
    required this.isDay,
    required this.humidity,
    required this.time,
    required this.temperature,
  });

  get windDirection => _degreesToDirection(windDegrees);

  String _degreesToDirection(String direction) {
    double deg = double.parse(direction);
    int angle = ((deg / 22.5) + 0.5).floor();
    List<String> directions = [
      'N',
      'NNE',
      'NE',
      'ENE',
      'E',
      'ESE',
      'SE',
      'SSE',
      'S',
      'SSW',
      'SW',
      'WSW',
      'W',
      'WNW',
      'NW',
      'NNW'
    ];
    return directions[angle % 16];
  }
}

class WeatherDailyData {
  final String date;
  final String weatherCode;
  final double maxTemp;
  final double minTemp;
  final int precipitation;

  const WeatherDailyData({
    required this.date,
    this.weatherCode = "-",
    required this.maxTemp,
    required this.minTemp,
    required this.precipitation,
  });
}
