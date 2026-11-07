import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_detail_cubit.freezed.dart';

@freezed
abstract class BookingDetailState with _$BookingDetailState {
  const factory BookingDetailState({
    Booking? booking,
    @Default(false) bool isLoading,
    @Default(false) bool isCancelling,
    NetworkException? failure,
  }) = _BookingDetailState;
}

/// One booking, and the two things that can be done to it.
///
/// It opens with the booking the list already had, so the screen draws
/// immediately and the read behind it only corrects what changed — a status
/// the webhook moved, or a refund that landed.
class BookingDetailCubit extends Cubit<BookingDetailState> {
  BookingDetailCubit(this._repository, {Booking? initial})
    : super(BookingDetailState(booking: initial, isLoading: initial == null));

  final BookingRepository _repository;

  Future<void> load(String bookingId) async {
    emit(state.copyWith(isLoading: state.booking == null, failure: null));

    final result = await _repository.byId(bookingId);
    if (isClosed) return;

    switch (result) {
      case Success<Booking>(:final data):
        emit(state.copyWith(booking: data, isLoading: false));
      case Failure<Booking>(:final error):
        // A failed refresh keeps the booking that is already on screen: the
        // list's copy is stale at worst, and an error page in its place tells
        // the customer less than the booking does.
        emit(
          state.copyWith(
            isLoading: false,
            failure: state.booking == null ? error : null,
          ),
        );
    }
  }

  /// Cancels, and keeps the cancelled booking so the screen can say whether
  /// the fee came back.
  Future<Booking?> cancel(String bookingId) async {
    emit(state.copyWith(isCancelling: true, failure: null));

    final result = await _repository.cancel(bookingId);
    if (isClosed) return null;

    switch (result) {
      case Success<Booking>(:final data):
        emit(state.copyWith(booking: data, isCancelling: false));
        return data;
      case Failure<Booking>(:final error):
        emit(state.copyWith(isCancelling: false, failure: error));
        return null;
    }
  }
}
