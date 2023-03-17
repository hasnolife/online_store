import 'package:bloc/bloc.dart';
import 'package:online_store/domain/api_client/api_client.dart';
import 'package:online_store/domain/entity/product_details.dart';

class ProductDetailsState {
  final ProductDetails? productDetails;
  final String selectedCategory;
  final int selectedColorIndex;
  final int selectedCapacityIndex;

  ProductDetailsState.initial()
      : productDetails = null,
        selectedCategory = 'Shop',
        selectedColorIndex = 0,
        selectedCapacityIndex = 0;

//<editor-fold desc="Data Methods">
  const ProductDetailsState({
    this.productDetails,
    required this.selectedCategory,
    required this.selectedColorIndex,
    required this.selectedCapacityIndex,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductDetailsState &&
          runtimeType == other.runtimeType &&
          productDetails == other.productDetails &&
          selectedCategory == other.selectedCategory &&
          selectedColorIndex == other.selectedColorIndex &&
          selectedCapacityIndex == other.selectedCapacityIndex);

  @override
  int get hashCode =>
      productDetails.hashCode ^
      selectedCategory.hashCode ^
      selectedColorIndex.hashCode ^
      selectedCapacityIndex.hashCode;

  @override
  String toString() {
    return '''ProductDetailsState{ 
    productDetails: $productDetails, 
    selectedCategory: $selectedCategory, 
    selectedColorIndex: $selectedColorIndex, 
    selectedCapacityIndex: $selectedCapacityIndex }''';
  }

  ProductDetailsState copyWith({
    ProductDetails? productDetails,
    String? selectedCategory,
    int? selectedColorIndex,
    int? selectedCapacityIndex,
  }) {
    return ProductDetailsState(
      productDetails: productDetails ?? this.productDetails,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
      selectedCapacityIndex:
          selectedCapacityIndex ?? this.selectedCapacityIndex,
    );
  }

//</editor-fold>
}

class ProductDetailsScreenCubit extends Cubit<ProductDetailsState> {
  final _apiClient = ApiClient();

  ProductDetailsScreenCubit() : super(ProductDetailsState.initial()) {
       _setup();
  }

  int convertColor(String stringColor) {
    return int.parse(stringColor.replaceFirst('#', '0xFF'));
  }

  void favoriteToggle() {
    var productDetails = state.productDetails!;

    productDetails =
        productDetails.copyWith(isFavorites: !productDetails.isFavorites);
    final newState = state.copyWith(productDetails: productDetails);
    emit(newState);
  }

  void changeSelectedCategory(String categoryName) {
    final selectedCategory = state.selectedCategory;
    if (selectedCategory == categoryName) return;
    final newState = state.copyWith(selectedCategory: categoryName);
    emit(newState);
  }

  void changeColor(String color) {
    final selectedColorIndex = state.selectedColorIndex;
    if (state.productDetails!.color[selectedColorIndex] == color) return;
    final newColorIndex = state.productDetails!.color.indexOf(color);
    final newState = state.copyWith(selectedColorIndex: newColorIndex);
    emit(newState);
  }

  void changeCapacity(String capacity) {
    final selectedCapacityIndex = state.selectedColorIndex;
    if (state.productDetails!.color[selectedCapacityIndex] == capacity) return;
    final newCapacityIndex = state.productDetails!.capacity.indexOf(capacity);
    final newState = state.copyWith(selectedCapacityIndex: newCapacityIndex);
    emit(newState);
  }

  Future<void> _setup() async {
    final productDetails = await _apiClient.getProductDetailsData();
    final newState = state.copyWith(productDetails: productDetails);
    emit(newState);
  }
}
