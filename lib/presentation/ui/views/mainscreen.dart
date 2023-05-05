import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meteo/application/config/weather.dart';
import 'package:meteo/database/weather_data.dart';
import 'package:meteo/application/config/globalvariables.dart';
import 'package:meteo/presentation/routing/app_router.dart';
import 'package:provider/provider.dart';

@RoutePage(name: 'base')
class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  bool isLoading = false;

  void _onItemTapped(int index) {
    if (index == 0) {
      AutoRouter.of(context).navigate(
        const Home(),
      );
    }
    if (index == 1) {
      AutoRouter.of(context).navigate(
        const Test(),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Accueil",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: "Recherche",
    ),
  ];

  Future<void> search(GlobalVariables globalVariables) async {
    String rtown = "";
    final result = await showDialog<WeatherHourlyData>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Recherche"),
        content: TextField(
          decoration: const InputDecoration(
            labelText: "Ville",
            hintText: "Entrez une ville",
          ),
          onChanged: (value) => rtown = value,
          onSubmitted: (value) => setState(() => rtown = value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () async {
              final weatherData =
                  await WeatherUtil().getWeatherDataByTown(rtown);
              // ignore: use_build_context_synchronously
              Navigator.pop(context, weatherData);
            },
            child: const Text("Rechercher"),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() {
        globalVariables.setWeather(result);
        globalVariables.setTown(rtown);
      });
    }
  }

  Future<void> getCurrentLocation(GlobalVariables globalVariables) async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        globalVariables.setLatitude(position.latitude);
        globalVariables.setLongitude(position.longitude);
      });
    } catch (e) {
      throw Exception('Could not get location: $e');
    }
  }

  @override
  void initState() {
    getCurrentLocation(context.read<GlobalVariables>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalVariables globalVariables = context.watch<GlobalVariables>();

    return Scaffold(
      appBar: AppBar(
        title: globalVariables.town == ""
            ? const Text("Meteo actuel")
            : Text("Meteo à ${globalVariables.town}"),
      ),
      body: const AutoRouter(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_selectedIndex == 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    bottom: 20,
                  ),
                  child: FloatingActionButton(
                    onPressed: () {
                      search(globalVariables);
                    },
                    tooltip: "Search by town",
                    child: const Icon(Icons.search),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: FloatingActionButton(
                    onPressed: () async {
                      try {
                        setState(() => isLoading = true);
                        final weatherData = await WeatherUtil()
                            .getWeatherDataByCurrentLocation();
                        setState(() {
                          globalVariables.setTown("");
                          globalVariables.setWeather(weatherData);
                          isLoading = false;
                        });
                      } catch (e) {
                        isLoading = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                    tooltip: "Refresh temp",
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.amber,
                          )
                        : const Icon(Icons.refresh),
                  ),
                ),
              ],
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
