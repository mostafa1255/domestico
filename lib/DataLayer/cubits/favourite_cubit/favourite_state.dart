part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class FavouriteItemLoading extends FavouriteState {}

final class FavouriteItemSuccess extends FavouriteState {
  final List<ProductModel> fav;
  FavouriteItemSuccess({required this.fav});
}

final class FavouriteItemFailure extends FavouriteState {
  final String message;
  FavouriteItemFailure({required this.message});
}

  
final class FavouriteSitterLoading extends FavouriteState {}

final class FavouriteSitterSuccess extends FavouriteState {
  final List<AnimalsModel> fav;
  FavouriteSitterSuccess({required this.fav});
}

final class FavouriteSitterFailure extends FavouriteState {
  final String message;
  FavouriteSitterFailure({required this.message});
}