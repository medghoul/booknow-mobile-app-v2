// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i32;
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart' as _i36;
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart'
    as _i37;
import 'package:booknow_mobile/domain/models/index.dart' as _i34;
import 'package:booknow_mobile/features/agenda/views/owner_agenda_page.dart'
    as _i12;
import 'package:booknow_mobile/features/agenda/views/owner_today_page.dart'
    as _i15;
import 'package:booknow_mobile/features/auth/views/profile_setup_page.dart'
    as _i18;
import 'package:booknow_mobile/features/auth/views/role_page.dart' as _i20;
import 'package:booknow_mobile/features/auth/views/sign_in_page.dart' as _i25;
import 'package:booknow_mobile/features/auth/views/sign_up_page.dart' as _i26;
import 'package:booknow_mobile/features/booking_flow/views/booking_flow_page.dart'
    as _i2;
import 'package:booknow_mobile/features/bookings/views/booking_detail_page.dart'
    as _i1;
import 'package:booknow_mobile/features/bookings/views/bookings_page.dart'
    as _i3;
import 'package:booknow_mobile/features/home/views/home_page.dart' as _i6;
import 'package:booknow_mobile/features/home/widgets/category_blob.dart'
    as _i35;
import 'package:booknow_mobile/features/notifications/views/notification_permission_page.dart'
    as _i9;
import 'package:booknow_mobile/features/notifications/views/notification_settings_page.dart'
    as _i10;
import 'package:booknow_mobile/features/onboarding/views/onboarding_page.dart'
    as _i11;
import 'package:booknow_mobile/features/profile/views/personal_data_page.dart'
    as _i16;
import 'package:booknow_mobile/features/profile/views/profile_page.dart'
    as _i17;
import 'package:booknow_mobile/features/queue/views/queue_flow_page.dart'
    as _i19;
import 'package:booknow_mobile/features/queue/views/shop_mode_page.dart'
    as _i23;
import 'package:booknow_mobile/features/shell/views/customer_shell_page.dart'
    as _i4;
import 'package:booknow_mobile/features/shell/views/owner_shell_page.dart'
    as _i13;
import 'package:booknow_mobile/features/shop_setup/views/hours_page.dart'
    as _i7;
import 'package:booknow_mobile/features/shop_setup/views/services_page.dart'
    as _i21;
import 'package:booknow_mobile/features/shop_setup/views/shop_details_page.dart'
    as _i22;
import 'package:booknow_mobile/features/shop_setup/views/shop_setup_page.dart'
    as _i24;
import 'package:booknow_mobile/features/shop_setup/views/team_page.dart'
    as _i31;
import 'package:booknow_mobile/features/splash/views/splash_page.dart' as _i27;
import 'package:booknow_mobile/features/statistics/cubit/owner_statistics_cubit.dart'
    as _i39;
import 'package:booknow_mobile/features/statistics/views/needs_review_page.dart'
    as _i8;
import 'package:booknow_mobile/features/statistics/views/owner_statistics_page.dart'
    as _i14;
import 'package:booknow_mobile/features/statistics/views/staff_statistics_page.dart'
    as _i28;
import 'package:booknow_mobile/features/statistics/views/statistics_detail_page.dart'
    as _i29;
import 'package:booknow_mobile/features/statistics/views/suggestions_page.dart'
    as _i30;
import 'package:booknow_mobile/features/statistics/widgets/statistics_sections.dart'
    as _i38;
import 'package:booknow_mobile/features/support/views/help_page.dart' as _i5;
import 'package:flutter/material.dart' as _i33;

/// generated route for
/// [_i1.BookingDetailPage]
class BookingDetailRoute extends _i32.PageRouteInfo<BookingDetailRouteArgs> {
  BookingDetailRoute({
    _i33.Key? key,
    required String bookingId,
    _i34.Booking? initial,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         BookingDetailRoute.name,
         args: BookingDetailRouteArgs(
           key: key,
           bookingId: bookingId,
           initial: initial,
         ),
         rawPathParams: {'bookingId': bookingId},
         initialChildren: children,
       );

  static const String name = 'BookingDetailRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<BookingDetailRouteArgs>(
        orElse: () => BookingDetailRouteArgs(
          bookingId: pathParams.getString('bookingId'),
        ),
      );
      return _i1.BookingDetailPage(
        key: args.key,
        bookingId: args.bookingId,
        initial: args.initial,
      );
    },
  );
}

class BookingDetailRouteArgs {
  const BookingDetailRouteArgs({
    this.key,
    required this.bookingId,
    this.initial,
  });

  final _i33.Key? key;

  final String bookingId;

