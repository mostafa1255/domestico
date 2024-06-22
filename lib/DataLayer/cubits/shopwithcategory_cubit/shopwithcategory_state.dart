part of 'shopwithcategory_cubit.dart';

@immutable
sealed class ShopwithcategoryState {}

final class ShopwithcategoryInitial extends ShopwithcategoryState {}

final class ShopwithcategoryLoading extends ShopwithcategoryState {}

final class ShopwithcategorySuccess extends ShopwithcategoryState {
  final List<ProductModel> products;
  ShopwithcategorySuccess({required this.products});
}

final class ShopwithcategoryFailure extends ShopwithcategoryState {
  final String errMessage;
  ShopwithcategoryFailure({required this.errMessage});
}