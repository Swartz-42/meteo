import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:meteo/database/weather_data.dart';
import 'package:meteo/application/config/weather.dart';

@RoutePage(name: 'test')
class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool isLoading = false;
  DateTime now =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime pickedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  List<double> selectedPlace = [0, 0];
  final TextEditingController _searchController = TextEditingController();
  String? _selectedDay;
  WeatherDailyData? _selectedWeatherData;
  List<WeatherDailyData> _weekWeatherData = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: MapBoxAutoCompleteWidget(
                apiKey:
                    "pk.eyJ1Ijoic3dhcnR6LTQyIiwiYSI6ImNsaDlneTcwazA3azQzZW5zMzVsM3VpN2cifQ.CzqCLOSDnOyFy0M_pt97gQ",
                hint: "Chercher un lieu",
                language: "fr",
                country: "fr",
                closeOnSelect: false,
                onSelect: (place) {
                  setState(() {
                    selectedPlace = place.geometry!.coordinates!;
                    _searchController.text = place.placeName!;
                  });
                },
                limit: 2,
              ),
            ),
            Text("Lieu sélectionné : ${_searchController.text}"),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedDay,
              decoration: const InputDecoration(
                labelText: 'Date',
              ),
              items: [
                for (int i = 0; i < 7; i++)
                  DropdownMenuItem(
                    value: "${now.add(Duration(days: i))}",
                    child: Text(
                      now.add(Duration(days: i)).toString().substring(0, 10),
                    ),
                    onTap: () {
                      pickedDate = now.add(Duration(days: i));
                    },
                  ),
              ],
              onChanged: (String? value) {
                setState(() {
                  _selectedDay = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            if (_selectedWeatherData == null)
              const Center(
                child: Text("Entrée un lieu et une date"),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedWeatherData!.weatherCode,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'Température max:\n${_selectedWeatherData!.maxTemp}°C\nTempérature min:\n${_selectedWeatherData!.minTemp}°C',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'Precipitation: ${_selectedWeatherData!.precipitation}%',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                setState(() => isLoading = true);
                _weekWeatherData = await WeatherUtil().getWeekWeather(
                  selectedPlace[0],
                  selectedPlace[1],
                );
                setState(() {
                  _selectedWeatherData = _weekWeatherData.firstWhere(
                    (element) =>
                        element.date.toString() ==
                        pickedDate.toString().substring(0, 10),
                  );
                  isLoading = false;
                });
              },
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.amber,
                    )
                  : const Text('Get Weather'),
            ),
          ],
        ),
      ),
    );
  }
}