  final _i34.Booking? initial;

  @override
  String toString() {
    return 'BookingDetailRouteArgs{key: $key, bookingId: $bookingId, initial: $initial}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BookingDetailRouteArgs) return false;
    return key == other.key &&
        bookingId == other.bookingId &&
        initial == other.initial;
  }

  @override
  int get hashCode => key.hashCode ^ bookingId.hashCode ^ initial.hashCode;
}

/// generated route for
/// [_i2.BookingFlowPage]
class BookingFlowRoute extends _i32.PageRouteInfo<BookingFlowRouteArgs> {
  BookingFlowRoute({
    _i33.Key? key,
    required String shopId,
    String? serviceId,
    DateTime? startUtc,
    String? initialDate,
    bool preview = false,
    _i35.ShopCategory? category,
    int? distanceMeters,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         BookingFlowRoute.name,
         args: BookingFlowRouteArgs(
           key: key,
           shopId: shopId,
           serviceId: serviceId,
           startUtc: startUtc,
           initialDate: initialDate,
           preview: preview,
           category: category,
           distanceMeters: distanceMeters,
         ),
         rawPathParams: {'shopId': shopId},
         initialChildren: children,
       );

  static const String name = 'BookingFlowRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<BookingFlowRouteArgs>(
        orElse: () =>
            BookingFlowRouteArgs(shopId: pathParams.getString('shopId')),
      );
      return _i2.BookingFlowPage(
        key: args.key,
        shopId: args.shopId,
        serviceId: args.serviceId,
        startUtc: args.startUtc,
        initialDate: args.initialDate,
        preview: args.preview,
        category: args.category,
        distanceMeters: args.distanceMeters,
      );
    },
  );
}

class BookingFlowRouteArgs {
  const BookingFlowRouteArgs({
    this.key,
    required this.shopId,
    this.serviceId,
    this.startUtc,
    this.initialDate,
    this.preview = false,
    this.category,
    this.distanceMeters,
  });

  final _i33.Key? key;

  final String shopId;

  final String? serviceId;

  final DateTime? startUtc;

  final String? initialDate;

  final bool preview;

  final _i35.ShopCategory? category;

  final int? distanceMeters;

  @override
  String toString() {
    return 'BookingFlowRouteArgs{key: $key, shopId: $shopId, serviceId: $serviceId, startUtc: $startUtc, initialDate: $initialDate, preview: $preview, category: $category, distanceMeters: $distanceMeters}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BookingFlowRouteArgs) return false;
    return key == other.key &&
        shopId == other.shopId &&
        serviceId == other.serviceId &&
        startUtc == other.startUtc &&
        initialDate == other.initialDate &&
        preview == other.preview &&
        category == other.category &&
        distanceMeters == other.distanceMeters;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      shopId.hashCode ^
      serviceId.hashCode ^
      startUtc.hashCode ^
      initialDate.hashCode ^
      preview.hashCode ^
      category.hashCode ^
      distanceMeters.hashCode;
}

/// generated route for
/// [_i3.BookingsPage]
class BookingsRoute extends _i32.PageRouteInfo<void> {
  const BookingsRoute({List<_i32.PageRouteInfo>? children})
    : super(BookingsRoute.name, initialChildren: children);

  static const String name = 'BookingsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i3.BookingsPage();
    },
  );
}

/// generated route for
/// [_i4.CustomerShellPage]
class CustomerShellRoute extends _i32.PageRouteInfo<void> {
  const CustomerShellRoute({List<_i32.PageRouteInfo>? children})
    : super(CustomerShellRoute.name, initialChildren: children);

  static const String name = 'CustomerShellRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i4.CustomerShellPage();
    },
  );
}

/// generated route for
/// [_i5.HelpPage]
class HelpRoute extends _i32.PageRouteInfo<void> {
  const HelpRoute({List<_i32.PageRouteInfo>? children})
    : super(HelpRoute.name, initialChildren: children);

  static const String name = 'HelpRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i5.HelpPage();
    },
  );
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i32.PageRouteInfo<void> {
  const HomeRoute({List<_i32.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomePage();
    },
  );
}

/// generated route for
/// [_i7.HoursPage]
class HoursRoute extends _i32.PageRouteInfo<void> {
  const HoursRoute({List<_i32.PageRouteInfo>? children})
    : super(HoursRoute.name, initialChildren: children);

  static const String name = 'HoursRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i7.HoursPage();
    },
  );
}

/// generated route for
/// [_i8.NeedsReviewPage]
class NeedsReviewRoute extends _i32.PageRouteInfo<void> {
  const NeedsReviewRoute({List<_i32.PageRouteInfo>? children})
    : super(NeedsReviewRoute.name, initialChildren: children);

