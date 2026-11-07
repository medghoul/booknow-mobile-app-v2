import 'package:auto_route/auto_route.dart';
import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/features/home/cubit/customer_home_cubit.dart';
import 'package:booknow_mobile/features/home/widgets/customer_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The customer's home tab: the next booking, today's free times and the
/// shops nearby.
@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<CustomerHomeCubit>()..load(),
      child: const CustomerHomeView(),
    );
  }
}
