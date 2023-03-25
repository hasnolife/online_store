import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/product_details.dart';

part 'details_screen_state.dart';

class DetailsScreenCubit extends Cubit<DetailsScreenState> {
  DetailsScreenCubit() : super(DetailsScreenInitialState()) {
    _initial();
  }

  final _apiClient = ApiClient();

  DetailsScreenLoadedState get loadedState => state as DetailsScreenLoadedState;

  int convertColor(String stringColor) {
    return int.parse(stringColor.replaceFirst('#', '0xFF'));
  }

  void favoriteToggle() {
    var productDetails = loadedState.productDetails;

    productDetails =
        productDetails.copyWith(isFavorites: !productDetails.isFavorites);
    final newState = loadedState.copyWith(productDetails: productDetails);
    emit(newState);
  }

  void changeSelectedCategory(String categoryName) {
    final selectedCategory = loadedState.selectedCategory;
    if (selectedCategory == categoryName) return;
    final newState = loadedState.copyWith(selectedCategory: categoryName);
    emit(newState);
  }

  void changeColor(String color) {
    final selectedColorIndex = loadedState.selectedColorIndex;
    if (loadedState.productDetails.color[selectedColorIndex] == color) return;
    final newColorIndex = loadedState.productDetails.color.indexOf(color);
    final newState = loadedState.copyWith(selectedColorIndex: newColorIndex);
    emit(newState);
  }

  void changeCapacity(String capacity) {
    state as DetailsScreenLoadedState;

    final selectedCapacityIndex = loadedState.selectedColorIndex;
    if (loadedState.productDetails.color[selectedCapacityIndex] == capacity) return;
    final newCapacityIndex = loadedState.productDetails.capacity.indexOf(capacity);
    final newState = loadedState.copyWith(selectedCapacityIndex: newCapacityIndex);
    emit(newState);
  }

  Future<void> _initial() async {
    try {
      final productDetails = await _apiClient.getProductDetailsData();

      emit(DetailsScreenLoadedState(
        productDetails: productDetails,
        selectedCategory: 'Shop',
        selectedColorIndex: 0,
        selectedCapacityIndex: 0,
      ));
    } catch (e) {
      emit(DetailsScreenErrorState(error: e));
    }
  }
}
