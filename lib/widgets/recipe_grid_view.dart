import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/responsive_manager.dart';
import 'package:recipes_app/screens/single_recipe.dart';

class RecipeGridView extends StatelessWidget {
  final List<dynamic> recipesList;
  final void Function(String mealType) getRecipesByMeal;
  final double Function(BuildContext context) getResponsive;
  final double Function(BuildContext context) getWidth;
  final double Function(BuildContext context) getHeight;

  const RecipeGridView({
    super.key,
    required this.recipesList,
    required this.getRecipesByMeal,
    required this.getResponsive,
    required this.getWidth,
    required this.getHeight,
  });



  int getCrossAxisCount(BuildContext context) {
  final width = ResponsiveManager.screenWidth(context);

  if (ResponsiveManager.isDesktop(context)) return 5;
  if (ResponsiveManager.isTablet(context)) return 3;

  if (kIsWeb) {
    if (width >= 1400) return 6;
    if (width >= 1200) return 5;
    if (width >= 1000) return 4;
    if (width >= 950) return 4;
    if (width >= 900) return 4;
    if (width >= 850) return 4;
    if (width >= 800) return 3;
    if (width >= 600) return 2;
  }

  // Fallbacks
  if (ResponsiveManager.isDesktop(context)) return 5;
  if (ResponsiveManager.isTablet(context)) return 3;

  return 2;
}

double getChildAspectRatio(BuildContext context) {
  double width = ResponsiveManager.screenWidth(context);

  if (ResponsiveManager.isDesktop(context)) return width / (width * 1.9);
  if (ResponsiveManager.isTablet(context)) return width / (width * 2.2);

  if (kIsWeb) {
    if (width >= 1600) return 0.58;
    if (width >= 1400) return 0.52;
    if (width >= 1200) return 0.48;
    if (width >= 1000) return 0.45;
    if (width >= 900) return 0.43;
    if (width >= 850) return 0.50;
    if (width >= 800) return 0.48;
    if (width >= 750) return 0.42;
    if (width >= 700) return 0.30;
    if (width >= 600) return 0.52;
    if (width >= 550) return 0.60;
    if (width >= 500) return 0.56;
    if (width >= 400) return 0.54 ;
    if (width >= 350) return 0.48;
    if (width >= 300) return 0.44;
    if (width >= 250) return 0.42;

    return width / (width * 2.9);
  }

  return width / (width * 2.4);
}

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: recipesList.length,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getCrossAxisCount(context),
          childAspectRatio: getChildAspectRatio(context),
        ),
        itemBuilder: (context, index) {
          final recipe = recipesList[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: GestureDetector(
                      child: Image.network(
                        recipe.image.toString(),
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SingleRecipe(id: recipe.id.toString()),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10 * getResponsive(context)),
                SizedBox(
                  height: 35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recipe.mealType?.length ?? 0,
                    itemBuilder: (context, mealIndex) {
                      final meal = recipe.mealType![mealIndex];
                      final isLast = mealIndex == recipe.mealType!.length - 1;
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => getRecipesByMeal(meal),
                          child: Text(isLast ? meal : '$meal,', softWrap: false),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    recipe.name.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconInfo(context,Icons.timer, '${recipe.cookTimeMinutes} min'),
                    SizedBox(width: 6),
                    iconInfo(context,Icons.restaurant_menu, '${recipe.servings} serv'),
                    SizedBox(width: 6),
                    iconInfo(context,Icons.local_fire_department, '${recipe.caloriesPerServing} kcal'),
                  ],
                ),
                SizedBox(height: 10 * getResponsive(context)),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Row(
                    children: [
                      Container(
                        height: 0.03 * getHeight(context),
                        width: 0.1 * getWidth(context),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                recipe.rating.toString(),
                                style: TextStyle(
                                  fontSize: 15 * getResponsive(context),
                                  color: Colors.white,
                                ),
                              ),
                              Icon(Icons.star, size: 15 * getResponsive(context), color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        " (${recipe.reviewCount})",
                        style: TextStyle(fontSize: 15 * getResponsive(context)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget iconInfo(context,IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 22 * getResponsive(context)),
        Text(text),
      ],
    );
  }
}
