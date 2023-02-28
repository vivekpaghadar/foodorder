import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:foodorder/Pref.dart';
import 'package:foodorder/model/ProductResponse.dart';
import 'package:foodorder/model/UserInfo.dart';
import 'package:foodorder/network/dio_client.dart';
import 'package:foodorder/network/dio_exception.dart';

class UserApi {
  final DioClient dioClient;

  UserApi({required this.dioClient});

  Future<UserInfo?> login(email, password) async {
    try {
      final response = await loginApi(email, password);
      final user = UserInfo.fromJson(json.decode(response!.data));
      Pref.saveToken(user.user!.id!);
      return user;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    }
  }

  Future<Response?> loginApi(String email, String password) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addUserApi(String name, String job) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.login,
        data: {
          'name': name,
          'job': job,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addMenuApi(var param) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.addMenu,
        data: param
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductResponse?>> getProduct() async {
    try {
      final response = await getProductApi();
      final responseBody = response.data as List;
      final allPostList = responseBody.map((e) => ProductResponse.fromJson(e)).toList();
      return allPostList;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return [];
    }
  }

  Future<Response> getProductApi() async {
    try {
      final Response response = await dioClient.get(Endpoints.product);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUserApi(int id) async {
    try {
      await dioClient.delete('${Endpoints.login}/$id');
    } catch (e) {
      rethrow;
    }
  }
}
