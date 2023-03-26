part of 'home_store_cubit.dart';

abstract class HomeStoreState extends Equatable {
  const HomeStoreState();
}

class HomeStoreInitialState extends HomeStoreState {
  @override
  List<Object> get props => [];
}

class HomeStoreLoadedState extends HomeStoreState {
  const HomeStoreLoadedState({
    required this.homeStoreData,
    required this.cartData,
    required this.isFilterOpen,
    required this.selectedCategory,
  });

  final HomeStoreData homeStoreData;
  final Cart cartData;
  final bool isFilterOpen;
  final int selectedCategory;

  @override
  List<Object> get props => [
        homeStoreData,
        cartData,
        isFilterOpen,
        selectedCategory,
      ];

  HomeStoreLoadedState copyWith({
    HomeStoreData? homeStoreData,
    Cart? cartData,
    bool? isFilterOpen,
    int? selectedCategory,
  }) {
    return HomeStoreLoadedState(
      homeStoreData: homeStoreData ?? this.homeStoreData,
      cartData: cartData ?? this.cartData,
      isFilterOpen: isFilterOpen ?? this.isFilterOpen,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class HomeStoreErrorState extends HomeStoreState {
  const HomeStoreErrorState({
    this.error,
  });

  final Object? error;

  @override
  List<Object?> get props => [error];
}
