import 'package:auto_route/auto_route.dart';
import 'package:meteo/presentation/ui/views/homepage.dart';
import 'package:meteo/presentation/ui/views/testscreen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page, Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        //routes here
        AutoRoute(page: Home.page, initial: true),
        AutoRoute(page: Test.page),
      ];
}
