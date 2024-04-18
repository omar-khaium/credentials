import 'dart:convert';
import 'dart:io';

import 'package:credentials/core/shared/error/failure/failure.dart';
import 'package:http/http.dart';

class NetworkResponse<T> {
  final bool success;
  final String? error;
  final T? result;

  NetworkResponse({
    required this.success,
    required this.error,
    required this.result,
  });

  factory NetworkResponse.parse({
    required Response response,
    bool raw = false,
  }) {
    if (response.statusCode != HttpStatus.ok) {
      if (response.statusCode == HttpStatus.unauthorized) {
        throw UnauthorizedFailure();
      }
      final Map<String, dynamic> payload = json.decode(response.body);
      final String error = payload['error'] ?? payload['message'] ?? 'Unknown error';
      return NetworkResponse._error(error: error);
    }
    final Map<String, dynamic> payload = json.decode(response.body);

    final bool success = (payload['success'] ?? payload['result']) as bool;
    final String? error = (payload['error'] ?? payload['message']) as String?;
    final T? result = (raw ? payload : payload['result']) as T?;

    if (success) {
      return NetworkResponse._success(result: result);
    } else {
      assert(
        error != null,
        'Error message is required',
      );
      return NetworkResponse._error(error: error!);
    }
  }

  factory NetworkResponse._error({
    required String error,
  }) {
    return NetworkResponse<T>(
      success: false,
      error: error,
      result: null,
    );
  }

  factory NetworkResponse._success({
    required T? result,
  }) {
    return NetworkResponse<T>(
      success: true,
      error: null,
      result: result,
    );
  }
}
