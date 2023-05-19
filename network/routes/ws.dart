import 'dart:developer';

import 'package:common_repository/common_respository.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:rive_livestream_server/connected_users/cubit/connected_users_cubit.dart';

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler(
    (channel, protocol) {
      // Send a message to the client.
      channel.sink.add(MessageAnalytics(AnalyticCode.ping).toJson());

      // Listen for messages from the client.
      channel.stream.listen(
        (data) {
          final message = Message.fromJson(
            data,
          );
          switch (message) {
            case MessageConnectViewer _:
              final cubit = context.read<ConnectedUsersCubit>();
              cubit.subscribe(channel);
              channel.sink
                  .add(MessageAnalytics(AnalyticCode.connected).toJson());
              channel.sink.add(cubit.state.toJson());
            case MessageConnect m:
              log('Client connected message, username: ${m.raw}');
              final cubit = context.read<ConnectedUsersCubit>();

              channel.sink
                  .add(MessageAnalytics(AnalyticCode.connected).toJson());
              cubit.subscribeUser(m.username, channel);

            case MessageEvent m:
              final user =
                  context.read<ConnectedUsersCubit>().user(m.event.username);
              if (user != null) {
                user.sink.add(MessageEvent(m.event).toJson());
              }
              log('Client event message: ${m.raw}');
            case MessageDisconnect m:
              final cubit = context.read<ConnectedUsersCubit>();
              final userChannel = cubit.user(m.username);
              if (userChannel != null && userChannel == channel) {
                cubit.unsubscribe(channel);
                log('Client disconnect message, username: ${m.raw}');
              }
            case MessageAnalytics m:
              if (m.code == AnalyticCode.ping) {
                channel.sink.add(MessageAnalytics(AnalyticCode.pong).toJson());
              }
            default:
              break;
          }
        },
        // The client has disconnected.
        onDone: () {
          context.read<ConnectedUsersCubit>().unsubscribe(channel);
        },
        onError: (e) {
          context.read<ConnectedUsersCubit>().unsubscribe(channel);
        },
      );
    },
  );

  return handler(context);
}
