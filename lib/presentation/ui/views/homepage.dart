import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meteo/database/weather_data.dart';
import 'package:meteo/main.dart';
import 'package:meteo/presentation/routing/app_router.dart';
import 'package:meteo/weather.dart';

@RoutePage(name: 'home')
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _town = "";
  WeatherData weather = const WeatherData(
    currentTemp: "-",
    humidity: [],
    isDay: true,
    temperature: [],
    time: [],
    weatherCode: "0",
    windDegrees: "0",
    windSpeed: "-",
  );

  void _getTemp() async {
    LocationPermission perm = await Geolocator.requestPermission();
    if (perm == LocationPermission.whileInUse ||
        perm == LocationPermission.always) {
      Position pos = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
      );
      WeatherData t = await getWeatherByLatLon(pos.latitude, pos.longitude);
      _town = "";
      setState(() => weather = t);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vous devez autoriser la localisation"),
        ),
      );
    }
  }

  _getTempByTown(String town) async {
    WeatherData t = await getWeatherByTown(town);
    _town = town;
    setState(() => weather = t);
  }

  _search() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Recherche"),
        content: TextField(
          decoration: const InputDecoration(
            labelText: "Ville",
            hintText: "Entrez une ville",
          ),
          onChanged: (value) {
            _town = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              _getTempByTown(_town);
              Navigator.pop(context);
            },
            child: const Text("Rechercher"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            _town == "" ? const Text("Meteo actuel") : Text("Meteo à $_town"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Température: ${weather.currentTemp}°C",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              "Vent: ${weather.windSpeed}Km/h ${weather.windDirection}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              weather.isDay ? "Jour" : "Nuit",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  bottom: 20,
                ),
                child: FloatingActionButton(
                  onPressed: () => _search(),
                  tooltip: "Search by town",
                  child: const Icon(Icons.search),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: FloatingActionButton(
                  onPressed: () => _getTemp(),
                  tooltip: "Refresh temp",
                  child: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Recherche",
          ),
        ],
        currentIndex: 0,
        onTap: (int index) {
          switch (index) {
            case 0:
              break;
            case 1:
              getIt<AppRouter>()
                  .pushAndPopUntil(const Test(), predicate: (_) => false);
              break;
          }
        },
      ),
    );
  }
}
