import 'package:foodorder/Api/UserApi.dart';
import 'package:foodorder/di/service_locator.dart';
import 'package:foodorder/model/ProductResponse.dart';
import 'package:foodorder/model/UserInfo.dart';
import 'package:get/get.dart';


class UserController extends GetxController{

  final userApi = getIt.get<UserApi>();
  UserInfo? userInfo;
  var loading = false.obs;
  var productLoading = false.obs;

  List<ProductResponse?> productResponse = [];

  login(email,password) async {
    loading.value = true;
    userInfo = await userApi.login(email, password);
    loading.value = false;
  }

  getProduct() async {
    productLoading.value = true;
    productResponse = (await userApi.getProduct());
    productLoading.value = false;
  }


}