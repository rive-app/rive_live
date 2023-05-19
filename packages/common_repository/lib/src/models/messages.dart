// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:common_repository/src/models/exceptions.dart';

enum MessageType {
  connect,
  connectViewer,
  event,
  connectedUsers,
  analytics,
  disconnect,
}

sealed class Message {
  final MessageType type;
  final String raw;

  Message(this.type, this.raw);

  factory Message.fromMap(Map<String, dynamic> map) {
    switch (map) {
      case {'type': final String type, 'raw': final String raw}:
        final typeConverted = MessageType.values.byName(type);
        switch (typeConverted) {
          case MessageType.connect:
            return MessageConnect(raw);
          case MessageType.connectViewer:
            return MessageConnectViewer();
          case MessageType.connectedUsers:
            return MessageConnectedUsers(
                List<String>.from(jsonDecode(raw) as List<dynamic>));
          case MessageType.event:
            return MessageEvent(Event.fromJson(raw));
          case MessageType.analytics:
            return MessageAnalytics(AnalyticCode.fromJson(raw));
          case MessageType.disconnect:
            return MessageDisconnect(raw);
        }
      default:
        throw MessageException('Invalid message format: $map');
    }
  }

  factory Message.fromJson(dynamic json) {
    try {
      return Message.fromMap(jsonDecode(json));
    } catch (_) {
      throw MessageException('Invalid message format: $json');
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'raw': raw,
    };
  }

  String toJson() => json.encode(toMap());
}

class MessageConnect extends Message {
  final String username;
  MessageConnect(this.username) : super(MessageType.connect, username);
}

class MessageConnectViewer extends Message {
  MessageConnectViewer() : super(MessageType.connectViewer, 'viewer');
}

class MessageEvent extends Message {
  final Event event;
  MessageEvent(this.event) : super(MessageType.event, event.toJson());
}

class MessageConnectedUsers extends Message {
  final List<String> connectedUsers;
  MessageConnectedUsers(this.connectedUsers)
      : super(MessageType.connectedUsers, jsonEncode(connectedUsers));

  MessageConnectedUsers copyWith({
    List<String>? connectedUsers,
  }) {
    return MessageConnectedUsers(
      connectedUsers ?? this.connectedUsers,
    );
  }
}

class MessageAnalytics extends Message {
  final AnalyticCode code;
  MessageAnalytics(this.code) : super(MessageType.analytics, code.toJson());
}

class MessageDisconnect extends Message {
  final String username;
  MessageDisconnect(this.username) : super(MessageType.disconnect, username);
}

class Event {
  Event(this.username, this.type);

  final String username;
  final String type;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'type': type,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) => Event(
        map['username'] as String,
        map['type'] as String,
      );

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum AnalyticCode {
  ping(99, 'Ping'),
  pong(100, 'Pong'),
  connected(101, 'Connected'),
  info(102, 'Not found'),
  userAlreadyExists(103, 'User already exists'),
  error(104, 'Error');

  const AnalyticCode(this.code, this.description);
  final int code;
  final String description;

  @override
  String toString() => 'StatusCode($code, $description)';

  static fromJson(String source) =>
      AnalyticCode.fromMap(json.decode(source) as Map<String, dynamic>);

  static fromMap(Map<String, dynamic> map) => byCode(map['code'] as int)!;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'description': description,
    };
  }

  String toJson() => json.encode(toMap());
}

// void something() {
//   const AnalyticCode(int)
// }

AnalyticCode? byCode(int code) {
  for (AnalyticCode element in AnalyticCode.values) {
    if (element.code == code) {
      return element;
    }
  }
  return null;
}
