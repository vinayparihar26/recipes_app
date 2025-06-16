import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/api/api.dart';

import 'package:recipes_app/models/Recipes_model.dart';
import 'package:recipes_app/responsive.dart';
import 'package:recipes_app/screens/single_recipe.dart';
import 'package:recipes_app/widgets/helper.dart';
import 'package:recipes_app/widgets/recipe_filter_bottom_sheet.dart';
import 'package:recipes_app/widgets/recipe_grid_view.dart';
import 'package:recipes_app/widgets/tag_filter_button.dart';
import 'package:recipes_app/widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Recipes> recipesList = [];
  List<String> tagsList = [];
  String selectedSort = "name";
  String? tempSelectedSort;
  String? id;

  @override
  void initState() {
    super.initState();
    getAllRecipes();
    getSearchRecipes('');
    getAllRecipesTags();
  }

  Future<void> getAllRecipes() async {
    var data = await Api().getAllRecipes();
    RecipesModel recipesModel = RecipesModel.fromJson(data);
    setState(() {
      recipesList = recipesModel.recipes!;
    });
  }

  Future<void> getSearchRecipes(String query) async {
    var data = await Api().getSearchRecipes(query);
    RecipesModel recipesModel = RecipesModel.fromJson(data);
    setState(() {
      recipesList = recipesModel.recipes ?? [];
    });
  }

  Future<void> getRecipesByTag(String tag) async {
    var data = await Api().getRecipesByTag(tag);
    RecipesModel recipesModel = RecipesModel.fromJson(data);
    setState(() {
      recipesList = recipesModel.recipes ?? [];
    });
  }

  Future<void> getRecipesByMeal(String type) async {
    var data = await Api().getRecipesByMeal(type);
    RecipesModel recipesModel = RecipesModel.fromJson(data);
    setState(() {
      recipesList = recipesModel.recipes ?? [];
    });
    print(recipesList);
  }

  Future<void> getAllRecipesTags() async {
    List<String> data = await Api().getAllRecipesTags();
    setState(() {
      tagsList = data;
    });
  }

  void getSortedRecipes() async {
    var data = await Api().getRecipesSorted(selectedSort, "asc");
    RecipesModel recipesModel = RecipesModel.fromJson(data);
    setState(() {
      recipesList = recipesModel.recipes ?? [];
    });
  }

  void openFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return RecipeFilterBottomSheet(
          tempSelectedSort: tempSelectedSort,
          onClear: (val) {
            setState(() {
              tempSelectedSort = val;
            });
          },
          onApply: (val) {
            setState(() {
              selectedSort = val;
              tempSelectedSort = val;
              getSortedRecipes();
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 58, 72),
        elevation: 4,
        title: Icon(
          Icons.menu,
          color: Colors.white,
          size: 30 * getResponsive(context),
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(8 * getResponsive(context)),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: IconButton(
              color: Colors.white,
              onPressed: () {
                Helper.showRecipeOptions(context);
              },
              icon: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Widgets.heightSpacing(context, 0.010),
          Card(
            elevation: 3 * getResponsive(context),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    getAllRecipes();
                  } else {
                    getSearchRecipes(value);
                  }
                });
              },
              decoration: Widgets.searchInputDecoration(context),
            ),
          ),

          Widgets.heightSpacing(context, 0.01),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
              
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      10 * getResponsive(context),
                    ),
                    boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 1)],
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          openFilterBottomSheet();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_list,
                             
                            ),
                            SizedBox(width: 0.02 * getWidth(context)),
                            Text("Filter"),
                          ],
                        ),
                      ),
                      SizedBox(width: 0.01 * getWidth(context)),
                    ],
                  ),
                ),
                SizedBox(width: 0.010 * getWidth(context)),
                TagsFilterButton(
                  getAllTags: getAllRecipesTags,
                  getAllRecipes: getAllRecipes,
                  getRecipesByTag: getRecipesByTag,
                  tagsList: tagsList,
                  getResponsive: getResponsive,
                  getWidth: getWidth,
                  getHeight: getHeight,
                ),
              ],
            ),
          ),

          Widgets.heightSpacing(context, 0.01),
          RecipeGridView(
            recipesList: recipesList,
            getRecipesByMeal: getRecipesByMeal,
            getResponsive: getResponsive,
            getWidth: getWidth,
            getHeight: getHeight,
          ),
        ],
      ),
    );
  }
}
