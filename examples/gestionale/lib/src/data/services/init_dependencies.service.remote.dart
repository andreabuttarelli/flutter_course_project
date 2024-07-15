import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gestionale/src/core/bloc_observer/bloc_observer.dart';
import 'package:gestionale/src/core/functions/check_connection.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class InitDependenciesServiceRemote {
  const InitDependenciesServiceRemote(this._connectionChecker);

  final ConnectionChecker _connectionChecker;

  Future<void> initDependencies() async {
    await _connectionChecker.checkConnection();
    Bloc.observer = AppBlocObserver();
    WidgetsFlutterBinding.ensureInitialized();
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory(),
    );
  }
}
