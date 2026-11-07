import 'package:booknow_mobile/core/error/api_result.dart';
import 'package:booknow_mobile/core/error/network_exception.dart';
import 'package:booknow_mobile/domain/models/shop_summary.dart';
import 'package:booknow_mobile/domain/repositories/shop_directory_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class ShopSearchState {
  const ShopSearchState();
}

final class ShopSearchLoading extends ShopSearchState {
  const ShopSearchLoading();
}

final class ShopSearchLoaded extends ShopSearchState {
  const ShopSearchLoaded(this.shops);

  final List<ShopSummary> shops;
}

final class ShopSearchFailure extends ShopSearchState {
  const ShopSearchFailure(this.error);

  final NetworkException error;
}

/// The shop directory, narrowed by what the customer typed.
class ShopSearchCubit extends Cubit<ShopSearchState> {
  ShopSearchCubit(this._repository) : super(const ShopSearchLoading());

  final ShopDirectoryRepository _repository;
  int _latest = 0;

  Future<void> search(String query) async {
    final text = query.trim();
    final ticket = ++_latest;

    emit(const ShopSearchLoading());
    final result = await _repository.search(query: text.isEmpty ? null : text);
    // A slower answer to an older query must not replace a newer one.
    if (isClosed || ticket != _latest) return;

    switch (result) {
      case Success<List<ShopSummary>>(:final data):
        emit(ShopSearchLoaded(_matching(data, text.toLowerCase())));
      case Failure<List<ShopSummary>>(:final error):
        emit(ShopSearchFailure(error));
    }
  }

  List<ShopSummary> _matching(List<ShopSummary> shops, String text) {
    if (text.isEmpty) return shops;

    return shops
        .where(
          (shop) => [
            shop.name,
            shop.addressLine,
            shop.city,
          ].any((field) => field?.toLowerCase().contains(text) ?? false),
        )
        .toList();
  }
}
