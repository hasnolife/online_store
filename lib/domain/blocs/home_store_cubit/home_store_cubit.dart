import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/best_seller_entity.dart';
import 'package:online_store/domain/entity/cart.dart';
import 'package:online_store/domain/entity/home_store_data.dart';
import 'package:online_store/ui/widgets/elements/methods.dart';
import 'package:online_store/ui/widgets/navigation/main_navigation.dart';

part 'home_store_state.dart';

class HomeStoreCubit extends Cubit<HomeStoreState> {
  HomeStoreCubit() : super(HomeStoreInitialState()) {
    _setup();
    _initial();
  }

  final _apiClient = ApiClient();
  final myMethods = MyMethods();

  get loadedState => state as HomeStoreLoadedState;

  int get productCount => loadedState.cartData.basket.length ?? 0;


  void toggleFavorite(int index) {
    final product = loadedState.homeStoreData.bestSeller[index];
    final bestSeller =
        List<BestSellerEntity>.from(loadedState.homeStoreData.bestSeller);
    bestSeller[index] = product.copyWith(isFavorites: !product.isFavorites);
    emit(loadedState.copyWith(
        homeStoreData:
            loadedState.homeStoreData.copyWith(bestSeller: bestSeller)));
  }

  void setSelectedCategory(int value) {
    emit(loadedState.copyWith(selectedCategory: value));
  }

  void _setup() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> _initial() async {
    try {
      final homeStoreData = await _apiClient.getHomeStoreData();
      final cartData = await _apiClient.getCartData();
      final newState = HomeStoreLoadedState(
        homeStoreData: homeStoreData,
        cartData: cartData,
        isFilterOpen: false,
        selectedCategory: 0,
      );
      emit(newState);
    } catch (e) {
      emit(HomeStoreErrorState(error: e));
    }
  }

  void closeFilterDialog(BuildContext context) {
    if (loadedState.isFilterOpen) {
      Navigator.of(context).pop();
      emit(loadedState.copyWith(isFilterOpen: false));
    }
  }

  void openFilterDialog(PersistentBottomSheetController<dynamic> sheet) {
    if (loadedState.isFilterOpen) return;
    sheet;
    emit(loadedState.copyWith(isFilterOpen: true));
  }

  void showDetails(context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.details);
  }
}
