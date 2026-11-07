import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/domain/models/shop.dart';
import 'package:booknow_mobile/domain/models/shop_summary.dart';
import 'package:booknow_mobile/domain/repositories/shop_directory_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A shop with the point to draw it at.
class ShopPin {
  const ShopPin({
    required this.shop,
    required this.latitude,
    required this.longitude,
  });

  final ShopSummary shop;
  final double latitude;
  final double longitude;
}

sealed class ShopMapState {
  const ShopMapState();
}

final class ShopMapLoading extends ShopMapState {
  const ShopMapLoading();
}

final class ShopMapLoaded extends ShopMapState {
  const ShopMapLoaded(this.pins);

  final List<ShopPin> pins;
}

final class ShopMapFailure extends ShopMapState {
  const ShopMapFailure(this.error);

  final NetworkException error;
}

/// The directory's shops, placed on a map.
///
/// The shop list carries no coordinates, so each one comes from the shop's own
/// page: one call per shop, capped by [_maxShops]. A list field on the API
/// would replace all of this with the single directory call.
class ShopMapCubit extends Cubit<ShopMapState> {
  ShopMapCubit(this._repository) : super(const ShopMapLoading());

  static const int _maxShops = 30;

  final ShopDirectoryRepository _repository;

  Future<void> load() async {
    emit(const ShopMapLoading());

    final result = await _repository.search();
    if (isClosed) return;

    switch (result) {
      case Failure<List<ShopSummary>>(:final error):
        emit(ShopMapFailure(error));
      case Success<List<ShopSummary>>(:final data):
        final pins = await Future.wait(data.take(_maxShops).map(_pinFor));
        if (isClosed) return;
        emit(ShopMapLoaded(pins.whereType<ShopPin>().toList()));
    }
  }

  /// Null for a shop with no point: it stays off the map, not off the app.
  Future<ShopPin?> _pinFor(ShopSummary shop) async {
    final result = await _repository.byId(shop.id);
    if (result is! Success<Shop>) return null;

    final address = result.data.address;
    final latitude = address?.latitude;
    final longitude = address?.longitude;
    if (latitude == null || longitude == null) return null;

    return ShopPin(shop: shop, latitude: latitude, longitude: longitude);
  }
}
