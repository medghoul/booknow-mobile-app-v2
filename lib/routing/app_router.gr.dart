// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i29;
import 'package:booknow_mobile/core/structures/enums/queue_enums.dart' as _i33;
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart'
    as _i34;
import 'package:booknow_mobile/domain/models/index.dart' as _i31;
import 'package:booknow_mobile/features/agenda/views/owner_agenda_page.dart'
    as _i11;
import 'package:booknow_mobile/features/agenda/views/owner_today_page.dart'
    as _i14;
import 'package:booknow_mobile/features/auth/views/profile_setup_page.dart'
    as _i17;
import 'package:booknow_mobile/features/auth/views/role_page.dart' as _i19;
import 'package:booknow_mobile/features/auth/views/sign_in_page.dart' as _i24;
import 'package:booknow_mobile/features/auth/views/sign_up_page.dart' as _i25;
import 'package:booknow_mobile/features/booking_flow/views/booking_flow_page.dart'
    as _i2;
import 'package:booknow_mobile/features/bookings/views/booking_detail_page.dart'
    as _i1;
import 'package:booknow_mobile/features/bookings/views/bookings_page.dart'
    as _i3;
import 'package:booknow_mobile/features/home/views/home_page.dart' as _i6;
import 'package:booknow_mobile/features/home/widgets/category_blob.dart'
    as _i32;
import 'package:booknow_mobile/features/notifications/views/notification_permission_page.dart'
    as _i8;
import 'package:booknow_mobile/features/notifications/views/notification_settings_page.dart'
    as _i9;
import 'package:booknow_mobile/features/onboarding/views/onboarding_page.dart'
    as _i10;
import 'package:booknow_mobile/features/profile/views/personal_data_page.dart'
    as _i15;
import 'package:booknow_mobile/features/profile/views/profile_page.dart'
    as _i16;
import 'package:booknow_mobile/features/queue/views/queue_flow_page.dart'
    as _i18;
import 'package:booknow_mobile/features/queue/views/shop_mode_page.dart'
    as _i22;
import 'package:booknow_mobile/features/shell/views/customer_shell_page.dart'
    as _i4;
import 'package:booknow_mobile/features/shell/views/owner_shell_page.dart'
    as _i12;
import 'package:booknow_mobile/features/shop_setup/views/hours_page.dart'
    as _i7;
import 'package:booknow_mobile/features/shop_setup/views/services_page.dart'
    as _i20;
import 'package:booknow_mobile/features/shop_setup/views/shop_details_page.dart'
    as _i21;
import 'package:booknow_mobile/features/shop_setup/views/shop_setup_page.dart'
    as _i23;
import 'package:booknow_mobile/features/shop_setup/views/team_page.dart'
    as _i28;
import 'package:booknow_mobile/features/splash/views/splash_page.dart' as _i26;
import 'package:booknow_mobile/features/statistics/cubit/owner_statistics_cubit.dart'
    as _i36;
import 'package:booknow_mobile/features/statistics/views/owner_statistics_page.dart'
    as _i13;
import 'package:booknow_mobile/features/statistics/views/statistics_detail_page.dart'
    as _i27;
import 'package:booknow_mobile/features/statistics/widgets/statistics_sections.dart'
    as _i35;
import 'package:booknow_mobile/features/support/views/help_page.dart' as _i5;
import 'package:flutter/material.dart' as _i30;

/// generated route for
/// [_i1.BookingDetailPage]
class BookingDetailRoute extends _i29.PageRouteInfo<BookingDetailRouteArgs> {
  BookingDetailRoute({
    _i30.Key? key,
    required String bookingId,
    _i31.Booking? initial,
    List<_i29.PageRouteInfo>? children,
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

  static _i29.PageInfo page = _i29.PageInfo(
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

  final _i30.Key? key;

  final String bookingId;

  final _i31.Booking? initial;

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
class BookingFlowRoute extends _i29.PageRouteInfo<BookingFlowRouteArgs> {
  BookingFlowRoute({
    _i30.Key? key,
    required String shopId,
    String? serviceId,
    DateTime? startUtc,
    String? initialDate,
    bool preview = false,
    _i32.ShopCategory? category,
    int? distanceMeters,
    List<_i29.PageRouteInfo>? children,
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

  static _i29.PageInfo page = _i29.PageInfo(
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

  final _i30.Key? key;

  final String shopId;

  final String? serviceId;

  final DateTime? startUtc;

  final String? initialDate;

  final bool preview;

  final _i32.ShopCategory? category;

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
class BookingsRoute extends _i29.PageRouteInfo<void> {
  const BookingsRoute({List<_i29.PageRouteInfo>? children})
    : super(BookingsRoute.name, initialChildren: children);

  static const String name = 'BookingsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i3.BookingsPage();
    },
  );
}

/// generated route for
/// [_i4.CustomerShellPage]
class CustomerShellRoute extends _i29.PageRouteInfo<void> {
  const CustomerShellRoute({List<_i29.PageRouteInfo>? children})
    : super(CustomerShellRoute.name, initialChildren: children);

  static const String name = 'CustomerShellRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i4.CustomerShellPage();
    },
  );
}

/// generated route for
/// [_i5.HelpPage]
class HelpRoute extends _i29.PageRouteInfo<void> {
  const HelpRoute({List<_i29.PageRouteInfo>? children})
    : super(HelpRoute.name, initialChildren: children);

  static const String name = 'HelpRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i5.HelpPage();
    },
  );
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i29.PageRouteInfo<void> {
  const HomeRoute({List<_i29.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomePage();
    },
  );
}

/// generated route for
/// [_i7.HoursPage]
class HoursRoute extends _i29.PageRouteInfo<void> {
  const HoursRoute({List<_i29.PageRouteInfo>? children})
    : super(HoursRoute.name, initialChildren: children);

  static const String name = 'HoursRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i7.HoursPage();
    },
  );
}

/// generated route for
/// [_i8.NotificationPermissionPage]
class NotificationPermissionRoute extends _i29.PageRouteInfo<void> {
  const NotificationPermissionRoute({List<_i29.PageRouteInfo>? children})
    : super(NotificationPermissionRoute.name, initialChildren: children);

