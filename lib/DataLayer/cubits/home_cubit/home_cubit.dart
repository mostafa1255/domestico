import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:domestico/DataLayer/models/product_model.dart';
import 'package:domestico/constants/helper.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final Dio _dio = Dio();

  Future<void> getHomeData() async {
    emit(HomeLoading());
    List<ProductModel> homeData = [];
    try {
      Response response = await _dio.get("${MyUrl.baseUrl}products");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> responseData = response.data;
        for (var element in responseData) {
          homeData.add(ProductModel.fromJson(element));
        }
        emit(HomeSuccess(homeModel: homeData));
      } else {
        emit(HomeFailure(errMessage: 'Failed to load data'));
      }
    } catch (e) {
      emit(HomeFailure(errMessage: e.toString()));
    }
  }
}
