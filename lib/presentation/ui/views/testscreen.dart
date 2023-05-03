import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:meteo/database/weather_data.dart';
import 'package:meteo/main.dart';
import 'package:meteo/presentation/routing/app_router.dart';
import 'package:meteo/weather.dart';

@RoutePage(name: 'test')
class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TextEditingController _controller = TextEditingController();
  WeatherData weather = const WeatherData(
    currentTemp: "-",
    humidity: [],
    isDay: true,
    temperature: [],
    time: [],
    weatherCode: '0',
    windDegrees: "0",
    windSpeed: '-',
  );
  String _town = "";

  _getTempByTown(String town) async {
    WeatherData t = await getWeatherByTown(town);
    setState(() {
      weather = t;
      _town = town;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meteo"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
        ],
        currentIndex: 1,
        onTap: (int index) {
          switch (index) {
            case 0:
              getIt<AppRouter>().pushAndPopUntil(
                const Home(),
                predicate: (_) => false,
              );
              break;
            case 1:
              break;
          }
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  labelText: 'Enter a town',
                ),
                onSubmitted: (value) => _getTempByTown(_controller.text),
              ),
            ),
            Text(
              'Weather at $_town position:',
            ),
            Text(
              'température: ${weather.currentTemp}°C',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Vent: ${weather.windSpeed}Km/h ${weather.windDirection}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              weather.isDay ? "Jour" : "Nuit",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
