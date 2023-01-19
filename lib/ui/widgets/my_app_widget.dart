import 'package:flutter/material.dart';
import 'package:online_store/ui/widgets/home_store/home_store_model.dart';
import 'package:online_store/ui/widgets/home_store/home_store_widget.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => HomeStoreModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Mark Pro',
          // primarySwatch: Colors.blue,
        ),
        // initialRoute: const HomeStoreWidget(),
        home:const HomeStoreWidget(),
      ),
    );
  }
}