  static const String name = 'NeedsReviewRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i8.NeedsReviewPage();
    },
  );
}

/// generated route for
/// [_i9.NotificationPermissionPage]
class NotificationPermissionRoute extends _i32.PageRouteInfo<void> {
  const NotificationPermissionRoute({List<_i32.PageRouteInfo>? children})
    : super(NotificationPermissionRoute.name, initialChildren: children);

  static const String name = 'NotificationPermissionRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i9.NotificationPermissionPage();
    },
  );
}

/// generated route for
/// [_i10.NotificationSettingsPage]
class NotificationSettingsRoute extends _i32.PageRouteInfo<void> {
  const NotificationSettingsRoute({List<_i32.PageRouteInfo>? children})
    : super(NotificationSettingsRoute.name, initialChildren: children);

  static const String name = 'NotificationSettingsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i10.NotificationSettingsPage();
    },
  );
}

/// generated route for
/// [_i11.OnboardingPage]
class OnboardingRoute extends _i32.PageRouteInfo<void> {
  const OnboardingRoute({List<_i32.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i11.OnboardingPage();
    },
  );
}

/// generated route for
/// [_i12.OwnerAgendaPage]
class OwnerAgendaRoute extends _i32.PageRouteInfo<void> {
  const OwnerAgendaRoute({List<_i32.PageRouteInfo>? children})
    : super(OwnerAgendaRoute.name, initialChildren: children);

  static const String name = 'OwnerAgendaRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i12.OwnerAgendaPage();
    },
  );
}

/// generated route for
/// [_i13.OwnerShellPage]
class OwnerShellRoute extends _i32.PageRouteInfo<void> {
  const OwnerShellRoute({List<_i32.PageRouteInfo>? children})
    : super(OwnerShellRoute.name, initialChildren: children);

  static const String name = 'OwnerShellRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i13.OwnerShellPage();
    },
  );
}

/// generated route for
/// [_i14.OwnerStatisticsPage]
class OwnerStatisticsRoute extends _i32.PageRouteInfo<void> {
  const OwnerStatisticsRoute({List<_i32.PageRouteInfo>? children})
    : super(OwnerStatisticsRoute.name, initialChildren: children);

  static const String name = 'OwnerStatisticsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i14.OwnerStatisticsPage();
    },
  );
}

/// generated route for
/// [_i15.OwnerTodayPage]
class OwnerTodayRoute extends _i32.PageRouteInfo<void> {
  const OwnerTodayRoute({List<_i32.PageRouteInfo>? children})
    : super(OwnerTodayRoute.name, initialChildren: children);

  static const String name = 'OwnerTodayRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i15.OwnerTodayPage();
    },
  );
}

/// generated route for
/// [_i16.PersonalDataPage]
class PersonalDataRoute extends _i32.PageRouteInfo<PersonalDataRouteArgs> {
  PersonalDataRoute({
    _i33.Key? key,
    String? shopName,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         PersonalDataRoute.name,
         args: PersonalDataRouteArgs(key: key, shopName: shopName),
         initialChildren: children,
       );

  static const String name = 'PersonalDataRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PersonalDataRouteArgs>(
        orElse: () => const PersonalDataRouteArgs(),
      );
      return _i16.PersonalDataPage(key: args.key, shopName: args.shopName);
    },
  );
}

class PersonalDataRouteArgs {
  const PersonalDataRouteArgs({this.key, this.shopName});

  final _i33.Key? key;

  final String? shopName;

  @override
  String toString() {
    return 'PersonalDataRouteArgs{key: $key, shopName: $shopName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PersonalDataRouteArgs) return false;
    return key == other.key && shopName == other.shopName;
  }

  @override
  int get hashCode => key.hashCode ^ shopName.hashCode;
}

/// generated route for
/// [_i17.ProfilePage]
class ProfileRoute extends _i32.PageRouteInfo<void> {
  const ProfileRoute({List<_i32.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i17.ProfilePage();
    },
  );
}

/// generated route for
/// [_i18.ProfileSetupPage]
class ProfileSetupRoute extends _i32.PageRouteInfo<void> {
  const ProfileSetupRoute({List<_i32.PageRouteInfo>? children})
    : super(ProfileSetupRoute.name, initialChildren: children);

  static const String name = 'ProfileSetupRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i18.ProfileSetupPage();
    },
  );
}

