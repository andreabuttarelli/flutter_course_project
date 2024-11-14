import 'package:gestionale/src/core/functions/check_connection.dart';

class InitDependenciesServiceTest {
  const InitDependenciesServiceTest(this._connectionChecker,
      {this.shouldThrowException = false});

  final ConnectionChecker _connectionChecker;
  final bool shouldThrowException;

  Future<void> initDependencies() async {
    if (shouldThrowException) {
      throw Exception('Error');
    }
    await _connectionChecker.checkConnection();
  }
}
