import 'package:foodorder/Api/UserApi.dart';
import 'package:foodorder/di/service_locator.dart';
import 'package:foodorder/model/CategoryResponse.dart';
import 'package:foodorder/model/RecipeResponse.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final userApi = getIt.get<UserApi>();
  List<Category?> categoryList = [];
  List<Recipe?> recipeList = [];
  CategoryResponse? categoryResponse;
  RecipeResponse? recipeResponse;
  var loading = false.obs;

  addCategory(var param, bool isEdit) async {
    loading.value = true;
    var result = await userApi.addCategory(param, isEdit);
    loading.value = false;
    if (result) {
      return true;
    }
    return false;
  }

  //add recipe
  addRecipe(var param, bool isEdit) async {
    loading.value = true;
    var result = await userApi.addRecipe(param, isEdit);
    loading.value = false;
    if (result) {
      return true;
    }
    return false;
  }

  getCategoryList() async {
    loading.value = true;
    categoryResponse = (await userApi.getCategoryList());
    if (categoryResponse != null) {
      categoryList = categoryResponse?.data?.results ?? [];
    }
    loading.value = false;
  }

  removeCategory(Category category) async {
    var result = await userApi.deleteCategory(int.parse(category.id!));
    if (result) {
      categoryList.remove(category);
      update();
    }
  }

  //https://dktechnolab.com/food_corner/api/Recipes_delete.php

  //recipe
  getRecipeList() async {
    loading.value = true;
    recipeResponse = (await userApi.getRecipeList());
    if (recipeResponse != null) {
      recipeList = recipeResponse?.data?.results ?? [];
    }
    loading.value = false;
  }

  removeRecipe(Recipe recipe) async {
    var result = await userApi.deleteRecipe(int.parse(recipe.id!));
    if (result) {
      recipeList.remove(recipe);
      update();
    }
  }
}
