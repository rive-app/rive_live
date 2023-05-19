/// Environment variables and shared app constants.
abstract class Constants {
  static const String url = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'ws://localhost:8080',
  );
}
