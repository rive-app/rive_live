class MessageException implements Exception {
  MessageException(this.message);

  final String message;

  @override
  String toString() => message;
}
