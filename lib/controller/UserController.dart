import 'package:foodorder/Api/UserApi.dart';
import 'package:foodorder/di/service_locator.dart';
import 'package:foodorder/model/MenuResponse.dart';
import 'package:foodorder/model/UserInfo.dart';
import 'package:foodorder/model/UserResponse.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final userApi = getIt.get<UserApi>();
  UserInfo? userInfo;
  var loading = false.obs;
  var productLoading = false.obs;
  var addProductLoading = false.obs;
  var signUpLoading = false.obs;
  var actionLoading = false.obs;

  MenuResponse? menuResponse;
  UserResponse? userResponse;
  List<Menu?> menuList = [];
  List<User?> userList = [];

  login(email, password) async {
    loading.value = true;
    userInfo = await userApi.login(email, password);
    loading.value = false;
  }

  signUp(var param, bool isEdit) async {
    signUpLoading.value = true;
    final value = await userApi.signUp(param, isEdit);
    signUpLoading.value = false;
    return value;
  }

  getProduct() async {
    productLoading.value = true;
    menuResponse = (await userApi.getProduct());
    productLoading.value = false;
    if (menuResponse != null) {
      menuList = menuResponse?.data?.results ?? [];
    }
  }

  getUserList(bool onlyAdminList) async {
    addProductLoading.value = true;
    userResponse = (await userApi.getUserList());
    if (userResponse == null) {
      addProductLoading.value = false;
      return;
    }
    userList = userResponse?.data?.results ?? [];
    if (onlyAdminList) {
      userList.removeWhere((element) => element?.wpAdmin == "0");
    } else {
      userList.removeWhere((element) => element?.wpAdmin == "1");
    }
    addProductLoading.value = false;
  }

  addMenu(var param, bool isEdit) async {
    addProductLoading.value = true;
    var result = await userApi.addMenu(param, isEdit);
    addProductLoading.value = false;
    if (result) {
      return true;
    }
    return false;
  }

  removeUser(User user) async {
    var result = await userApi.deleteUser(int.parse(user.id!));
    if (result) {
      userList.remove(user);
      update();
    }
  }

  removeMenu(Menu menu) async {
    var result = await userApi.deleteMenu(int.parse(menu.id!));
    if (result) {
      menuList.remove(menu);
      update();
    }
  }
}
