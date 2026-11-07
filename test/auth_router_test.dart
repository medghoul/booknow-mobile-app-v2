import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/core/structures/enums/user_role.dart';
import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/auth/routing/auth_destination.dart';
import 'package:flutter_test/flutter_test.dart';

UserProfile profile({UserRole? role, bool profileSetupSeen = true}) =>
    UserProfile(
      id: 'u1',
      name: 'Marco',
      email: 'm@example.com',
      role: role,
      profileSetupSeen: profileSetupSeen,
    );

const _address = ShopAddress(
  line: 'Via dei Coronari 18',
  city: 'Roma',
  zip: '00186',
  country: 'IT',
  latitude: 41.9,
  longitude: 12.47,
);

const _service = ShopService(
  id: 's1',
  name: 'Taglio',
  durationMinutes: 30,
  priceCents: 1800,
);

final _hours = OpeningHours({
  Weekday.tuesday: const [TimeRange(from: '09:00', to: '13:00')],
});

Shop shop({
  ShopStatus status = ShopStatus.draft,
  String? name = 'Barbieri Navona',
  String? phone = '+39 06 000000',
  ShopAddress? address = _address,
  List<ShopService> services = const [_service],
  OpeningHours? hours,
}) => Shop(
  id: 'shop-1',
  status: status,
  name: name,
  phone: phone,
  address: address,
  services: services,
  openingHours: hours ?? _hours,
);

