import 'dart:convert';
import 'dart:io';

import 'package:blog_frontend/file_exporter.dart';
import 'package:blog_frontend/models/error_response_model.dart';
import 'package:http/http.dart' as http;

class ApiRequest {
  final String baseUrl;
  final String scheme;

  ApiRequest({
    required this.baseUrl,
    this.scheme = 'http',
  });
  final log = getLogger("ApiRequest");
  Future<http.Response> response(
    String path,
    ApiType type, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    Object? body,
  }) async {
    switch (type) {
      case ApiType.get:
        return await http.get(
          Uri(
            host: baseUrl,
            scheme: scheme,
            path: path,
            queryParameters: queryParams,
          ),
          headers: headers,
        );
      case ApiType.post:
        return await http.post(
          Uri(
            host: baseUrl,
            scheme: scheme,
            path: path,
            queryParameters: queryParams,
          ),
          headers: headers,
          body: body,
        );
      case ApiType.put:
        return await http.put(
          Uri(
            host: baseUrl,
            scheme: scheme,
            path: path,
            queryParameters: queryParams,
          ),
          headers: headers,
          body: body,
        );
      case ApiType.patch:
        return await http.patch(
          Uri(
            host: baseUrl,
            scheme: scheme,
            path: path,
            queryParameters: queryParams,
          ),
          headers: headers,
          body: body,
        );
      case ApiType.delete:
        return await http.delete(
          Uri(
            host: baseUrl,
            scheme: scheme,
            path: path,
            queryParameters: queryParams,
          ),
          headers: headers,
          body: body,
        );
    }
  }
}

class ApiService {
  final log = getLogger('ApiService');
  final _apiRequest = ApiRequest(baseUrl: 'blog-app-4tzq.onrender.com');
  ApiService._();

  static ApiService instance = ApiService._();

  Future<ResponseModel> _makeApiCall(
    String path,
    ApiType type, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    Object? body,
    String? contentType,
    String? accept,
  }) async {
    headers ??= <String, String>{};
    if (contentType != null) headers["Content-Type"] = contentType;
    if (accept != null) headers["accept"] = accept;
    bool success = false;
    String message = "Something sent wrong, please try again.";

    try {
      http.Response response = await _apiRequest.response(
        path,
        type,
        queryParams: queryParams,
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200 ||
          response.statusCode == 201 && response.body.isNotEmpty) {
        final body = json.decode(utf8.decode(response.bodyBytes));
        Logger().i("inside core 1st $body --- ${body['statusCode']}");
        success = body['success'] == true && body['data'] is List<dynamic>;
        message = body['message'] ?? 'Failed to get data';
        Logger().i("inside core 2nd ---- ${body['statusCode']}");
        final apiResponse = ResponseModel(
          success: success,
          statusCode: body['statusCode'],
          message: message,
          data: body['data'],
        );
        return apiResponse;
      } else {
        final body = json.decode(utf8.decode(response.bodyBytes));
        Logger().i(
            "inside core 3rd $message in else status is ${response.statusCode} --- $body");
        return ResponseModel(
          success: success,
          message: body['message'] ?? "Something went wrong.",
          statusCode: body['statusCode'] ?? 500,
        );
      }
    } on SocketException catch (e) {
      log.e("Error in api call  $e");
      return ResponseModel(
        success: success,
        message: "Check your internet connection and try again.",
      );
    } catch (e) {
      log.e("Error in api call s $e");
      return ResponseModel(
        success: success,
        message: "Something went wrong. Please try again.",
      );
    }
  }

  Future<Either<ErrorResponseModel, String>> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    final response = await _makeApiCall(
      "/api/",
      ApiType.post,
      contentType: "application/json",
      accept: "application/json",
      body: jsonEncode(
        {
          "password": password,
          "email": email,
          "username": username,
        },
      ),
    );
    if (!response.hasData) {
      log.i("No data in response - signup - $email -$password");
      return Left(
        ErrorResponseModel(
          errorCode: 1,
          message: response.message,
        ),
      );
    } else {
      log.i("In response has data ");
      return Right(response.data?[0]);
    }
  }
}
