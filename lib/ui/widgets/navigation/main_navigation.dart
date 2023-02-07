 import 'package:online_store/domain/factories/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const mainScreen = '/';
  static const details = '/details';
  static const cart = '/cart';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();
  final routes = {
    MainNavigationRouteNames.mainScreen : (_) => _screenFactory.makeMainScreen(),
    MainNavigationRouteNames.details : (_) => _screenFactory.makeDetailsScreen(),
    MainNavigationRouteNames.cart : (_) => _screenFactory.makeCartScreen(),
  };
}