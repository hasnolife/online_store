import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:online_store/domain/api_client/cart_api_client.dart';
import 'package:online_store/domain/api_client/details_screen_api_client.dart';
import 'package:online_store/domain/api_client/home_store_api_client.dart';
import 'package:online_store/ui/widgets/elements/methods.dart';
import 'package:online_store/ui/widgets/my_app_widget.dart';

void main() {
  GetIt.I.registerLazySingleton(() => HomeStoreApiClient());
  GetIt.I.registerLazySingleton(() => CartApiClient());
  GetIt.I.registerLazySingleton(() => DetailsScreenApiClient());
  GetIt.I.registerLazySingleton(() => MyMethods());


  runApp(const MyApp());

}


