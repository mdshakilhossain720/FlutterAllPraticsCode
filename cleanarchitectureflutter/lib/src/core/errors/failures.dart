abstract class Failure {
  final String message;
  const Failure(this.message);
}

// When API returns error (4xx, 5xx)
class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(String msg, {this.statusCode}) : super(msg);
}

// When no internet connection
class NetworkFailure extends Failure {
  const NetworkFailure(String msg) : super(msg);
}

// When authentication fails (401)
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(String msg) : super(msg);
}

// When user doesn't have permission (403)
class ForbiddenFailure extends Failure {
  const ForbiddenFailure(String msg) : super(msg);
}

// 404 cases
class NotFoundFailure extends Failure {
  const NotFoundFailure(String msg) : super(msg);
}

// Cache Errors (Hive/local DB)
class CacheFailure extends Failure {
  const CacheFailure(String msg) : super(msg);
}

// Unknown fallback
class UnknownFailure extends Failure {
  const UnknownFailure(String msg) : super(msg);
}

// For validation errors (form fields)
class ValidationFailure extends Failure {
  final Map<String, dynamic>? fieldErrors;
  const ValidationFailure(String msg, {this.fieldErrors}) : super(msg);
}
