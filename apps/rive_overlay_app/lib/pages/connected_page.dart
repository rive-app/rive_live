import 'dart:async';
import 'dart:math';

import 'package:common_repository/common_respository.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:rive_overlay_app/models/animations_data.dart';
import 'package:rive_overlay_app/utils.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// This is the page that is shown when the user is connected to the server.
///
/// Here we listen for messages from the server and display animations based
/// on the messages received.
class ConnectedPage extends StatefulWidget {
  const ConnectedPage({
    super.key,
    required this.channel,
    required this.username,
  });

  final WebSocketChannel channel;
  final String username;

  @override
  State<ConnectedPage> createState() => _ConnectedPageState();
}

class _ConnectedPageState extends State<ConnectedPage> {
  AnimationData? _animationData;
  StateMachineController? _stateMachineController;
  SMITrigger? _trigger;

  bool _showBorder = true;
  bool _hasDisconnected = false;

  final ReactionController _reactionController = ReactionController();
  late Timer _timer;
  late WebSocketChannel _channel = widget.channel;

  @override
  void initState() {
    super.initState();

    _setupAnimations();
    _setupMessageListener();
  }

  @override
  void dispose() {
    _disconnect();
    _stateMachineController?.dispose();
    _timer.cancel();
    super.dispose();
  }

  Future<void> _setupAnimations() async {
    final isar = context.read<Isar>();
    _animationData = await isar.animationDatas.get(1);
    setState(() {});
  }

  /// Triggers the animation configured by the user.
  void _triggerAnimation() {
    _trigger?.value = true;
  }

  /// Triggers one of the Rive reaction animations.
  void _triggerReaction(Reaction reaction) {
    _reactionController.addReaction?.call(reaction);
  }

  /// Display/Hide the border around the animation area.
  ///
  /// The border can be used to setup a livestream and configure the viewable
  /// area correctly.
  void _showHideBorder() {
    setState(() {
      _showBorder = !_showBorder;
    });
  }

