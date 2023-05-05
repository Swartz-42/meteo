import 'package:flutter/material.dart';
import 'package:meteo/application/config/globalvariables.dart';
import 'package:meteo/presentation/routing/app_router.dart';
import 'package:provider/provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GlobalVariables(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      title: "Meteo",
      theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
    );
  }
}
