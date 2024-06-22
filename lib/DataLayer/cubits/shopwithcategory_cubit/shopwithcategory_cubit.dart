import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:domestico/DataLayer/models/product_model.dart';
import 'package:domestico/constants/helper.dart';
import 'package:meta/meta.dart';

part 'shopwithcategory_state.dart';

class ShopwithcategoryCubit extends Cubit<ShopwithcategoryState> {
  ShopwithcategoryCubit() : super(ShopwithcategoryInitial());

  final Dio _dio = Dio();

  Future<void> getShopwithcategory({required String category}) async {
    emit(ShopwithcategoryLoading());
    try {
      List<ProductModel> products = [];
      Response response = await _dio.post(
          "${MyUrl.baseUrl}products/getProductByCategory",
          data: {"Category": category});
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> responseData = response.data;
        for (var element in responseData) {
          products.add(ProductModel.fromJson(element));
        }
        emit(ShopwithcategorySuccess(products: products));
      } else {
        emit(ShopwithcategoryFailure(errMessage: "Failed to load data"));
      }

      emit(ShopwithcategorySuccess(products: products));
    } catch (e) {
      emit(ShopwithcategoryFailure(errMessage: e.toString()));
    }
  }
}
