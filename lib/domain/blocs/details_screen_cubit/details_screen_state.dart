part of 'details_screen_cubit.dart';

abstract class DetailsScreenState extends Equatable {
  const DetailsScreenState();
}

class DetailsScreenInitialState extends DetailsScreenState {
  @override
  List<Object> get props => [];
}

class DetailsScreenLoadingState extends DetailsScreenState {
  @override
  List<Object> get props => [];
}

class DetailsScreenLoadedState extends DetailsScreenState {
  const DetailsScreenLoadedState({
    required this.productDetails,
    required this.selectedCategory,
    required this.selectedColorIndex,
    required this.selectedCapacityIndex,
  });

  final ProductDetails productDetails;
  final String selectedCategory;
  final int selectedColorIndex;
  final int selectedCapacityIndex;

  DetailsScreenLoadedState copyWith({
    ProductDetails? productDetails,
    String? selectedCategory,
    int? selectedColorIndex,
    int? selectedCapacityIndex,
  }) {
    return DetailsScreenLoadedState(
      productDetails: productDetails ?? this.productDetails,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
      selectedCapacityIndex:
      selectedCapacityIndex ?? this.selectedCapacityIndex,
    );
  }

  @override
  List<Object> get props =>
      [
        productDetails,
        selectedCategory,
        selectedColorIndex,
        selectedCapacityIndex,
      ];
}

class DetailsScreenErrorState extends DetailsScreenState {
  const DetailsScreenErrorState({
    this.error,
  });

  final Object? error;

  @override
  List<Object?> get props => [error];
}
