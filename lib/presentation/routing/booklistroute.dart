import 'package:auto_route/auto_route.dart';

class BookListRoute extends PageRouteInfo {
  const BookListRoute({List<PageRouteInfo>? children})
      : super(name, initialChildren: children);

  static const String name = 'BookListRoute';
  static const PageInfo<void> page = PageInfo<void>(name);
}
