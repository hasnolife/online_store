import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/domain/blocs/cart_bloc.dart';

import 'package:online_store/ui/widgets/cart/cart_widget.dart';
import 'package:online_store/domain/blocs/details_screen_cubit.dart';
import 'package:online_store/ui/widgets/details_screen/details_screen_widget.dart';
import 'package:online_store/domain/blocs/home_store_cubit.dart';
import 'package:online_store/ui/widgets/home_store/home_store_widget.dart';

class ScreenFactory {
  Widget makeMainScreen() {
    return BlocProvider<HomeStoreCubit>(
      create: (_) => HomeStoreCubit(),
      child: const HomeStoreWidget(),
    );
  }

  Widget makeDetailsScreen() {
    return BlocProvider<ProductDetailsScreenCubit>(
      create: (_) => ProductDetailsScreenCubit(),
      child: const ProductDetailsScreenWidget(),
    );
  }

  Widget makeCartScreen() {
    return BlocProvider<CartBloc>(
      create: (_) => CartBloc(),
      child: const CartWidget(),
    );
  }
}
