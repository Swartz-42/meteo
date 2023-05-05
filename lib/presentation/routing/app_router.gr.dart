// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    Base.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BaseScreen(),
      );
    },
    Home.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    Test.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TestScreen(),
      );
    },
  };
}

/// generated route for
/// [BaseScreen]
class Base extends PageRouteInfo<void> {
  const Base({List<PageRouteInfo>? children})
      : super(
          Base.name,
          initialChildren: children,
        );

  static const String name = 'Base';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class Home extends PageRouteInfo<void> {
  const Home({List<PageRouteInfo>? children})
      : super(
          Home.name,
          initialChildren: children,
        );

  static const String name = 'Home';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TestScreen]
class Test extends PageRouteInfo<void> {
  const Test({List<PageRouteInfo>? children})
      : super(
          Test.name,
          initialChildren: children,
        );

  static const String name = 'Test';

  static const PageInfo<void> page = PageInfo<void>(name);
}