/// generated route for
/// [_i19.QueueFlowPage]
class QueueFlowRoute extends _i32.PageRouteInfo<QueueFlowRouteArgs> {
  QueueFlowRoute({
    _i33.Key? key,
    required String shopId,
    bool preview = false,
    _i35.ShopCategory? category,
    int? distanceMeters,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         QueueFlowRoute.name,
         args: QueueFlowRouteArgs(
           key: key,
           shopId: shopId,
           preview: preview,
           category: category,
           distanceMeters: distanceMeters,
         ),
         rawPathParams: {'shopId': shopId},
         initialChildren: children,
       );

  static const String name = 'QueueFlowRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<QueueFlowRouteArgs>(
        orElse: () =>
            QueueFlowRouteArgs(shopId: pathParams.getString('shopId')),
      );
      return _i19.QueueFlowPage(
        key: args.key,
        shopId: args.shopId,
        preview: args.preview,
        category: args.category,
        distanceMeters: args.distanceMeters,
      );
    },
  );
}

class QueueFlowRouteArgs {
  const QueueFlowRouteArgs({
    this.key,
    required this.shopId,
    this.preview = false,
    this.category,
    this.distanceMeters,
  });

  final _i33.Key? key;

  final String shopId;

  final bool preview;

  final _i35.ShopCategory? category;

  final int? distanceMeters;

  @override
  String toString() {
    return 'QueueFlowRouteArgs{key: $key, shopId: $shopId, preview: $preview, category: $category, distanceMeters: $distanceMeters}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QueueFlowRouteArgs) return false;
    return key == other.key &&
        shopId == other.shopId &&
        preview == other.preview &&
        category == other.category &&
        distanceMeters == other.distanceMeters;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      shopId.hashCode ^
      preview.hashCode ^
      category.hashCode ^
      distanceMeters.hashCode;
}

/// generated route for
/// [_i20.RolePage]
class RoleRoute extends _i32.PageRouteInfo<void> {
  const RoleRoute({List<_i32.PageRouteInfo>? children})
    : super(RoleRoute.name, initialChildren: children);

  static const String name = 'RoleRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i20.RolePage();
    },
  );
}

/// generated route for
/// [_i21.ServicesPage]
class ServicesRoute extends _i32.PageRouteInfo<void> {
  const ServicesRoute({List<_i32.PageRouteInfo>? children})
    : super(ServicesRoute.name, initialChildren: children);

  static const String name = 'ServicesRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i21.ServicesPage();
    },
  );
}

/// generated route for
/// [_i22.ShopDetailsPage]
class ShopDetailsRoute extends _i32.PageRouteInfo<void> {
  const ShopDetailsRoute({List<_i32.PageRouteInfo>? children})
    : super(ShopDetailsRoute.name, initialChildren: children);

  static const String name = 'ShopDetailsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i22.ShopDetailsPage();
    },
  );
}

/// generated route for
/// [_i23.ShopModePage]
class ShopModeRoute extends _i32.PageRouteInfo<ShopModeRouteArgs> {
  ShopModeRoute({
    _i33.Key? key,
    required _i36.ShopMode current,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         ShopModeRoute.name,
         args: ShopModeRouteArgs(key: key, current: current),
         initialChildren: children,
       );

  static const String name = 'ShopModeRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShopModeRouteArgs>();
      return _i23.ShopModePage(key: args.key, current: args.current);
    },
  );
}

class ShopModeRouteArgs {
  const ShopModeRouteArgs({this.key, required this.current});

  final _i33.Key? key;

  final _i36.ShopMode current;

  @override
  String toString() {
    return 'ShopModeRouteArgs{key: $key, current: $current}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ShopModeRouteArgs) return false;
    return key == other.key && current == other.current;
  }

  @override
  int get hashCode => key.hashCode ^ current.hashCode;
}

/// generated route for
/// [_i24.ShopSetupPage]
class ShopSetupRoute extends _i32.PageRouteInfo<ShopSetupRouteArgs> {
  ShopSetupRoute({
    _i33.Key? key,
    _i37.ShopSetupStep? initialStep,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         ShopSetupRoute.name,
         args: ShopSetupRouteArgs(key: key, initialStep: initialStep),
         initialChildren: children,
       );

  static const String name = 'ShopSetupRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShopSetupRouteArgs>(
        orElse: () => const ShopSetupRouteArgs(),
      );
      return _i24.ShopSetupPage(key: args.key, initialStep: args.initialStep);
    },
  );
}

class ShopSetupRouteArgs {
  const ShopSetupRouteArgs({this.key, this.initialStep});

  final _i33.Key? key;

  final _i37.ShopSetupStep? initialStep;

  @override
  String toString() {
    return 'ShopSetupRouteArgs{key: $key, initialStep: $initialStep}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ShopSetupRouteArgs) return false;
    return key == other.key && initialStep == other.initialStep;
  }

