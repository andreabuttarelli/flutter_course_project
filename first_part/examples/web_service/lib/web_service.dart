import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

class WebService {
  Future<void> start() async {
    final router = Router();

    router.get('/example', printExample);
    router.post('/ciao', printCiao);

    //final handler = Pipeline().addHandler(printCiao);

    final server = await io.serve(router.call, 'localhost', 8080);

    print('Serving at http://${server.address.host}:${server.port}');
  }
}

Response printCiao(Request request) {
  return Response.ok('Ciao');
}

Response printExample(Request request) {
  return Response.ok('Example');
}
