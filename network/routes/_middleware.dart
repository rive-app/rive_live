import 'package:dart_frog/dart_frog.dart';
import 'package:rive_livestream_server/connected_users/middleware/provider.dart';

Handler middleware(Handler handler) => handler.use(counterProvider);
