import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/api/api.dart';

import 'package:recipes_app/models/Recipes_model.dart';
import 'package:recipes_app/responsive.dart';
import 'package:recipes_app/screens/single_recipe.dart';
import 'package:recipes_app/widgets/helper.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 58, 72),
        title: Icon(
          Icons.menu,
          color: Colors.white,
          size: 30 * getResponsive(context),
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              color: Colors.white,
              onPressed: () {
                Helper.showRecipeOptions(context);
              },
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0.010 * getHeight(context)),
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
              decoration: InputDecoration(
                hintText: "Search for recipes, meals...",

                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.01 * getWidth(context),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          SizedBox(height: 0.01 * getHeight(context)),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 0.20 * getWidth(context),
                  height: 0.040 * getHeight(context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      10 * getResponsive(context),
                    ),
                    boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 1)],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            openFilterBottomSheet();
                          },
                          child: Row(
                            children: [
                              Icon(Icons.filter_list, size: 20),
                              SizedBox(width: 0.02 * getWidth(context)),
                              Text("Filter"),
                            ],
                          ),

                          // Icon(Icons.sort_by_alpha, size: 20),
                        ),
                        SizedBox(width: 0.01 * getWidth(context)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 0.010 * getWidth(context)),

                IconButton(
                  onPressed: () async {
                    await getAllRecipesTags();
                    showModalBottomSheet(
                      isScrollControlled: true,
                      enableDrag: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20 * getResponsive(context)),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          " Filter by Tags",
                                          style: TextStyle(
                                            fontSize:
                                                18 * getResponsive(context),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        SizedBox(
                                          width: 0.50 * getWidth(context),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            getAllRecipes();
                                          },
                                          icon: Icon(Icons.clear),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 0.010 * getHeight(context)),

                                Wrap(
                                  spacing: 8 * getResponsive(context),
                                  runSpacing: 1 * getResponsive(context),
                                  children:
                                      tagsList.map((tag) {
                                        return ActionChip(
                                          avatar: Icon(Icons.tag),

                                          label: Text(tag),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            getRecipesByTag(tag);
                                            //getSearchRecipes(tag.toString());
                                          },
                                        );
                                      }).toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: Container(
                    alignment: Alignment.center,
                    width: 0.20 * getWidth(context),
                    height: 0.040 * getHeight(context),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(spreadRadius: 1, blurRadius: 1)],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.tag, size: 20 * getResponsive(context)),
                          Text("Tags", style: TextStyle(fontSize: 15*getResponsive(context))),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 0.01 * getHeight(context)),
          Expanded(
            child: GridView.builder(
              itemCount: recipesList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //margin: EdgeInsets.all(8),
                  color: Colors.white,
                  elevation: 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: GestureDetector(
                            child: Image(
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                recipesList[index].image.toString(),
                              ),
                            ),
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => SingleRecipe(
                                          id:
                                              '${recipesList[index].id.toString()}',
                                        ),
                                  ),
                                ),
                          ),
                        ),
                      ),

                      SizedBox(height: 0.01 * getHeight(context)),
                      SizedBox(
                        height: 35,
                        child: ListView.builder(
                          itemCount: recipesList[index].mealType!.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, mealindex) {
                            final meal =
                                recipesList[index].mealType![mealindex];
                            final isLast =
                                mealindex ==
                                recipesList[index].mealType!.length - 1;
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  //getSearchRecipes(meal);
                                  getRecipesByMeal(meal);
                                },
                                child: Text(
                                  isLast ? meal : '$meal,',
                                  softWrap: false,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          recipesList[index].name.toString(),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(CupertinoIcons.timer, size: 20),
                              Text(
                                '${recipesList[index].cookTimeMinutes.toString()} min',
                              ),
                            ],
                          ),
                          SizedBox(width: 6),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(CupertinoIcons.timer, size: 20),
                              Text(
                                '${recipesList[index].servings.toString()} serving',
                              ),
                            ],
                          ),
                          SizedBox(width: 6),
                          Column(
                            children: [
                              Icon(CupertinoIcons.clock, size: 20),
                              Text(
                                '${recipesList[index].caloriesPerServing.toString()} kcal',
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 0.01 * getHeight(context)),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Row(
                          children: [
                            Container(
                              height: 0.03 * getHeight(context),
                              width: 0.1 * getWidth(context),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  children: [
                                    Text(
                                      recipesList[index].rating.toString(),
                                      style: TextStyle(
                                        fontSize: 12 * getResponsive(context),
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 15 * getResponsive(context),
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Text(
                              " (${recipesList[index].reviewCount.toString()})",
                              style: TextStyle(
                                fontSize: 15 * getResponsive(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68 * getResponsive(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getAllRecipes() async {
    var data = await Api().getAllRecipes();
    RecipesModel recipesModel = RecipesModel.fromJson(data);
    setState(() {
      recipesList = recipesModel.recipes!;
    });
    print(recipesList);
  }

  Future<void> getSearchRecipes(String query) async {
    var data = await Api().getSearchRecipes(query);
    // var json = jsonDecode(data);
    RecipesModel recipesModel = RecipesModel.fromJson(data);
    setState(() {
      recipesList = recipesModel.recipes ?? [];
    });
    print(json);
  }

  Future<void> getRecipesByTag(String tag) async {
    print("Sending tag: $tag");
    var data = await Api().getRecipesByTag(tag);
    RecipesModel recipesModel = RecipesModel.fromJson(data);
    setState(() {
      recipesList = recipesModel.recipes ?? [];
    });
    print(recipesList);
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
    //RecipesModel recipesModel = RecipesModel.fromJson(data);
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
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 0.01 * getHeight(context)),
                Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 20 * getResponsive(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  title: Text('All'),
                  value: 'all',
                  groupValue: tempSelectedSort,
                  onChanged:
                      (value) => setState(() {
                        tempSelectedSort = value!;
                      }),
                ),
                RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Name'),
                  value: 'name',
                  groupValue: tempSelectedSort,
                  onChanged:
                      (value) => setState(() {
                        tempSelectedSort = value!;
                      }),
                ),
                RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Calories'),
                  value: 'caloriesPerServing',
                  groupValue: tempSelectedSort,
                  onChanged:
                      (value) => setState(() {
                        tempSelectedSort = value!;
                      }),
                ),
                RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Cook Time'),
                  value: 'cookTimeMinutes',
                  groupValue: tempSelectedSort,
                  onChanged:
                      (value) => setState(() {
                        tempSelectedSort = value!;
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          tempSelectedSort = null;
                        });
                      },
                      child: Text(
                        'Clear All',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFCB202D),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (tempSelectedSort != null) {
                            setState(() {
                              selectedSort = tempSelectedSort!;
                              getSortedRecipes();
                            });
                            getSortedRecipes();
                          }
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Apply',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