void main() {
  group('destinationFor', () {
    test('no profile means sign in', () {
      expect(
        AuthRouter.destinationFor(profile: null),
        isA<SignInDestination>(),
      );
    });

    test('no role means the role screen, whatever the shop says', () {
      expect(
        AuthRouter.destinationFor(profile: profile(), shop: shop()),
        isA<RoleChoiceDestination>(),
      );
    });

    test('a customer goes home and never sees a shop', () {
      expect(
        AuthRouter.destinationFor(profile: profile(role: UserRole.customer)),
        isA<CustomerHomeDestination>(),
      );
    });

    group('owner', () {
      test('with no shop starts the wizard at step one', () {
        final destination = AuthRouter.destinationFor(
          profile: profile(role: UserRole.owner),
        );

        expect(destination, isA<ShopSetupDestination>());
        expect((destination as ShopSetupDestination).step, ShopSetupStep.shop);
      });

      test('with an active shop goes to the agenda', () {
        expect(
          AuthRouter.destinationFor(
            profile: profile(role: UserRole.owner),
            shop: shop(status: ShopStatus.active),
          ),
          isA<OwnerAgendaDestination>(),
        );
      });

      test('with a draft resumes at the first incomplete step', () {
        final destination = AuthRouter.destinationFor(
          profile: profile(role: UserRole.owner),
          // Everything but the services.
          shop: shop(services: const []),
        );

        expect(
          (destination as ShopSetupDestination).step,
          ShopSetupStep.services,
        );
      });

      test('a complete draft resumes at the review, not back at step one', () {
        final destination = AuthRouter.destinationFor(
          profile: profile(role: UserRole.owner),
          shop: shop(),
        );

        expect(
          (destination as ShopSetupDestination).step,
          ShopSetupStep.review,
        );
      });

      test('a deleted shop sends the owner back through the wizard', () {
        expect(
          AuthRouter.destinationFor(
            profile: profile(role: UserRole.owner),
            shop: shop(status: ShopStatus.deleted),
          ),
          isA<ShopSetupDestination>(),
        );
      });
    });
  });

  group('the once-only steps after the role', () {
    test('profile setup comes before notifications', () {
      expect(
        AuthRouter.destinationFor(
          profile: profile(role: UserRole.owner, profileSetupSeen: false),
          shop: shop(status: ShopStatus.active),
          notificationsPrompted: false,
        ),
        isA<ProfileSetupDestination>(),
      );
    });

    // §4.4: a customer is asked after their first confirmed booking, not on
    // the way in. The explainer promises reminders for an appointment they
    // have not made yet, and iOS only allows the prompt once.
    test('a customer goes straight home and is asked later', () {
      expect(
        AuthRouter.destinationFor(
          profile: profile(role: UserRole.customer),
          notificationsPrompted: false,
        ),
        isA<CustomerHomeDestination>(),
      );
      expect(
        AuthRouter.destinationFor(profile: profile(role: UserRole.customer)),
        isA<CustomerHomeDestination>(),
      );
    });

    // The owner's moment, which this journey does know: the shop is live, and
    // the next thing to happen is a booking they would otherwise only find by
    // opening the agenda.
    test('an owner is asked once the shop is published', () {
      expect(
        AuthRouter.destinationFor(
          profile: profile(role: UserRole.owner),
          shop: shop(status: ShopStatus.active),
          notificationsPrompted: false,
        ),
        isA<NotificationPermissionDestination>(),
      );
      expect(
        AuthRouter.destinationFor(
          profile: profile(role: UserRole.owner),
          shop: shop(status: ShopStatus.active),
        ),
        isA<OwnerAgendaDestination>(),
      );
    });

    test('an owner finishes the shop before either is asked', () {
      // A draft shop outranks both: there is nothing useful behind them until
      // the shop exists.
      expect(
        AuthRouter.destinationFor(
          profile: profile(role: UserRole.owner, profileSetupSeen: false),
          shop: shop(services: const []),
          notificationsPrompted: false,
        ),
        isA<ShopSetupDestination>(),
      );
    });

    test('a published owner is asked, then lands on the agenda', () {
      expect(
        AuthRouter.destinationFor(
          profile: profile(role: UserRole.owner),
          shop: shop(status: ShopStatus.active),
          notificationsPrompted: false,
        ),
        isA<NotificationPermissionDestination>(),
      );
      expect(
        AuthRouter.destinationFor(
          profile: profile(role: UserRole.owner),
          shop: shop(status: ShopStatus.active),
        ),
        isA<OwnerAgendaDestination>(),
      );
    });

    // The regression that sent a reinstalled app back to a screen the user
    // had already dismissed: the answer used to live in SharedPreferences,
    // which deleting the app wipes, while the session in the keychain
    // survives. It is on the profile now, so the device cannot forget it.
    test('a customer stays on their screen whether or not it was answered', () {
      final answered = profile(role: UserRole.customer);

      expect(
        AuthRouter.destinationFor(profile: answered),
        isA<CustomerHomeDestination>(),
      );
      expect(
        AuthRouter.destinationFor(
          profile: answered.copyWith(profileSetupSeen: false),
        ),
        isA<CustomerHomeDestination>(),
      );
    });

    test('neither is ever shown before a role is chosen', () {
      expect(
        AuthRouter.destinationFor(
          profile: profile(profileSetupSeen: false),
          notificationsPrompted: false,
        ),
        isA<RoleChoiceDestination>(),
      );
    });
  });

  group('needsShop', () {
    test('only owners need the shop fetched', () {
      expect(AuthRouter.needsShop(profile(role: UserRole.owner)), isTrue);
      expect(AuthRouter.needsShop(profile(role: UserRole.customer)), isFalse);
      expect(AuthRouter.needsShop(profile()), isFalse);
      expect(AuthRouter.needsShop(null), isFalse);
    });
  });

  group('Shop.missingForPublish', () {
    test('lists gaps in wizard order', () {
      final incomplete = shop(
        name: null,
        address: null,
        services: const [],
        hours: const OpeningHours(),
      );

      expect(incomplete.missingForPublish, [
        ShopSetupStep.shop,
        ShopSetupStep.address,
        ShopSetupStep.services,
        ShopSetupStep.hours,
      ]);
      expect(incomplete.canPublish, isFalse);
    });

    test('a shop with everything can publish', () {
      expect(shop().missingForPublish, isEmpty);
      expect(shop().canPublish, isTrue);
    });

    test('an ungeocoded address does not count as an address', () {
      // The owner typed something but never picked a suggestion, so the
      // server never resolved coordinates.
      final typed = shop(
        address: const ShopAddress(
          line: 'Via dei Coronari 18',
          city: 'Roma',
          zip: '00186',
          country: 'IT',
        ),
      );

      expect(typed.hasAddress, isFalse);
      expect(typed.missingForPublish, contains(ShopSetupStep.address));
    });

    test('soft-deleted services do not keep a shop publishable', () {
      final noneActive = shop(
        services: const [
          ShopService(
            id: 's1',
            name: 'Taglio',
            durationMinutes: 30,
            priceCents: 1800,
            isActive: false,
          ),
        ],
      );

      expect(noneActive.hasServices, isFalse);
    });
  });
}
