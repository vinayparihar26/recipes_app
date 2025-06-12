import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com/')
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET("recipes")
  Future<String> getAllRecipes();

  @GET("recipes/search")
  Future<String> searchRecipes(@Query("q") String query);

  @GET("/recipes/tags")
  Future<List<String>> getAllRecipesTags();

  @GET('/recipes')
  Future<String> getRecipesSorted(
    @Query('sortBy') String sortBy,
    @Query('order') String order,
  );

  @GET('recipes/tag/{tag}')
  Future<String> getRecipesByTag(@Path('tag') String tag);

  @GET('recipes/meal-type/{type}')
  Future<String> getRecipesByMeal(@Path('type') String type);

  @GET('recipes/{id}')
  Future<String> getSingleRecipe(@Path('id') String id);

  @POST("recipes/add")
  Future<String> addRecipe(@Body() Map<String, dynamic> recipeData);

  @PUT('recipes/{id}')
  Future<String> updateRecipe(
    @Path("id") String id,
    @Body() Map<String, dynamic> recipeData,
  );
  @DELETE("/recipes/{id}")
  Future<String> deleteRecipe(@Path("id") String id);
}
