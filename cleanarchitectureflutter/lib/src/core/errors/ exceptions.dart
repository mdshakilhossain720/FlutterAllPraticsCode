class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({this.message = "Server Error", this.statusCode});
}

class CacheException implements Exception {
  final String message;
  CacheException({this.message = "Cache Error"});
}

class NetworkException implements Exception {
  final String message;
  NetworkException({this.message = "No Internet"});
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException({this.message = "Unauthorized"});
}

class ForbiddenException implements Exception {
  final String message;
  ForbiddenException({this.message = "Forbidden"});
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException({this.message = "Not Found"});
}

class UnknownException implements Exception {
  final String message;
  UnknownException({this.message = "Unknown Error"});
}
