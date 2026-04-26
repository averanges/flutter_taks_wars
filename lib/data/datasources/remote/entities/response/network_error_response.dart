import 'package:flutter_soft_wars/core/utils/exceptions/network_error.dart';
import 'package:json_annotation/json_annotation.dart';

part 'network_error_response.g.dart';

@JsonSerializable()
class NetworkErrorResponse {
  NetworkErrorResponse({required this.error});

  factory NetworkErrorResponse.fromJson(Map<String, dynamic> json) => _$NetworkErrorResponseFromJson(json);

  final String? error;

  Map<String, dynamic> toJson() => _$NetworkErrorResponseToJson(this);

  NetworkError toDomain() {
    return NetworkError(error: error ?? '');
  }
}
