import 'dart:convert';

import 'package:recipes_app/injection/injection.dart';

class Api {
  getAllRecipes() async {
    var response = await restClient.getAllRecipes();
    return jsonDecode(response);
  }

  getSearchRecipes(String query) async {
    var response = await restClient.searchRecipes(query);
    return jsonDecode(response);
  }

  getAllRecipesTags() async {
    return await restClient.getAllRecipesTags();
  }

  getRecipesSorted(String sortBy, String order) async {
    var response = await restClient.getRecipesSorted(sortBy, order);
    return jsonDecode(response);
  }

  getRecipesByTag(String tag) async {
    var response = await restClient.getRecipesByTag(tag);
    return jsonDecode(response);
  }

  getRecipesByMeal(String type) async {
    var response = await restClient.getRecipesByMeal(type);
    return jsonDecode(response);
  }

  getSingleRecipe(String id) async {
    var response = await restClient.getSingleRecipe(id);
    return jsonDecode(response);
  }

  addRecipe(Map<String, dynamic> recipeData) async {
    var response = await restClient.addRecipe(recipeData);
    return jsonDecode(response);
  }

  updateRecipe(String id, Map<String, dynamic> recipeData) async {
    var response = await restClient.updateRecipe(id, recipeData);
    return jsonDecode(response);
  }

  Future<String> deleteRecipeById(String id) async {
    final response = await restClient.deleteRecipe(id);
    return jsonDecode(response);
  }
}
