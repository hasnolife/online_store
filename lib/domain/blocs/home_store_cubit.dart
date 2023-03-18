import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/best_seller_entity.dart';
import 'package:online_store/domain/entity/cart.dart';
import 'package:online_store/domain/entity/home_store_data.dart';
import 'package:online_store/ui/widgets/elements/methods.dart';
import 'package:online_store/ui/widgets/navigation/main_navigation.dart';

class ProductToggleFavoriteEvent {
  final bool isFavorite;

  ProductToggleFavoriteEvent(this.isFavorite);
}

class HomeStoreState {
  final HomeStoreData? homeStoreData;
  final Cart? cartData;
  final bool isFilterOpen;
  final int selectedCategory;

  HomeStoreState copyWith({
    HomeStoreData? homeStoreData,
    Cart? cartData,
    bool? isFilterOpen,
    int? selectedCategory,
  }) {
    return HomeStoreState(
      homeStoreData: homeStoreData ?? this.homeStoreData,
      cartData: cartData ?? this.cartData,
      isFilterOpen: isFilterOpen ?? this.isFilterOpen,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeStoreState &&
          runtimeType == other.runtimeType &&
          homeStoreData == other.homeStoreData &&
          cartData == other.cartData &&
          isFilterOpen == other.isFilterOpen &&
          selectedCategory == other.selectedCategory;

  @override
  int get hashCode =>
      homeStoreData.hashCode ^
      cartData.hashCode ^
      isFilterOpen.hashCode ^
      selectedCategory.hashCode;

  HomeStoreState.initial()
      : homeStoreData = null,
        cartData = null,
        isFilterOpen = false,
        selectedCategory = 0;

  HomeStoreState({
    this.homeStoreData,
    this.cartData,
    required this.isFilterOpen,
    required this.selectedCategory,
  });
}

class HomeStoreCubit extends Cubit<HomeStoreState> {
  final myMethods = MyMethods();
  final _apiClient = ApiClient();

  set selectedCategory(int value) {
    final newState = state.copyWith(selectedCategory: value);
    emit(newState);
    // selectedCategory = value;
  }

  int get productCount => state.cartData?.basket.length ?? 0;

  HomeStoreCubit() : super(HomeStoreState.initial()) {
    _setup();
  }


  void toggleFavorite(int index) {
    var product = state.homeStoreData!.bestSeller[index];
    var bestSeller =
        List<BestSellerEntity>.from(state.homeStoreData!.bestSeller);
    bestSeller[index] =
        bestSeller[index].copyWith(isFavorites: !product.isFavorites);

    final newState = state.copyWith(
        homeStoreData: state.homeStoreData!.copyWith(bestSeller: bestSeller));

    emit(newState);
  }

  // void _checkProductImage(bestSellers) {
  //   for (var product in bestSellers) {
  //     _apiClient.tryToLoadImage(product.picture).then((verifiedUrl) {
  //       if (product.picture == verifiedUrl) return;
  //       product.picture = verifiedUrl;
  //       notifyListeners();
  //     });
  //   }
  // }

  void _setup() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    final homeStoreData = await _apiClient.getHomeStoreData();
    final cartData = await _apiClient.getCartData();
    final newState =
        state.copyWith(homeStoreData: homeStoreData, cartData: cartData);
    emit(newState);
  }

  void closeFilterDialog(context) {
    final isFilterOpen = state.isFilterOpen;
    if (isFilterOpen == true) {
      Navigator.of(context).pop();
      final newState = state.copyWith(isFilterOpen: false);
      emit(newState);
    }
  }

  void openFilterDialog(PersistentBottomSheetController<dynamic> sheet) {
    final isFilterOpen = state.isFilterOpen;
    if (isFilterOpen == true) return;
    sheet;
    final newState = state.copyWith(isFilterOpen: true);
    emit(newState);
  }

  void showDetails(context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.details);
  }
}
