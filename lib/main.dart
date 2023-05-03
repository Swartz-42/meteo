import 'package:flutter/material.dart';
import 'package:meteo/presentation/routing/app_router.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.asNewInstance();

void main() {
  getIt.registerSingleton<AppRouter>(AppRouter());
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();
    return MaterialApp.router(
      title: "Meteo",
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
    );
  }
}
