import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logger/web.dart';

class ConnectionChecker {
  const ConnectionChecker(this._logger);
  final Logger _logger;
  Future<void> checkConnection() async {
    /*if (Platform.environment.containsKey('FLUTTER_TEST')) {
      _logger.i('Test connection');
      return;
    }*/
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      _logger.i('Mobile connection');
      return;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      _logger.i('Wifi connection');
      return;
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      _logger.i('VPN connection');
      return;
    }

    throw Exception('No internet connection');
  }
}
