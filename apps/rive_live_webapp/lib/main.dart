import 'dart:async';
import 'dart:developer';

import 'package:common_repository/common_respository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:rive_live_webapp/theme.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData theme() {
    final colors = RiveColors();
    final baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: colors.blue,
        background: colors.grey1D,
        surface: colors.grey11,
      ),
      visualDensity: VisualDensity.compact,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  var _connectedUsers = <String>[];
  late WebSocketChannel _channel;
  late Timer _timer;

  void init() {
    try {
      connect();
    } on Exception {
      log('Could not establish connection, retrying in 3 seconds...');
      Future.delayed(const Duration(seconds: 3), () {
        try {
          connect();
        } on Exception catch (e, st) {
          log('Could not connect...', error: e, stackTrace: st);
        }
      });
    }
  }

  void reconnect() {
    log('Trying to reconnect...');
    try {
      _timer.cancel();
      _channel.sink.close();
      Future.delayed(const Duration(seconds: 2), () {
        try {
          log('Connecting...');
          connect();
        } on Exception catch (e, st) {
          log('Could not reconnect to server', error: e, stackTrace: st);
        }
      });
    } on Exception catch (e, st) {
      log('Could note dispose before connecting', error: e, stackTrace: st);
    }
  }

  void connect() {
    final uri = Uri.parse('${Constants.url}/ws');
    _channel = WebSocketChannel.connect(uri);

    _channel.ready.then((_) {
      _channel.sink.add(MessageConnectViewer().toJson());
    });

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _channel.sink.add(MessageAnalytics(AnalyticCode.ping).toJson());
    });

    _channel.stream.listen(
      (message) {
        try {
          final messageDecoded = Message.fromJson(message);
          switch (messageDecoded) {
            case MessageAnalytics m:
              debugPrint(m.raw);
              break;
            case MessageConnectedUsers m:
              debugPrint(m.connectedUsers.toString());
              setState(() {
                _connectedUsers = m.connectedUsers;
              });
              break;
            default:
              break;
          }
        } on Exception catch (e, st) {
          log('Could not decode message', error: e, stackTrace: st);
        }
      },
      onError: (e) {
        log('Disconnected, with error', error: e);
        reconnect();
      },
      onDone: () {
        log('Disconnected, on done');
        reconnect();
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rive Live'),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'Connected users',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Wrap(
              children: [
                ..._connectedUsers
                    .map(
                      (user) => UserPanel(username: user, channel: _channel),
                    )
                    .toList()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserPanel extends StatelessWidget {
  const UserPanel({
    super.key,
    required this.username,
    required this.channel,
  });

  final String username;
  final WebSocketChannel channel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 340,
          child: Column(
            children: [
              Text(
                username,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    channel.sink.add(
                      MessageEvent(
                        Event(username, 'special'),
                      ).toJson(),
                    );
                  },
                  child: const Text('Special animation'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReactionButton(
                      reaction: Reaction.love,
                      onTap: () {
                        channel.sink.add(
                          MessageEvent(
                            Event(username, Reaction.love.name),
                          ).toJson(),
                        );
                      },
                    ),
                    ReactionButton(
                      reaction: Reaction.joy,
                      onTap: () {
                        channel.sink.add(
                          MessageEvent(
                            Event(username, Reaction.joy.name),
                          ).toJson(),
                        );
                      },
                    ),
                    ReactionButton(
                      reaction: Reaction.mindblown,
                      onTap: () {
                        channel.sink.add(
                          MessageEvent(
                            Event(username, Reaction.mindblown.name),
                          ).toJson(),
                        );
                      },
                    ),
                    ReactionButton(
                      reaction: Reaction.tada,
                      onTap: () {
                        channel.sink.add(
                          MessageEvent(
                            Event(username, Reaction.tada.name),
                          ).toJson(),
                        );
                      },
                    ),
                    ReactionButton(
                      reaction: Reaction.fire,
                      onTap: () {
                        channel.sink.add(
                          MessageEvent(
                            Event(username, Reaction.fire.name),
                          ).toJson(),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReactionButton extends StatefulWidget {
  const ReactionButton({
    super.key,
    required this.reaction,
    required this.onTap,
  });

  final Reaction reaction;
  final VoidCallback onTap;

  @override
  State<ReactionButton> createState() => _ReactionButtonState();
}

class _ReactionButtonState extends State<ReactionButton> {
  double size = 50;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Listener(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (event) {
            setState(() {
              size = 60;
            });
          },
          onExit: (event) {
            setState(() {
              size = 50;
            });
          },
          child: Center(
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: size,
                height: size,
                child: Center(
                  child: RiveAnimation.asset(
                    'assets/rive_animated_emojis.riv',
                    artboard: widget.reaction.artboard,
                    stateMachines: const ['controller'],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
