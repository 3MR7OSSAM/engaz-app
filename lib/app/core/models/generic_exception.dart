import 'package:fpdart/fpdart.dart';

/// Parent exception class that can only be inherited and not instantiated.
sealed class GenericException implements Exception {

  const GenericException({
    required this.code,
    this.message,
  });
  final String code;
  final String? message;
}

/// Short for [Either<GenericException, T>]
typedef EitherException<T> = Either<GenericException, T>;

/// Business Exception.
class BusinessException extends GenericException {
  // here you can extend attributes and methods as needed.
  const BusinessException({
    required super.code,
    super.message,
  });

  factory BusinessException.unkown() => const BusinessException(code: 'unkown');
}

/// Exception caused by network related issues.
class NetworkException extends GenericException {

  const NetworkException({
    required super.code,
    super.message,
    this.type = NetworkExceptionType.unKnown,
  });

  factory NetworkException.unkown() => const NetworkException(code: 'unkown');
  // here you can extend attributes and methods as needed.
  final NetworkExceptionType type;
}

/// HTTP exceptions with status codes.
enum NetworkExceptionType {
  badRequest(400),
  unAuthorized(401),
  notFound(404),
  serverError(500),
  timeout(599),
  unKnown(0);
  const NetworkExceptionType(this.httpStatusCode);

  final int httpStatusCode;
}
