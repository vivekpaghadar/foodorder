import 'package:dio/dio.dart';
import 'package:foodorder/Pref.dart';
import 'package:foodorder/model/UserInfo.dart';
import 'package:foodorder/network/dio_client.dart';
import 'package:foodorder/network/dio_exception.dart';


class UserApi {
  final DioClient dioClient;

  UserApi({required this.dioClient});

  Future<UserInfo?> login(email,password) async {
    try {
      final response = await loginApi(email, password);
      final user = UserInfo.fromJson(response!.data);
      Pref.saveToken(user.token!);
      return user;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    }
  }

  Future<Response?> loginApi(String email, String password) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.users,
        data: {
          'username': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      return null;
      rethrow;
    }
  }

  Future<Response> addUserApi(String name, String job) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.users,
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

  Future<Response> getUsersApi() async {
    try {
      final Response response = await dioClient.get(Endpoints.users);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateUserApi(int id, String name, String job) async {
    try {
      final Response response = await dioClient.put(
        '${Endpoints.users}/$id',
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

  Future<void> deleteUserApi(int id) async {
    try {
      await dioClient.delete('${Endpoints.users}/$id');
    } catch (e) {
      rethrow;
    }
  }
}
