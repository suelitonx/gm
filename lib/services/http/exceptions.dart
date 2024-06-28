class NotFoundException implements Exception {
  final String message;
  NotFoundException({required this.message});
}

class ServerErrorException implements Exception {
  final String message;
  ServerErrorException({required this.message});
}
