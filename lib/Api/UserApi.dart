import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:foodorder/Pref.dart';
import 'package:foodorder/model/Category.dart';
import 'package:foodorder/model/ProductResponse.dart';
import 'package:foodorder/model/User.dart';
import 'package:foodorder/model/UserInfo.dart';
import 'package:foodorder/network/dio_client.dart';
import 'package:foodorder/network/dio_exception.dart';

class UserApi {
  final DioClient dioClient;

  UserApi({required this.dioClient});

  Future<UserInfo?> login(email, password) async {
    try {
      final response = await loginApi(email, password);
      UserInfo? user;
      try {
        user = UserInfo.fromJson(json.decode(response!.data));
        Pref.saveToken(user.user!.id!);
      } catch (e) {
        return null;
      }
      return user;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    }
  }

  Future<Response?> loginApi(String email, String password) async {

    FormData formData = FormData.fromMap({
      "email": email,
      "password": password,
    });

    try {
      final Response response = await dioClient.post(
        Endpoints.login,
        data: formData
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signUp(var params) async {
    try {
      final response = await signUpApi(params);
      if(response?.data['error'] == '000'){
        return true;
      }
      return false;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    }
  }

  Future<Response?> signUpApi(var param) async {

    FormData formData = FormData.fromMap(param);

    try {
      final Response response = await dioClient.post(
          Endpoints.signUp,
          data: formData
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }


  Future<List<ProductResponse?>> getProduct() async {
    try {
      final response = await getProductApi();
      final responseBody = json.decode(response.data) as List;
      final allPostList =
          responseBody.map((e) => ProductResponse.fromJson(e)).toList();
      return allPostList;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return [];
    }
  }

  Future<Response> getProductApi() async {
    try {
      final Response response = await dioClient.post(Endpoints.product);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User?>> getUserList() async {
    try {
      final response = await getUserListApi();
      final responseBody = response.data as List;
      final allPostList =
      responseBody.map((e) => User.fromJson(e)).toList();
      return allPostList;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return [];
    }
  }

  Future<Response> getUserListApi() async {
    try {
      final Response response = await dioClient.get(Endpoints.userList);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response?> addProduct(
      String name, double price, String desc, String imagePath) async {
    try {
      final response = await addMenuApi(name, price, desc, imagePath);
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    }
  }

  Future<Response> addMenuApi(
      String name, double price, String desc, String imagePath) async {

    FormData formData = FormData.fromMap({
      "prodect": name,
      "cat_menu" : 13,
      "price": price,
      "desc": desc,
      "status": 1,
      "P_photo": await MultipartFile.fromFile(imagePath),
    });

    try {
      final Response response =
          await dioClient.post(Endpoints.addMenu, data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Category?>> getCategoryList() async {
    try {
      final response = await getCategoryListApi();
      final responseBody = json.decode(response.data) as List;
      final allPostList =
      responseBody.map((e) => Category.fromJson(e)).toList();
      return allPostList;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return [];
    }
  }

  Future<Response> getCategoryListApi() async {
    try {
      final Response response = await dioClient.get(Endpoints.categoryList);
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
