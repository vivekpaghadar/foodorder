import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodorder/Pref.dart';
import 'package:foodorder/model/CategoryResponse.dart';
import 'package:foodorder/model/CommonResponse.dart';
import 'package:foodorder/model/MenuResponse.dart';
import 'package:foodorder/model/RecipeResponse.dart';
import 'package:foodorder/model/UserInfo.dart';
import 'package:foodorder/model/UserResponse.dart';
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
      final Response response =
          await dioClient.post(Endpoints.login, data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signUp(var params, bool isEdit) async {
    try {
      final response = await signUpApi(params, isEdit);
      if (isEdit) {
        var data = json.decode(response!.data);
        var success = data['Success'];
        if (success) {
          return true;
        }
        return false;
      } else {
        CommonResponse deleteResponse = CommonResponse.fromJson(response!.data);
        Fluttertoast.showToast(msg: '${deleteResponse.data!.message}');
        if (deleteResponse.success!) {
          return true;
        }
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    }
  }

  Future<Response?> signUpApi(var param, bool isEdit) async {
    FormData formData = FormData.fromMap(param);

    try {
      final Response response = await dioClient.post(
          isEdit ? Endpoints.updateUser : Endpoints.signUp,
          data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<MenuResponse?> getProduct() async {
    try {
      final response = await getProductApi();
      final jsonResponse = json.decode(response.data);
      MenuResponse menuResponse = MenuResponse.fromJson(jsonResponse);
      if (menuResponse.success!) {
        return menuResponse;
      }
      return null;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
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

  Future<UserResponse?> getUserList() async {
    try {
      final response = await getUserListApi();
      final responseBody = UserResponse.fromJson(response.data);
      return responseBody;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    }
  }

  Future<Response> getUserListApi() async {
    try {
      final Response response = await dioClient.post(Endpoints.userList);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addMenu(var param, bool isEdit) async {
    try {
      final response = await addMenuApi(param, isEdit);
      if (isEdit) {
        CommonResponse deleteResponse =
            CommonResponse.fromJson(json.decode(response.data));
        Fluttertoast.showToast(msg: '${deleteResponse.data!.message}');
        if (deleteResponse.success!) {
          return true;
        }
        return false;
      } else {
        CommonResponse deleteResponse = CommonResponse.fromJson(response.data);
        Fluttertoast.showToast(msg: '${deleteResponse.data!.message}');
        if (deleteResponse.success!) {
          return true;
        }
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    }
  }

  Future<Response> addMenuApi(var param, bool isEdit) async {
    FormData formData = FormData.fromMap(param);
    try {
      final Response response = await dioClient.post(
          isEdit ? Endpoints.updateMenu : Endpoints.addMenu,
          data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // add category
  Future<bool> addCategory(var param, bool isEdit) async {
    try {
      final response = await addCategoryApi(param, isEdit);
      if (isEdit) {
        var data = json.decode(response.data);
        var success = data['Success'];
        if (success) {
          return true;
        }
        return false;
      } else {
        CommonResponse deleteResponse = CommonResponse.fromJson(response.data);
        Fluttertoast.showToast(msg: '${deleteResponse.data!.message}');
        if (deleteResponse.success!) {
          return true;
        }
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    }
  }

  Future<Response> addCategoryApi(var param, bool isEdit) async {
    FormData formData = FormData.fromMap(param);
    try {
      final Response response = await dioClient.post(
          isEdit ? Endpoints.updateCategory : Endpoints.addCategory,
          data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //add recipe
  Future<bool> addRecipe(var param, bool isEdit) async {
    try {
      final response = await addRecipeApi(param, isEdit);
      if (isEdit) {
        var data = json.decode(response.data);
        if (data['Success']) {
          return true;
        }
      } else {
        CommonResponse commonResponse = CommonResponse.fromJson(response.data);
        Fluttertoast.showToast(msg: '${commonResponse.data!.message}');
        if (commonResponse.success!) {
          return true;
        }
      }

      return false;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    }
  }

  Future<Response> addRecipeApi(var param, bool isEdit) async {
    FormData formData = FormData.fromMap(param);
    try {
      final Response response = await dioClient.post(
          isEdit ? Endpoints.updateRecipe : Endpoints.addRecipe,
          data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<CategoryResponse?> getCategoryList() async {
    try {
      final response = await getCategoryListApi();
      CategoryResponse categoryResponse =
          CategoryResponse.fromJson(json.decode(response.data));
      if (categoryResponse.success!) {
        return categoryResponse;
      }
      return null;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    }
  }

  Future<Response> getCategoryListApi() async {
    try {
      final Response response = await dioClient.post(Endpoints.categoryList);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // recipe list
  Future<RecipeResponse?> getRecipeList() async {
    try {
      final response = await getRecipeListApi();
      RecipeResponse recipeResponse =
          RecipeResponse.fromJson(json.decode(response.data));
      if (recipeResponse.success!) {
        return recipeResponse;
      }
      return null;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return null;
    }
  }

  Future<Response> getRecipeListApi() async {
    try {
      final Response response = await dioClient.post(Endpoints.recipeList);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // delete user

  Future<bool> deleteUser(int params) async {
    try {
      final response = await deleteUserApi(params);
      CommonResponse deleteResponse = CommonResponse.fromJson(response!.data);
      Fluttertoast.showToast(msg: '${deleteResponse.data!.message}');
      if (deleteResponse.success!) {
        return true;
      }
      return false;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    }
  }

  Future<Response?> deleteUserApi(int userID) async {
    var param = {"user_id": userID};

    FormData formData = FormData.fromMap(param);

    try {
      final Response response =
          await dioClient.post(Endpoints.deleteUser, data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // delete category
  Future<bool> deleteCategory(int catID) async {
    try {
      final response = await deleteCategoryApi(catID);
      CommonResponse deleteResponse = CommonResponse.fromJson(response!.data);
      Fluttertoast.showToast(msg: '${deleteResponse.data!.message}');
      if (deleteResponse.success!) {
        return true;
      }
      return false;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    }
  }

  Future<Response?> deleteCategoryApi(int catID) async {
    var param = {"cat_id": catID};

    FormData formData = FormData.fromMap(param);

    try {
      final Response response =
          await dioClient.post(Endpoints.deleteCategory, data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // delete recipe
  Future<bool> deleteRecipe(int catID) async {
    try {
      final response = await deleteRecipeApi(catID);
      CommonResponse commonResponse = CommonResponse.fromJson(response!.data);
      Fluttertoast.showToast(msg: '${commonResponse.data!.message}');
      if (commonResponse.success!) {
        return true;
      }
      return false;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    }
  }

  Future<Response?> deleteRecipeApi(int catID) async {
    var param = {"recipes_id": catID};

    FormData formData = FormData.fromMap(param);

    try {
      final Response response =
          await dioClient.post(Endpoints.deleteRecipe, data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // delete menu
  Future<bool> deleteMenu(int menuID) async {
    try {
      final response = await deleteMenuApi(menuID);
      CommonResponse commonResponse = CommonResponse.fromJson(response!.data);
      Fluttertoast.showToast(msg: '${commonResponse.data!.message}');
      if (commonResponse.success!) {
        return true;
      }
      return false;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    }
  }

  Future<Response?> deleteMenuApi(int menuID) async {
    var param = {"menu_id": menuID};

    FormData formData = FormData.fromMap(param);

    try {
      final Response response =
          await dioClient.post(Endpoints.deleteMenu, data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
