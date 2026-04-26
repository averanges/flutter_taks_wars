import 'package:equatable/equatable.dart';

import 'package:flutter_soft_wars/core/utils/exceptions/network_error.dart';

class ApiException extends Equatable implements Exception {
  const ApiException({required this.networkError, required this.stackTrace});

  final NetworkError networkError;
  final StackTrace stackTrace;

  @override
  List<Object?> get props => [networkError, stackTrace];

  @override
  bool get stringify => true;
}
