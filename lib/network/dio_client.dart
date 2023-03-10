import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class Endpoints {
  Endpoints._();

  // base url
  // static const String baseUrl = "https://dummyjson.com";
  static const String baseUrl = "https://dktechnolab.com";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  static const String login = '/food_corner/api/login.php';

  //category
  static const String addCategory = '/food_corner/api/add_category.php';
  static const String updateCategory = '/food_corner/api/category_update.php';
  static const String categoryList = '/food_corner/api/Category_View.php';
  static const String deleteCategory = '/food_corner/api/delete_category.php';

  // user
  static const String signUp = '/food_corner/api/add_user.php';
  static const String deleteUser = '/food_corner/api/delete_user.php';
  static const String userList = '/food_corner/api/User_viwe.php';
  static const String updateUser = '/food_corner/api/user_update.php';

  // menu
  static const String addMenu = '/food_corner/api/Add_menu.php';
  static const String product = '/food_corner/api/Menu_View.php';
  static const String deleteMenu = '/food_corner/api/delete_menu.php';
  static const String updateMenu = '/food_corner/api/Menu_update.php';

  //recipe
  static const String recipeList = '/food_corner/api/Recipes_view.php';
  static const String deleteRecipe = '/food_corner/api/Recipes_delete.php';
  static const String addRecipe = '/food_corner/api/Recipes_add.php';
  static const String updateRecipe = '/food_corner/api/Recipes_update.php';
}

class DioClient {
  // dio instance
  final Dio _dio;

  // injecting dio instance
  DioClient(this._dio) {
    _dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.responseType = ResponseType.json;

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
