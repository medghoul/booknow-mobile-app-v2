import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/auth/widgets/guest_views.dart';
import 'package:booknow_mobile/features/bookings/cubit/bookings_cubit.dart';
import 'package:booknow_mobile/features/bookings/widgets/bookings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The Activity tab: the customer's bookings, or an invitation to sign in.
@RoutePage()
class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: di<AuthCubit>(),
      buildWhen: (a, b) => (a.session == null) != (b.session == null),
      builder: (context, auth) {
        if (auth.session == null) return const GuestActivityView();

        return BlocProvider(
          create: (_) => di<BookingsCubit>()..loadAll(),
          child: const BookingsView(),
        );
      },
    );
  }
}
