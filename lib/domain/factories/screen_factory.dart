import 'package:flutter/material.dart';
import 'package:online_store/ui/widgets/cart/cart_model.dart';
import 'package:online_store/ui/widgets/cart/cart_widget.dart';
import 'package:online_store/ui/widgets/details_screen/details_screen_model.dart';
import 'package:online_store/ui/widgets/details_screen/details_screen_widget.dart';
import 'package:online_store/ui/widgets/home_store/home_store_model.dart';
import 'package:online_store/ui/widgets/home_store/home_store_widget.dart';
import 'package:provider/provider.dart';

class ScreenFactory {
  Widget makeMainScreen() {
    return ChangeNotifierProvider<HomeStoreModel>(
      create: (_) => HomeStoreModel(),
      child: const HomeStoreWidget(),
    );
  }

  Widget makeDetailsScreen() {
    return ChangeNotifierProvider<ProductDetailsScreenModel>(
      create: (_) => ProductDetailsScreenModel(),
      child: const ProductDetailsScreenWidget(),
    );
  }

  Widget makeCartScreen() {
    return ChangeNotifierProvider<CartModel>(
      create: (_) => CartModel(),
      child: const CartWidget(),
    );
  }
}
