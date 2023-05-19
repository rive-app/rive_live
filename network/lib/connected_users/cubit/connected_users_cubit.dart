import 'package:broadcast_bloc/broadcast_bloc.dart';
import 'package:common_repository/common_respository.dart';
import 'package:stream_channel/stream_channel.dart';

class ConnectedUsersCubit extends BroadcastCubit<MessageConnectedUsers> {
  ConnectedUsersCubit() : super(MessageConnectedUsers([]));

  final _users = <String, StreamChannel>{};

  @override
  Object toMessage(MessageConnectedUsers state) => state.toJson();

  StreamChannel? user(String username) => _users[username];

  void subscribeUser(String username, StreamChannel channel) {
    if (_users.containsKey(username)) {
      _users.remove(username);
    }

    _users.addAll({username: channel});
    subscribe(channel);
    emit(
      state.copyWith(connectedUsers: _users.keys.toList()),
    );
  }

  @override
  void unsubscribe(StreamChannel channel) {
    _users.removeWhere((key, value) {
      if (value == channel) {
        emit(
          state.copyWith(
            connectedUsers:
                state.connectedUsers.where((user) => user != key).toList(),
          ),
        );
        return true;
      } else {
        return false;
      }
    });
    super.unsubscribe(channel);
  }
}
