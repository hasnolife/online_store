import 'package:flutter/material.dart';
import 'package:online_store/ui/widgets/navigation/main_navigation.dart';


class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Mark Pro',
      ),
      routes: mainNavigation.routes,
      initialRoute: MainNavigationRouteNames.mainScreen,
    );
  }
}