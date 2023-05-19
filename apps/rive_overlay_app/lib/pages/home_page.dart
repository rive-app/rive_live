import 'package:common_repository/common_respository.dart';
import 'package:flutter/material.dart';
import 'package:rive_overlay_app/pages/animation_config_page.dart';
import 'package:rive_overlay_app/pages/connected_page.dart';
import 'package:rive_overlay_app/theme.dart';
import 'package:web_socket_channel/io.dart';

/// Home page of the app.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _connect() {
    if (_formKey.currentState!.validate()) {
      final uri = Uri.parse('${Constants.url}/ws');
      final channel = IOWebSocketChannel.connect(
        uri,
        pingInterval: const Duration(seconds: 5),
      );
      channel.ready.then(
        (_) {
          channel.sink.add(MessageConnect(controller.text).toJson());
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ConnectedPage(
                channel: channel,
                username: controller.text,
              ),
            ),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rive Live'),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Center(
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: controller,
                      onFieldSubmitted: (value) => _connect(),
                      validator: (value) => value!.isEmpty
                          ? 'A unique username is required.'
                          : null,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: _connect, child: const Text('Connect')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Connect to the server',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: RiveColors().grey88),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: SizedBox(
                width: 500,
                child: Divider(
                  color: RiveColors().grey88,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AnimationConfigPage(),
                      ),
                    );
                  },
                  child: const Text('Setup my animation')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Setup and configure your animation',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: RiveColors().grey88),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
