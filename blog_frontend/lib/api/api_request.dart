import 'dart:convert';
import 'dart:io';

import 'package:blog_frontend/file_exporter.dart';
import 'package:blog_frontend/models/blog_model.dart';
import 'package:blog_frontend/models/error_response_model.dart';
import 'package:http/http.dart' as http;

class ApiRequest {
  final String baseUrl;
  final String scheme;

  ApiRequest({
    required this.baseUrl,
    this.scheme = 'https',
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
      log.i(response.statusCode);
      log.i(response.body.isNotEmpty);
      if (response.statusCode == 200 ||
          response.statusCode == 201 && response.body.isNotEmpty) {
        Logger().i("inside core 1st");
        Map<String, dynamic> data = json.decode(response.body);
        final apiResponse = ResponseModel(
          success: true,
          data: [data],
        );
        return apiResponse;
      } else {
        Map<String, dynamic> data = json.decode(response.body);
        Logger().i(
            "inside core 2nd $message in else status is ${response.statusCode}");
        return ResponseModel(
          success: success,
          message: data[0]['message'] ?? "Something went wrong.",
          statusCode: data[0]['statusCode'] ?? 500,
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
      "/api/auth/register",
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
    log.i(response.data);
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
      return Right(response.data?[0]["_id"]);
    }
  }

  Future<Either<ErrorResponseModel, String>> login({
    required String password,
    required String username,
  }) async {
    final response = await _makeApiCall(
      "/api/auth/login",
      ApiType.post,
      contentType: "application/json",
      accept: "application/json",
      body: jsonEncode(
        {
          "password": password,
          "username": username,
        },
      ),
    );
    log.i(response.data);
    if (!response.hasData) {
      log.i("No data in response - login");
      return Left(
        ErrorResponseModel(
          errorCode: 1,
          message: response.message,
        ),
      );
    } else {
      log.i("In response has data ");
      return Right(response.data?[0]["_id"]);
    }
  }

  Future<Either<ErrorResponseModel, String>> createPost({
    required String title,
    required String username,
    required String description,
    String? image,
  }) async {
    final response = await _makeApiCall(
      "/api/posts",
      ApiType.post,
      contentType: "application/json",
      accept: "application/json",
      body: image.isNotNull
          ? jsonEncode(
              {
                "title": title,
                "username": username,
                "desc": description,
                "photo": image!
              },
            )
          : jsonEncode(
              {"title": title, "username": username, "desc": description},
            ),
    );
    log.i(response.data);
    if (!response.hasData) {
      log.i("No data in response");
      return Left(
        ErrorResponseModel(
          errorCode: 1,
          message: response.message,
        ),
      );
    } else {
      log.i("In response has data ");
      return Right(response.data?[0]["_id"]);
    }
  }

  Future<Either<ErrorResponseModel, List<BlogModel>>> getPosts() async {
    final response = await _makeApiCall(
      "/api/posts",
      ApiType.get,
      contentType: "application/json",
      accept: "application/json",
    );
    if (!response.hasData) {
      log.i("No data in response");
      return Left(
        ErrorResponseModel(
          errorCode: 1,
          message: response.message,
        ),
      );
    } else {
      log.i("In response has data ");
      List<dynamic> temp = response.data?[0]["data"];
      List<BlogModel> ans = temp.map((e) => BlogModel.fromJson(e)).toList();
      return Right(ans);
    }
  }
}
