import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';
import 'package:booknow_mobile/features/bookings/cubit/booking_detail_cubit.dart';
import 'package:booknow_mobile/features/bookings/widgets/booking_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// One booking in full.
///
/// [initial] is the copy the list or the home card already had, so the screen
/// draws at once and the read behind it only corrects what moved.
@RoutePage()
class BookingDetailPage extends StatelessWidget {
  const BookingDetailPage({
    super.key,
    @PathParam('bookingId') required this.bookingId,
    this.initial,
  });

  final String bookingId;
  final Booking? initial;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          BookingDetailCubit(di<BookingRepository>(), initial: initial)
            ..load(bookingId),
      child: const BookingDetailView(),
    );
  }
}
