import 'package:foodorder/Api/UserApi.dart';
import 'package:foodorder/di/service_locator.dart';
import 'package:foodorder/model/ProductResponse.dart';
import 'package:foodorder/model/User.dart';
import 'package:foodorder/model/UserInfo.dart';
import 'package:get/get.dart';


class UserController extends GetxController{

  final userApi = getIt.get<UserApi>();
  UserInfo? userInfo;
  var loading = false.obs;
  var productLoading = false.obs;
  var addProductLoading = false.obs;
  var signUpLoading = false.obs;

  List<ProductResponse?> productResponse = [];
  List<User?> userResponse = [];

  login(email,password) async {
    loading.value = true;
    userInfo = await userApi.login(email, password);
    loading.value = false;
  }

  signUp(var param) async {
    signUpLoading.value = true;
    final value = await userApi.signUp(param);
    signUpLoading.value = false;
    return value;
  }

  getProduct() async {
    productLoading.value = true;
    productResponse = (await userApi.getProduct());
    productLoading.value = false;
  }

  getUserList(bool onlyAdminList) async {
    addProductLoading.value = true;
    userResponse = (await userApi.getUserList());
    if(onlyAdminList){
      userResponse.removeWhere((element) => element?.wpAdmin == "0");
    }else{
      userResponse.removeWhere((element) => element?.wpAdmin == "1");
    }
    addProductLoading.value = false;
  }

  addProduct(String name,double price,String desc,String imagePath) async {
    addProductLoading.value = true;
    await userApi.addProduct(name,price,desc,imagePath);
    addProductLoading.value = false;
  }


}