  static const String name = 'NotificationPermissionRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i8.NotificationPermissionPage();
    },
  );
}

/// generated route for
/// [_i9.NotificationSettingsPage]
class NotificationSettingsRoute extends _i29.PageRouteInfo<void> {
  const NotificationSettingsRoute({List<_i29.PageRouteInfo>? children})
    : super(NotificationSettingsRoute.name, initialChildren: children);

  static const String name = 'NotificationSettingsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i9.NotificationSettingsPage();
    },
  );
}

/// generated route for
/// [_i10.OnboardingPage]
class OnboardingRoute extends _i29.PageRouteInfo<void> {
  const OnboardingRoute({List<_i29.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i10.OnboardingPage();
    },
  );
}

/// generated route for
/// [_i11.OwnerAgendaPage]
class OwnerAgendaRoute extends _i29.PageRouteInfo<void> {
  const OwnerAgendaRoute({List<_i29.PageRouteInfo>? children})
    : super(OwnerAgendaRoute.name, initialChildren: children);

  static const String name = 'OwnerAgendaRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i11.OwnerAgendaPage();
    },
  );
}

/// generated route for
/// [_i12.OwnerShellPage]
class OwnerShellRoute extends _i29.PageRouteInfo<void> {
  const OwnerShellRoute({List<_i29.PageRouteInfo>? children})
    : super(OwnerShellRoute.name, initialChildren: children);

  static const String name = 'OwnerShellRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i12.OwnerShellPage();
    },
  );
}

/// generated route for
/// [_i13.OwnerStatisticsPage]
class OwnerStatisticsRoute extends _i29.PageRouteInfo<void> {
  const OwnerStatisticsRoute({List<_i29.PageRouteInfo>? children})
    : super(OwnerStatisticsRoute.name, initialChildren: children);

  static const String name = 'OwnerStatisticsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i13.OwnerStatisticsPage();
    },
  );
}

/// generated route for
/// [_i14.OwnerTodayPage]
class OwnerTodayRoute extends _i29.PageRouteInfo<void> {
  const OwnerTodayRoute({List<_i29.PageRouteInfo>? children})
    : super(OwnerTodayRoute.name, initialChildren: children);

  static const String name = 'OwnerTodayRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i14.OwnerTodayPage();
    },
  );
}

/// generated route for
/// [_i15.PersonalDataPage]
class PersonalDataRoute extends _i29.PageRouteInfo<PersonalDataRouteArgs> {
  PersonalDataRoute({
    _i30.Key? key,
    String? shopName,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         PersonalDataRoute.name,
         args: PersonalDataRouteArgs(key: key, shopName: shopName),
         initialChildren: children,
       );

  static const String name = 'PersonalDataRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PersonalDataRouteArgs>(
        orElse: () => const PersonalDataRouteArgs(),
      );
      return _i15.PersonalDataPage(key: args.key, shopName: args.shopName);
    },
  );
}

class PersonalDataRouteArgs {
  const PersonalDataRouteArgs({this.key, this.shopName});

  final _i30.Key? key;

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
/// [_i16.ProfilePage]
class ProfileRoute extends _i29.PageRouteInfo<void> {
  const ProfileRoute({List<_i29.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i16.ProfilePage();
    },
  );
}

/// generated route for
/// [_i17.ProfileSetupPage]
class ProfileSetupRoute extends _i29.PageRouteInfo<void> {
  const ProfileSetupRoute({List<_i29.PageRouteInfo>? children})
    : super(ProfileSetupRoute.name, initialChildren: children);

