import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/core/structures/enums/shop_setup_step.dart';
import 'package:booknow_mobile/core/structures/enums/shop_status.dart';
import 'package:booknow_mobile/domain/models/index.dart';
import 'package:booknow_mobile/domain/repositories/shop_repository.dart';
import 'package:booknow_mobile/features/shop_setup/cubit/shop_setup_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

const _suggestion = PlaceSuggestion(
  placeId: 'p1',
  label: 'Via dei Coronari 18',
  secondaryLabel: '00186 Roma',
);

const _withPhoto = Shop(
  id: 's',
  status: ShopStatus.draft,
  photoUrl: 'https://example.test/shops/s/photo.jpg',
);

const _resolved = Shop(
  id: 's',
  status: ShopStatus.draft,
  address: ShopAddress(
    line: 'Via dei Coronari 18',
    city: 'Roma',
    zip: '00186',
    country: 'IT',
    latitude: 41.9028,
    longitude: 12.4964,
  ),
);

class _FakeShopRepository implements ShopRepository {
  int updateCalls = 0;
  String? lastPlaceId;

  @override
  Future<ApiResult<List<PlaceSuggestion>>> searchAddresses(
    String query,
  ) async => const ApiResult.success([_suggestion]);

  @override
  Future<ApiResult<Shop>> updateShop({
    String? name,
    String? phone,
    String? placeId,
    OpeningHours? openingHours,
    List<String>? closures,
  }) async {
    updateCalls++;
    lastPlaceId = placeId;
    return const ApiResult.success(_resolved);
  }

  @override
  Future<ApiResult<Shop?>> getMyShop() async =>
      const ApiResult.success(_resolved);

  int uploadCalls = 0;
  int removeCalls = 0;
  NetworkException? uploadFails;

  @override
  Future<ApiResult<Shop>> uploadPhoto({
    required String filePath,
    required String contentType,
  }) async {
    uploadCalls++;
    lastContentType = contentType;
    final failure = uploadFails;
    if (failure != null) return ApiResult.failure(failure);
    return const ApiResult.success(_withPhoto);
  }

  @override
  Future<ApiResult<Shop>> removePhoto() async {
    removeCalls++;
    return const ApiResult.success(_resolved);
  }

  String? lastContentType;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  _photoFlow();

  late _FakeShopRepository shops;
  late ShopSetupCubit cubit;

  setUp(() async {
    shops = _FakeShopRepository();
    cubit = ShopSetupCubit(shops, startAt: ShopSetupStep.address);
    await cubit.start();
  });

  tearDown(() => cubit.close());

  test('choosing a suggestion clears the list', () async {
    cubit.searchAddresses('Via dei Coronari');
    await Future<void>.delayed(const Duration(milliseconds: 450));
    expect(cubit.state.suggestions, isNotEmpty);

    await cubit.chooseAddress('p1');

    expect(cubit.state.suggestions, isEmpty);
    expect(cubit.state.isSearching, isFalse);
  });

  test('choosing a suggestion keeps the owner on the address step', () async {
    await cubit.chooseAddress('p1');

    expect(cubit.state.step, ShopSetupStep.address);
    expect(shops.lastPlaceId, 'p1');
  });

  test(
    'the resolved coordinates land on the shop, so the map can draw',
    () async {
      await cubit.chooseAddress('p1');

      expect(cubit.state.shop?.address?.isGeocoded, isTrue);
      expect(cubit.state.shop?.address?.latitude, 41.9028);
    },
  );

  test('a second tap while saving is ignored', () async {
    final first = cubit.chooseAddress('p1');
    final second = cubit.chooseAddress('p2');
    await Future.wait([first, second]);

    expect(shops.updateCalls, 1);
    expect(shops.lastPlaceId, 'p1');
  });

  test('only Continue advances to the services step', () async {
    await cubit.chooseAddress('p1');
    expect(cubit.state.step, ShopSetupStep.address);

    cubit.goToServices();
    expect(cubit.state.step, ShopSetupStep.services);
  });
}

void _photoFlow() {
  group('photo', () {
    late _FakeShopRepository shops;
    late ShopSetupCubit cubit;

    setUp(() async {
      shops = _FakeShopRepository();
      cubit = ShopSetupCubit(shops, startAt: ShopSetupStep.shop);
      await cubit.start();
    });

    tearDown(() => cubit.close());

    test(
      'the picked file shows while it uploads, then the served one',
      () async {
        final pending = cubit.uploadPhoto(
          filePath: '/tmp/shop.jpg',
          contentType: 'image/jpeg',
        );

        expect(cubit.state.isUploadingPhoto, isTrue);
        expect(cubit.state.pendingPhotoPath, '/tmp/shop.jpg');

        await pending;

        expect(cubit.state.isUploadingPhoto, isFalse);
        expect(cubit.state.pendingPhotoPath, isNull);
        expect(cubit.state.shop?.photoUrl, isNotNull);
      },
    );

    // Clearing it would leave the owner staring at an empty panel wondering
    // what happened to the photo they just chose.
    test('a failed upload keeps the file on screen', () async {
      shops.uploadFails = const ServerError();

      await cubit.uploadPhoto(
        filePath: '/tmp/shop.jpg',
        contentType: 'image/jpeg',
      );

      expect(cubit.state.pendingPhotoPath, '/tmp/shop.jpg');
      expect(cubit.state.failure, isA<ServerError>());
      expect(cubit.state.isUploadingPhoto, isFalse);
    });

    test('a second upload while one runs is ignored', () async {
      final first = cubit.uploadPhoto(
        filePath: '/tmp/a.jpg',
        contentType: 'image/jpeg',
      );
      final second = cubit.uploadPhoto(
        filePath: '/tmp/b.jpg',
        contentType: 'image/jpeg',
      );
      await Future.wait([first, second]);

      expect(shops.uploadCalls, 1);
    });

    test('removing clears both the pending file and the served one', () async {
      await cubit.uploadPhoto(
        filePath: '/tmp/shop.jpg',
        contentType: 'image/jpeg',
      );
      expect(cubit.state.shop?.photoUrl, isNotNull);

      await cubit.removePhoto();

      expect(shops.removeCalls, 1);
      expect(cubit.state.shop?.photoUrl, isNull);
      expect(cubit.state.pendingPhotoPath, isNull);
    });

    test('the content type reaches the repository', () async {
      await cubit.uploadPhoto(
        filePath: '/tmp/shop.png',
        contentType: 'image/png',
      );
      expect(shops.lastContentType, 'image/png');
    });
  });
}
