class AppException implements Exception {
  final String _message;
  StackTrace stackTrace;

  AppException(this._message, {required this.stackTrace});

  String get message => _message.replaceFirst('Exception: ', '');
}