  static const String name = 'ProfileSetupRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i17.ProfileSetupPage();
    },
  );
}

/// generated route for
/// [_i18.QueueFlowPage]
class QueueFlowRoute extends _i29.PageRouteInfo<QueueFlowRouteArgs> {
  QueueFlowRoute({
    _i30.Key? key,
    required String shopId,
    bool preview = false,
    _i32.ShopCategory? category,
    int? distanceMeters,
    List<_i29.PageRouteInfo>? children,
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

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<QueueFlowRouteArgs>(
        orElse: () =>
            QueueFlowRouteArgs(shopId: pathParams.getString('shopId')),
      );
      return _i18.QueueFlowPage(
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

  final _i30.Key? key;

  final String shopId;

  final bool preview;

  final _i32.ShopCategory? category;

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
/// [_i19.RolePage]
class RoleRoute extends _i29.PageRouteInfo<void> {
  const RoleRoute({List<_i29.PageRouteInfo>? children})
    : super(RoleRoute.name, initialChildren: children);

  static const String name = 'RoleRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i19.RolePage();
    },
  );
}

/// generated route for
/// [_i20.ServicesPage]
class ServicesRoute extends _i29.PageRouteInfo<void> {
  const ServicesRoute({List<_i29.PageRouteInfo>? children})
    : super(ServicesRoute.name, initialChildren: children);

  static const String name = 'ServicesRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i20.ServicesPage();
    },
  );
}

/// generated route for
/// [_i21.ShopDetailsPage]
class ShopDetailsRoute extends _i29.PageRouteInfo<void> {
  const ShopDetailsRoute({List<_i29.PageRouteInfo>? children})
    : super(ShopDetailsRoute.name, initialChildren: children);

  static const String name = 'ShopDetailsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i21.ShopDetailsPage();
    },
  );
}

/// generated route for
/// [_i22.ShopModePage]
class ShopModeRoute extends _i29.PageRouteInfo<ShopModeRouteArgs> {
  ShopModeRoute({
    _i30.Key? key,
    required _i33.ShopMode current,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         ShopModeRoute.name,
         args: ShopModeRouteArgs(key: key, current: current),
         initialChildren: children,
       );

  static const String name = 'ShopModeRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShopModeRouteArgs>();
      return _i22.ShopModePage(key: args.key, current: args.current);
    },
  );
}

class ShopModeRouteArgs {
  const ShopModeRouteArgs({this.key, required this.current});

  final _i30.Key? key;

  final _i33.ShopMode current;

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
/// [_i23.ShopSetupPage]
class ShopSetupRoute extends _i29.PageRouteInfo<ShopSetupRouteArgs> {
  ShopSetupRoute({
    _i30.Key? key,
    _i34.ShopSetupStep? initialStep,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         ShopSetupRoute.name,
         args: ShopSetupRouteArgs(key: key, initialStep: initialStep),
         initialChildren: children,
       );

  static const String name = 'ShopSetupRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShopSetupRouteArgs>(
        orElse: () => const ShopSetupRouteArgs(),
      );
      return _i23.ShopSetupPage(key: args.key, initialStep: args.initialStep);
    },
  );
}

class ShopSetupRouteArgs {
  const ShopSetupRouteArgs({this.key, this.initialStep});

  final _i30.Key? key;

  final _i34.ShopSetupStep? initialStep;

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
/// [_i24.SignInPage]
class SignInRoute extends _i29.PageRouteInfo<void> {
  const SignInRoute({List<_i29.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i24.SignInPage();
    },
  );
}

/// generated route for
/// [_i25.SignUpPage]
class SignUpRoute extends _i29.PageRouteInfo<void> {
  const SignUpRoute({List<_i29.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i25.SignUpPage();
    },
  );
}

/// generated route for
/// [_i26.SplashPage]
class SplashRoute extends _i29.PageRouteInfo<void> {
  const SplashRoute({List<_i29.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i26.SplashPage();
    },
  );
}

/// generated route for
/// [_i27.StatisticsDetailPage]
class StatisticsDetailRoute
    extends _i29.PageRouteInfo<StatisticsDetailRouteArgs> {
  StatisticsDetailRoute({
    _i30.Key? key,
    required _i35.StatisticsSection section,
    required _i36.OwnerStatisticsCubit cubit,
    List<_i29.PageRouteInfo>? children,
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

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StatisticsDetailRouteArgs>();
      return _i27.StatisticsDetailPage(
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

  final _i30.Key? key;

  final _i35.StatisticsSection section;

  final _i36.OwnerStatisticsCubit cubit;

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
/// [_i28.TeamPage]
class TeamRoute extends _i29.PageRouteInfo<void> {
  const TeamRoute({List<_i29.PageRouteInfo>? children})
    : super(TeamRoute.name, initialChildren: children);

  static const String name = 'TeamRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i28.TeamPage();
    },
  );
}
