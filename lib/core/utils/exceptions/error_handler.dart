import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_soft_wars/core/utils/exceptions/api_exception.dart';
import 'package:flutter_soft_wars/data/datasources/remote/entities/response/network_error_response.dart';
import 'package:flutter_soft_wars/core/utils/exceptions/network_error.dart';

class ErrorHandler {
  const ErrorHandler._();

  static Never handle({required Object error, required StackTrace stackTrace}) {
    if (error is ApiException) {
      throw error;
    }

    if (error is DioException) {
      _handleDioException(error);
    }

    if (error is SocketException || error is HandshakeException) {
      throw ApiException(
        networkError: const NetworkError(error: 'no_internet'),
        stackTrace: stackTrace,
      );
    }

    throw ApiException(
      networkError: const NetworkError(error: 'unknown'),
      stackTrace: stackTrace,
    );
  }

  static Never _handleDioException(DioException error) {
    NetworkError networkError = const NetworkError(error: 'network');

    try {
      if (error.response?.data != null) {
        final data = error.response?.data;

        if (data is Map<String, dynamic>) {
          final parsed = NetworkErrorResponse.fromJson(data).toDomain();
          networkError = parsed;
        }
      }
    } catch (_) {
      networkError = NetworkError(error: error.response?.statusCode.toString() ?? 'parse_error');
    }

    throw ApiException(networkError: networkError, stackTrace: error.stackTrace);
  }
}