  @override
  int get hashCode => key.hashCode ^ initialStep.hashCode;
}

/// generated route for
/// [_i25.SignInPage]
class SignInRoute extends _i32.PageRouteInfo<void> {
  const SignInRoute({List<_i32.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i25.SignInPage();
    },
  );
}

/// generated route for
/// [_i26.SignUpPage]
class SignUpRoute extends _i32.PageRouteInfo<void> {
  const SignUpRoute({List<_i32.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i26.SignUpPage();
    },
  );
}

/// generated route for
/// [_i27.SplashPage]
class SplashRoute extends _i32.PageRouteInfo<void> {
  const SplashRoute({List<_i32.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i27.SplashPage();
    },
  );
}

/// generated route for
/// [_i28.StaffStatisticsPage]
class StaffStatisticsRoute
    extends _i32.PageRouteInfo<StaffStatisticsRouteArgs> {
  StaffStatisticsRoute({
    _i33.Key? key,
    required String providerId,
    required String name,
    int? days,
    String? from,
    String? to,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         StaffStatisticsRoute.name,
         args: StaffStatisticsRouteArgs(
           key: key,
           providerId: providerId,
           name: name,
           days: days,
           from: from,
           to: to,
         ),
         initialChildren: children,
       );

  static const String name = 'StaffStatisticsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StaffStatisticsRouteArgs>();
      return _i28.StaffStatisticsPage(
        key: args.key,
        providerId: args.providerId,
        name: args.name,
        days: args.days,
        from: args.from,
        to: args.to,
      );
    },
  );
}

class StaffStatisticsRouteArgs {
  const StaffStatisticsRouteArgs({
    this.key,
    required this.providerId,
    required this.name,
    this.days,
    this.from,
    this.to,
  });

  final _i33.Key? key;

  final String providerId;

  final String name;

  final int? days;

  final String? from;

  final String? to;

  @override
  String toString() {
    return 'StaffStatisticsRouteArgs{key: $key, providerId: $providerId, name: $name, days: $days, from: $from, to: $to}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! StaffStatisticsRouteArgs) return false;
    return key == other.key &&
        providerId == other.providerId &&
        name == other.name &&
        days == other.days &&
        from == other.from &&
        to == other.to;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      providerId.hashCode ^
      name.hashCode ^
      days.hashCode ^
      from.hashCode ^
      to.hashCode;
}

/// generated route for
/// [_i29.StatisticsDetailPage]
class StatisticsDetailRoute
    extends _i32.PageRouteInfo<StatisticsDetailRouteArgs> {
  StatisticsDetailRoute({
    _i33.Key? key,
    required _i38.StatisticsSection section,
    required _i39.OwnerStatisticsCubit cubit,
    List<_i32.PageRouteInfo>? children,
  }) : super(
         StatisticsDetailRoute.name,
         args: StatisticsDetailRouteArgs(
           key: key,
           section: section,
           cubit: cubit,
         ),
         initialChildren: children,
       );

  static const String name = 'StatisticsDetailRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StatisticsDetailRouteArgs>();
      return _i29.StatisticsDetailPage(
        key: args.key,
        section: args.section,
        cubit: args.cubit,
      );
    },
  );
}

class StatisticsDetailRouteArgs {
  const StatisticsDetailRouteArgs({
    this.key,
    required this.section,
    required this.cubit,
  });

  final _i33.Key? key;

  final _i38.StatisticsSection section;

  final _i39.OwnerStatisticsCubit cubit;

  @override
  String toString() {
    return 'StatisticsDetailRouteArgs{key: $key, section: $section, cubit: $cubit}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! StatisticsDetailRouteArgs) return false;
    return key == other.key && section == other.section && cubit == other.cubit;
  }

  @override
  int get hashCode => key.hashCode ^ section.hashCode ^ cubit.hashCode;
}

/// generated route for
/// [_i30.SuggestionsPage]
class SuggestionsRoute extends _i32.PageRouteInfo<void> {
  const SuggestionsRoute({List<_i32.PageRouteInfo>? children})
    : super(SuggestionsRoute.name, initialChildren: children);

  static const String name = 'SuggestionsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i30.SuggestionsPage();
    },
  );
}

/// generated route for
/// [_i31.TeamPage]
class TeamRoute extends _i32.PageRouteInfo<void> {
  const TeamRoute({List<_i32.PageRouteInfo>? children})
    : super(TeamRoute.name, initialChildren: children);

  static const String name = 'TeamRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i31.TeamPage();
    },
  );
}
