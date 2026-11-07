import 'package:connectivity_plus/connectivity_plus.dart';

/// Whether the device currently has a network interface up.
///
/// This only says an interface exists — a captive portal or a dead uplink
/// still reports connected — so it is a fast pre-check to fail a request
/// early, never a guarantee the request will reach the API.
class NetworkInfo {
  NetworkInfo(this._connectivity);

  final Connectivity _connectivity;

  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return results.any((result) => result != ConnectivityResult.none);
  }

  Stream<bool> get onStatusChange => _connectivity.onConnectivityChanged.map(
    (results) => results.any((result) => result != ConnectivityResult.none),
  );
}
