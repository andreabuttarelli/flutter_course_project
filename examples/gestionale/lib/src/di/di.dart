import 'package:get_it/get_it.dart';

export 'di_unsupported.dart'
    if (dart.library.io) 'di_io.dart'
    if (dart.library.js_util) 'di_web.dart';

GetIt getIt = GetIt.instance;
