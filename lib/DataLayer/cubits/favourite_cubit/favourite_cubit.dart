import 'package:bloc/bloc.dart';
import 'package:domestico/DataLayer/models/animals_model.dart';
import 'package:domestico/DataLayer/models/product_model.dart';
import 'package:meta/meta.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  Future<void> getFavouriteItems() async {
    emit(FavouriteItemLoading());
    List<ProductModel> homeData = [];
    try {
      // make the dio call here
      emit(FavouriteItemSuccess(fav: homeData));
    } catch (e) {
      // send the err message to the faliure state
      emit(FavouriteItemFailure(message: e.toString()));
    }
  }

  Future<void> getFavouriteSitters() async {
    emit(FavouriteSitterLoading());
    List<AnimalsModel> favSitters = [];
    try {
      // make the dio call here
      emit(FavouriteSitterSuccess(fav: favSitters));
    } catch (e) {
      // send the err message to the faliure state
      emit(FavouriteSitterFailure(message: e.toString()));
    }
  }
}
