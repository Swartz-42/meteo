import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:meteo/application/config/globalvariables.dart';
import 'package:provider/provider.dart';

@RoutePage(name: 'home')
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final GlobalVariables globalVariables = context.watch<GlobalVariables>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "latitude: ${globalVariables.latitude}, longitude: ${globalVariables.longitude}",
            ),
            Text(
              "Température: ${globalVariables.weather.currentTemp}°C",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              "Vent: ${globalVariables.weather.windSpeed}Km/h ${globalVariables.weather.windDirection}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              globalVariables.weather.isDay ? "Jour" : "Nuit",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
