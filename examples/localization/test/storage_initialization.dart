import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_storage.dart';

void storageInitialization() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final storage = MockStorage();
  when(
    () => storage.write(any(), any<dynamic>()),
  ).thenAnswer((_) async {
    return;
  });
  HydratedBloc.storage = storage;
}
