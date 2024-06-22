part of 'booking_cubit.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final List<UserModel> sitters;
  BookingSuccess({required this.sitters});
}

class BookingFailure extends BookingState {
  final String errMessage;
  BookingFailure({required this.errMessage});
}