  void _setupMessageListener() {
    // Ping the server every 5 seconds to keep the connection alive.
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _channel.sink.add(MessageAnalytics(AnalyticCode.ping).toJson());
    });

    // Listen for incoming messages from the server.
    _channel.stream.listen(
      (message) {
        try {
          final messageDecoded = Message.fromJson(message);
          switch (messageDecoded) {
            case MessageConnect m:
              debugPrint('Server connect message, username: ${m.raw}');
            case MessageConnectedUsers m:
              debugPrint('Server connected users message: ${m.connectedUsers}');
            case MessageEvent m:
              debugPrint(m.event.type);
              // Check to see if the predefined animation exists
              try {
                final reaction = Reaction.values.byName(m.event.type);
                _triggerReaction(reaction);
                break;
              } catch (_) {
                // If the predefined animation does not exist,
                // trigger the unique animation
                _triggerAnimation();
              }
            case MessageAnalytics m:
              switch (m.code) {
                case AnalyticCode.userAlreadyExists:
                  Utils.showMessage(context, 'This user is already connected');
                  _disconnect();
                  Navigator.of(context).pop();
                case AnalyticCode.connected:
                  Utils.showMessage(context, 'You\'re connected!');
                case AnalyticCode.ping:
                case AnalyticCode.pong:
                case AnalyticCode.info:
                case AnalyticCode.error:
                  debugPrint(m.raw);
              }
            case MessageDisconnect m:
              debugPrint('Server disconnect message, username: ${m.raw}');
            case MessageConnectViewer _:
              break;
          }
        } on MessageException catch (_) {
          debugPrint('Could not decode message: $message');
        } catch (e) {
          debugPrint('Something else went wrong: $e');
        }
      },
      onError: (error) {
        debugPrint('Error: $error');
        Utils.showMessage(context, 'Error: $error');
      },
      onDone: () {
        debugPrint('Connection closed');
        _reconnect();
      },
    );
  }

  void _reconnect() {
    // User triggered disconnect. Do not try to reconnect.
    if (_hasDisconnected) return;

    _timer.cancel();
    _channel.sink.close();

    try {
      final uri = Uri.parse('${Constants.url}/ws');
      _channel = IOWebSocketChannel.connect(uri,
          pingInterval: const Duration(seconds: 5));
      _channel.sink.add(MessageConnect(widget.username).toJson());
      _setupMessageListener();
    } on Exception {
      Utils.showMessage(context, 'Connection failed. Could not reconnect');
    }
  }

  void _disconnect() {
    _hasDisconnected = true;
    _timer.cancel();

    _channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Utils.showMessage(context, 'Disconnected');
        _disconnect();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text('Connected as: ${widget.username}'),
          actions: [
            ElevatedButton(
              onPressed: () {
                _showHideBorder();
              },
              child: _showBorder
                  ? const Text('Hide border')
                  : const Text('Show border'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                _triggerAnimation();
              },
              child: const Text('Demo animation'),
            ),
            ElevatedButton(
              onPressed: () {
                const values = Reaction.values;
                final random = Random();
                final value = values[random.nextInt(values.length)];
                _triggerReaction(value);
              },
              child: const Text('Demo reaction'),
            ),
            IconButton(
              onPressed: () {
                _disconnect();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: Center(
          child: (_animationData == null)
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: _showBorder
                            ? Border.all(color: Colors.white)
                            : null),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Stack(
                        children: [
                          RiveAnimation.file(
                            _animationData!.path!,
                            artboard: _animationData?.artboard,
                            onInit: (artboard) {
                              if (_animationData?.isConfigured ?? false) {
                                _stateMachineController =
                                    StateMachineController.fromArtboard(
                                        artboard,
                                        _animationData!.stateMachine!);
                                if (_stateMachineController != null) {
                                  artboard
                                      .addController(_stateMachineController!);
                                  _trigger =
                                      _stateMachineController?.findInput<bool>(
                                              _animationData!.trigger!)
                                          as SMITrigger;
                                  _trigger?.value = false;
                                  return;
                                }
                              }

                              Utils.showMessage(context,
                                  'Your animation is not configured correctly');
                            },
                          ),
                          SizedBox.expand(
                            child: ReactionManager(
                              controller: _reactionController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

typedef ReactionCallback = void Function(Reaction);

class ReactionController {
  ReactionCallback? addReaction;
}

/// Manages all of the reactions that are currently being displayed.
///
/// Reactions can be added with the [ReactionController].
class ReactionManager extends StatefulWidget {
  const ReactionManager({
    super.key,
    required this.controller,
  });

  final ReactionController controller;

  @override
  State<ReactionManager> createState() => _ReactionManagerState();
}

class _ReactionManagerState extends State<ReactionManager> {
  @override
  void initState() {
    super.initState();
    widget.controller.addReaction = addParticle;
  }

  Size _biggest = Size.zero;

  final List<ReactionLayover> _particles = [];

  void addParticle(Reaction reaction) {
    if (_particles.length > 50) {
      return;
    }
    final widget = ReactionLayover(
      key: UniqueKey(),
      reaction: reaction,
      biggest: _biggest,
    );
    _particles.add(widget);
    if (mounted) {
      setState(() {});
    }

    Future.delayed(const Duration(seconds: 6), () {
      _particles.remove(widget);
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _biggest = constraints.biggest;
        return Stack(
          children: _particles,
        );
      },
    );
  }
}

/// Individual reaction that is animated on the screen.
class ReactionLayover extends StatefulWidget {
  const ReactionLayover({
    super.key,
    required this.biggest,
    required this.reaction,
  });

  final Size biggest;
  final Reaction reaction;

  @override
  State<ReactionLayover> createState() => _ReactionLayoverState();
}

class _ReactionLayoverState extends State<ReactionLayover>
    with SingleTickerProviderStateMixin {
  late final _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 5));

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final Random _rand = Random();
  late double startSize = 50 + _rand.nextDouble() * 250;
  late double endSize = 50 + _rand.nextDouble() * 100;

  @override
  Widget build(BuildContext context) {
    final biggest = widget.biggest;
    return PositionedTransition(
      rect: RelativeRectTween(
        begin: RelativeRect.fromSize(
          Rect.fromLTWH(_rand.nextDouble() * biggest.width, biggest.height,
              startSize, startSize),
          biggest,
        ),
        end: RelativeRect.fromSize(
            Rect.fromLTWH(_rand.nextDouble() * biggest.width, 0 - endSize,
                endSize, endSize),
            biggest),
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOut,
        ),
      ),
      child: RiveAnimation.asset(
        'assets/rive_animated_emojis.riv',
        fit: BoxFit.contain,
        artboard: widget.reaction.artboard,
        stateMachines: const ['controller'],
      ),
    );
  }
}
