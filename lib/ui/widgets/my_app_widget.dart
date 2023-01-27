import 'package:flutter/material.dart';
import 'package:online_store/ui/widgets/home_store/home_store_model.dart';
import 'package:online_store/ui/widgets/home_store/home_store_widget.dart';
import 'package:online_store/ui/widgets/navigation/main_navigation.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Mark Pro',
        // primarySwatch: Colors.blue,
      ),
      routes: mainNavigation.routes,
      initialRoute: MainNavigationRouteNames.mainScreen,
      // home:const HomeStoreWidget(),
    );
  }
}