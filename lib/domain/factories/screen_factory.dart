import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:online_store/domain/api_client/cart_api_client.dart';
import 'package:online_store/domain/api_client/details_screen_api_client.dart';
import 'package:online_store/domain/api_client/home_store_api_client.dart';
import 'package:online_store/domain/blocs/cart_bloc/cart_bloc.dart';
import 'package:online_store/domain/blocs/details_screen_cubit/details_screen_cubit.dart';
import 'package:online_store/domain/blocs/home_store_cubit/home_store_cubit.dart';
import 'package:online_store/ui/widgets/cart/cart_widget.dart';
import 'package:online_store/ui/widgets/details_screen/details_screen_widget.dart';
import 'package:online_store/ui/widgets/elements/methods.dart';
import 'package:online_store/ui/widgets/home_store/home_store_widget.dart';

class ScreenFactory {
  final _cartApiClient = GetIt.I<CartApiClient>();
  final _homeStoreApiClient = GetIt.I<HomeStoreApiClient>();
  final _detailsScreenApiClient = GetIt.I<DetailsScreenApiClient>();
  final _myMethods = GetIt.I<MyMethods>();

  Widget makeMainScreen() {
    return BlocProvider<HomeStoreCubit>(
      create: (_) => HomeStoreCubit(
        _homeStoreApiClient,
        _cartApiClient,
        myMethods: _myMethods,
      ),
      child: const HomeStoreWidget(),
    );
  }

  Widget makeDetailsScreen() {
    return BlocProvider<DetailsScreenCubit>(
      create: (_) => DetailsScreenCubit(_detailsScreenApiClient),
      child: const ProductDetailsScreenWidget(),
    );
  }

  Widget makeCartScreen() {
    return BlocProvider<CartBloc>(
      create: (_) => CartBloc(_cartApiClient),
      child: const CartWidget(),
    );
  }
}
