import 'package:booknow_mobile/core/di/dependency_injection.dart';
import 'package:booknow_mobile/core/services/payments/payment_service.dart';
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:booknow_mobile/domain/repositories/booking_repository.dart';
import 'package:booknow_mobile/domain/repositories/queue_repository.dart';
import 'package:booknow_mobile/domain/repositories/shop_directory_repository.dart';
import 'package:booknow_mobile/features/booking_flow/cubit/booking_flow_cubit.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/booking_flow_view.dart';
import 'package:booknow_mobile/features/booking_flow/widgets/shop_scaffold.dart';
import 'package:booknow_mobile/features/home/widgets/category_blob.dart';
import 'package:booknow_mobile/features/queue/cubit/queue_flow_cubit.dart';
import 'package:booknow_mobile/features/queue/widgets/queue_flow_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// One shop, opened on its times or on its line.
///
/// A shop taking both switches between them in place, so each keeps what the
/// customer already chose. The other one is only read once it is asked for.
class ShopFlow extends StatefulWidget {
  const ShopFlow({
    super.key,
    required this.shopId,
    required this.initial,
    this.serviceId,
    this.startUtc,
    this.initialDate,
    this.preview = false,
    this.category,
    this.distanceMeters,
  });

  final String shopId;

  /// [ShopMode.booking] or [ShopMode.queue]: what shows first.
  final ShopMode initial;
  final String? serviceId;
  final DateTime? startUtc;
  final String? initialDate;
  final bool preview;
  final ShopCategory? category;
  final int? distanceMeters;

  @override
  State<ShopFlow> createState() => _ShopFlowState();
}

class _ShopFlowState extends State<ShopFlow> {
  late ShopMode _showing = widget.initial;
  late final Set<ShopMode> _opened = {widget.initial};

  void _show(ShopMode way) {
    setState(() {
      _showing = way;
      _opened.add(way);
    });
  }

  /// Both carry the shop's photo hero, so only the one showing may fly it.
  Widget _way(ShopMode way, Widget Function() build) {
    if (!_opened.contains(way)) return const SizedBox.shrink();
    final showing = _showing == way;

    return TickerMode(
      enabled: showing,
      child: HeroMode(enabled: showing, child: build()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShopPreview(
      enabled: widget.preview,
      category: widget.category,
      distanceMeters: widget.distanceMeters,
      child: ShopWayScope(
        showing: _showing,
        onChanged: _show,
        child: IndexedStack(
          index: _showing == ShopMode.queue ? 1 : 0,
          sizing: StackFit.expand,
          children: [
            _way(
              ShopMode.booking,
              () => BlocProvider(
                create: (_) => BookingFlowCubit(
                  bookings: di<BookingRepository>(),
                  shops: di<ShopDirectoryRepository>(),
                  payments: di<PaymentService>(),
                  shopId: widget.shopId,
                  serviceId: widget.serviceId,
                  start: widget.startUtc,
                  initialDate: widget.initialDate,
                )..start(),
                child: const BookingFlowView(),
              ),
            ),
            _way(
              ShopMode.queue,
              () => BlocProvider(
                create: (_) => QueueFlowCubit(
                  queue: di<QueueRepository>(),
                  shops: di<ShopDirectoryRepository>(),
                  payments: di<PaymentService>(),
                  shopId: widget.shopId,
                )..start(),
                child: const QueueFlowView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
