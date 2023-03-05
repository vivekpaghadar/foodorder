
import 'package:foodorder/Api/UserApi.dart';
import 'package:foodorder/di/service_locator.dart';
import 'package:foodorder/model/Category.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final userApi = getIt.get<UserApi>();
  List<Category?> categoryList = [];
  var loading = false.obs;

  getCategoryList() async {
    loading.value = true;
    categoryList = (await userApi.getCategoryList());
    loading.value = false;
  }
}
