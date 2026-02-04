import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';

class ApiService {
  late final http.Client _client;
  String _baseUrl = ApiConstants.baseUrl;
  Duration _timeout = const Duration(seconds: 30);
  final Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  ApiService() {
    _client = http.Client();
  }
  
  void dispose() {
    _client.close();
  }
  
  // GET request
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(endpoint, query);
      final requestHeaders = {..._defaultHeaders, ...?headers};
      
      // Add authorization header if token exists
      final token = await _getAuthToken();
      if (token != null && token.isNotEmpty) {
        requestHeaders['Authorization'] = 'Bearer $token';
      }
      
      final response = await _client
          .get(uri, headers: requestHeaders)
          .timeout(_timeout);
      
      return _handleResponse<T>(response);
    } catch (e) {
      return _handleError<T>(e);
    }
  }
  
  // POST request
  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    dynamic body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(endpoint, query);
      final requestHeaders = {..._defaultHeaders, ...?headers};
      
      // Add authorization header if token exists
      final token = await _getAuthToken();
      if (token != null && token.isNotEmpty) {
        requestHeaders['Authorization'] = 'Bearer $token';
      }
      
      final response = await _client
          .post(
            uri,
            headers: requestHeaders,
            body: body is Map ? json.encode(body) : body.toString(),
          )
          .timeout(_timeout);
      
      return _handleResponse<T>(response);
    } catch (e) {
      return _handleError<T>(e);
    }
  }
  
  // PUT request
  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    dynamic body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(endpoint, query);
      final requestHeaders = {..._defaultHeaders, ...?headers};
      
      // Add authorization header if token exists
      final token = await _getAuthToken();
      if (token != null && token.isNotEmpty) {
        requestHeaders['Authorization'] = 'Bearer $token';
      }
      
      final response = await _client
          .put(
            uri,
            headers: requestHeaders,
            body: body is Map ? json.encode(body) : body.toString(),
          )
          .timeout(_timeout);
      
      return _handleResponse<T>(response);
    } catch (e) {
      return _handleError<T>(e);
    }
  }
  
  // PATCH request
  Future<ApiResponse<T>> patch<T>(
    String endpoint, {
    dynamic body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(endpoint, query);
      final requestHeaders = {..._defaultHeaders, ...?headers};
      
      // Add authorization header if token exists
      final token = await _getAuthToken();
      if (token != null && token.isNotEmpty) {
        requestHeaders['Authorization'] = 'Bearer $token';
      }
      
      final response = await _client
          .patch(
            uri,
            headers: requestHeaders,
            body: body is Map ? json.encode(body) : body.toString(),
          )
          .timeout(_timeout);
      
      return _handleResponse<T>(response);
    } catch (e) {
      return _handleError<T>(e);
    }
  }
  
  // DELETE request
  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(endpoint, query);
      final requestHeaders = {..._defaultHeaders, ...?headers};
      
      // Add authorization header if token exists
      final token = await _getAuthToken();
      if (token != null && token.isNotEmpty) {
        requestHeaders['Authorization'] = 'Bearer $token';
      }
      
      final response = await _client
          .delete(uri, headers: requestHeaders)
          .timeout(_timeout);
      
      return _handleResponse<T>(response);
    } catch (e) {
      return _handleError<T>(e);
    }
  }
  
  // Build URI with query parameters
  Uri _buildUri(String endpoint, Map<String, dynamic>? query) {
    final uri = Uri.parse('$_baseUrl$endpoint');
    
    if (query != null) {
      final queryParams = <String, String>{};
      query.forEach((key, value) {
        if (value != null) {
          queryParams[key] = value.toString();
        }
      });
      return uri.replace(queryParameters: queryParams);
    }
    
    return uri;
  }
  
  // Handle response
  ApiResponse<T> _handleResponse<T>(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        final data = json.decode(response.body);
        return ApiResponse<T>.success(
          data: data,
          message: _getSuccessMessage(response),
          statusCode: response.statusCode,
        );
      } catch (e) {
        return ApiResponse<T>.success(
          data: response.body as T?,
          message: _getSuccessMessage(response),
          statusCode: response.statusCode,
        );
      }
    } else {
      return ApiResponse<T>.error(
        message: _getErrorMessage(response),
        statusCode: response.statusCode,
        data: response.body,
      );
    }
  }
  
  // Handle error
  ApiResponse<T> _handleError<T>(dynamic error) {
    String message = 'An unexpected error occurred';
    
    if (error is http.ClientException) {
      message = 'Network error: ${error.message}';
    } else if (error is SocketException) {
      message = 'Connection error: ${error.message}';
    } else if (error.toString().contains('TimeoutException')) {
      message = 'Request timeout';
    } else if (error is Exception) {
      message = error.toString();
    }
    
    return ApiResponse<T>.error(
      message: message,
      statusCode: 0,
      data: null,
    );
  }
  
  // Get error message from response
  String _getErrorMessage(http.Response response) {
    try {
      final body = json.decode(response.body);
      if (body is Map) {
        return body['message'] ?? 
               body['error'] ?? 
               body['msg'] ?? 
               'Request failed with status ${response.statusCode}';
      }
    } catch (e) {
      // If JSON parsing fails, return the raw body
    }
    return 'Request failed with status ${response.statusCode}';
  }
  
  // Get success message from response
  String _getSuccessMessage(http.Response response) {
    try {
      final body = json.decode(response.body);
      if (body is Map) {
        return body['message'] ?? 
               body['msg'] ?? 
               'Request completed successfully';
      }
    } catch (e) {
      // If JSON parsing fails, return default message
    }
    return 'Request completed successfully';
  }
  
  // Get auth token
  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
  
  // Set base URL
  void setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }
  
  // Set timeout
  void setTimeout(Duration timeout) {
    _timeout = timeout;
  }
  
  // Add default header
  void addDefaultHeader(String key, String value) {
    _defaultHeaders[key] = value;
  }
  
  // Remove default header
  void removeDefaultHeader(String key) {
    _defaultHeaders.remove(key);
  }
  
  // Clear all default headers
  void clearDefaultHeaders() {
    _defaultHeaders.clear();
    _defaultHeaders.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
  }
}

// API Response wrapper
class ApiResponse<T> {
  final T? data;
  final String message;
  final int statusCode;
  final bool isSuccess;
  final dynamic rawData;
  
  ApiResponse._({
    required this.data,
    required this.message,
    required this.statusCode,
    required this.isSuccess,
    this.rawData,
  });
  
  factory ApiResponse.success({
    T? data,
    String? message,
    int? statusCode,
    dynamic rawData,
  }) {
    return ApiResponse._(
      data: data,
      message: message ?? 'Success',
      statusCode: statusCode ?? 200,
      isSuccess: true,
      rawData: rawData,
    );
  }
  
  factory ApiResponse.error({
    String? message,
    int? statusCode,
    dynamic data,
  }) {
    return ApiResponse._(
      data: null,
      message: message ?? 'Error occurred',
      statusCode: statusCode ?? 500,
      isSuccess: false,
      rawData: data,
    );
  }
  
  // Helper methods
  bool get hasData => data != null;
  bool get hasError => !isSuccess;
  
  // Convert response to specific type
  R? as<R>() {
    if (data is R) {
      return data as R;
    }
    return null;
  }
  
  // Get data with fallback
  T? getDataOr(T? fallback) {
    return hasData ? data : fallback;
  }
  
  // Get message with fallback
  String getMessageOr(String fallback) {
    return message.isNotEmpty ? message : fallback;
  }
} 