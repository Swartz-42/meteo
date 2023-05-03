class WeatherData {
  final String currentTemp;
  final String weatherCode;
  final String windSpeed;
  final String windDegrees;
  final bool isDay;
  final List<String> humidity;
  final List<String> time;
  final List<String> temperature;

  const WeatherData({
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
    if (deg >= 0 && deg <= 11) {
      return "N";
    } else if (deg > 11 && deg <= 33) {
      return "NNE";
    } else if (deg > 33 && deg <= 56) {
      return "NE";
    } else if (deg > 56 && deg <= 78) {
      return "ENE";
    } else if (deg > 78 && deg <= 101) {
      return "E";
    } else if (deg > 101 && deg <= 123) {
      return "ESE";
    } else if (deg > 123 && deg <= 146) {
      return "SE";
    } else if (deg > 146 && deg <= 168) {
      return "SSE";
    } else if (deg > 168 && deg <= 191) {
      return "S";
    } else if (deg > 191 && deg <= 213) {
      return "SSW";
    } else if (deg > 213 && deg <= 236) {
      return "SW";
    } else if (deg > 236 && deg <= 258) {
      return "WSW";
    } else if (deg > 258 && deg <= 281) {
      return "W";
    } else if (deg > 281 && deg <= 303) {
      return "WNW";
    } else if (deg > 303 && deg <= 326) {
      return "NW";
    } else if (deg > 326 && deg <= 348) {
      return "NNW";
    } else if (deg > 348 && deg <= 360) {
      return "N";
    } else {
      return "N";
    }
  }
}
