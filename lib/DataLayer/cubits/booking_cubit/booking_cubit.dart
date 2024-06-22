import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:domestico/DataLayer/models/user_model.dart';
import 'package:domestico/constants/helper.dart';
import 'package:meta/meta.dart';
part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());
  final Dio _dio = Dio();

  Future<void> getAllSittersByCity({required String city}) async {
    emit(BookingLoading());
    List<UserModel> sitters = [];
    try {
      Response response = await _dio.post(
          "${MyUrl.baseUrl}user/getSitterByCountry",
          data: {"city": city});
      print("response${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        for (var element in response.data) {
          sitters.add(UserModel.fromJson(element));
          print(UserModel.fromJson(element).city);
        }
        emit(BookingSuccess(sitters: sitters.isEmpty ? [] : sitters));
      } else {
        //    print("response +${response.statusCode}");
        print("Failed to get Users");
        emit(BookingFailure(errMessage: 'Failed to get Users'));
      }
    } catch (e) {
      print("in catch");
      print("**" * 10);
      // send the err message to the faliure state
      emit(BookingFailure(errMessage: e.toString()));
    }
  }
}
