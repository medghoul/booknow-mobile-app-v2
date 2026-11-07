import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/core/structures/enums/weekday.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/features/auth/cubit/auth_state.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_state.dart';
import 'package:flutter_test/flutter_test.dart';

/// Before freezed none of these had `==`, so two identical states compared
/// unequal and `emit` rebuilt every listener on every call.
void main() {
  const service = ShopService(
    id: 's1',
    name: 'Taglio',
    durationMinutes: 30,
    priceCents: 1500,
  );

  const address = ShopAddress(
    line: 'Via dei Coronari 18',
    city: 'Roma',
    zip: '00186',
    country: 'IT',
    latitude: 41.9,
    longitude: 12.5,
  );

  group('value equality', () {
    test('two identically-built shops are equal', () {
      const a = Shop(id: 'x', status: ShopStatus.draft, name: 'Il salotto');
      const b = Shop(id: 'x', status: ShopStatus.draft, name: 'Il salotto');

      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(identical(a, b), isTrue, reason: 'const canonicalisation');
    });

    test('a difference in any field breaks equality', () {
      const base = Shop(id: 'x', status: ShopStatus.draft);

      expect(base, isNot(base.copyWith(name: 'Il salotto')));
      expect(base, isNot(base.copyWith(status: ShopStatus.active)));
      expect(base, isNot(base.copyWith(address: address)));
      expect(base, isNot(base.copyWith(services: const [service])));
    });

    test('collections compare deeply, not by reference', () {
      final one = Shop(id: 'x', status: ShopStatus.draft, services: [service]);
      final two = Shop(id: 'x', status: ShopStatus.draft, services: [service]);

      expect(identical(one.services, two.services), isFalse);
      expect(one, two);
    });

    test('opening hours compare by content', () {
      final monday = [const TimeRange(from: '09:00', to: '13:00')];
      expect(
        OpeningHours({Weekday.monday: monday}),
        OpeningHours({
          Weekday.monday: [...monday],
        }),
      );
      expect(const OpeningHours(), const OpeningHours());
    });
  });

  group('copyWith clears a nullable field', () {
    // The hand-written `name ?? this.name` could not do this, which is why the
    // states carried `clearFailure` / `clearEditing` flags.
    test('ShopSetupState.editingServiceId', () {
      const editing = ShopSetupState(editingServiceId: 's1');
      expect(editing.copyWith(editingServiceId: null).editingServiceId, isNull);
    });

    test('AuthState.pendingProvider', () {
      const profile = UserProfile(id: 'u', name: 'Marco', email: 'm@x.it');
      const signedIn = AuthState(profile: profile);
      expect(signedIn.copyWith(profile: null).profile, isNull);
    });
  });

  group('cubit states compare by value', () {
    test('ShopSetupState', () {
      const a = ShopSetupState(isLoading: false);
      expect(a, a.copyWith(isLoading: false));
      expect(a, isNot(a.copyWith(isLoading: true)));
    });

    test('AuthState', () {
      const a = AuthState(isSubmitting: true);
      expect(a, a.copyWith(isSubmitting: true));
      expect(a, isNot(a.copyWith(isSubmitting: false)));
    });
  });
}
