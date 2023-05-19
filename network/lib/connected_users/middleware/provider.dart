import 'package:dart_frog/dart_frog.dart';

import '../cubit/connected_users_cubit.dart';

final _counter = ConnectedUsersCubit();

// Provide the counter instance via `RequestContext`.
final counterProvider = provider<ConnectedUsersCubit>((_) => _counter);
