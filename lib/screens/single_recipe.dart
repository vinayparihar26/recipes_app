import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/api/api.dart';
import 'package:recipes_app/models/recipes_model.dart';
import 'package:recipes_app/responsive.dart';

class SingleRecipe extends StatefulWidget {
  final String id;
  const SingleRecipe({super.key, required this.id});

  @override
  State<SingleRecipe> createState() => _SingleRecipeState();
}

class _SingleRecipeState extends State<SingleRecipe> {
  List<Recipes> recipesList = [];
  Recipes? recipe;
  @override
  void initState() {
    super.initState();
    getSingleRecipe(widget.id);
  }

  Future<void> getSingleRecipe(String id) async {
    var response = await Api().getSingleRecipe(id);

    setState(() {
      recipe = Recipes.fromJson(response);
    });
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                recipe == null
                    ? const CircularProgressIndicator()
                    : Card(
                      elevation: 2,

                      child: Image.network(
                        recipe!.image ?? '',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                      ),
                    ),

                Text(
                  recipe?.name ?? 'No name available',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 0.01 * getHeight(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.timer, size: 25),
                        Text('${recipe?.cookTimeMinutes ?? 'N/A'} min'),
                      ],
                    ),
                    SizedBox(width: 0.10 * getWidth(context)),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.timer, size: 25),
                        Text(' ${recipe?.servings ?? 'N/A'} serving'),
                      ],
                    ),
                    SizedBox(width: 0.10 * getWidth(context)),
                    Column(
                      children: [
                        Icon(CupertinoIcons.clock, size: 25),
                        Text('${recipe?.caloriesPerServing ?? 'N/A'} kcal'),
                      ],
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          recipe?.difficulty ?? 'No difficulty available',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    SizedBox(width: 0.02 * getWidth(context)),
                    Container(
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ' ${recipe?.cuisine ?? 'No cuisine available'}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),

                Text('ingredients', style: TextStyle(fontSize: 18)),
                recipe?.ingredients != null
                    ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recipe!.ingredients!.length,
                      itemBuilder: (BuildContext context, int index1) {
                        var point = 1 + index1;
                        return Text(
                          '($point) ${recipe!.ingredients![index1]}',
                          style: TextStyle(fontSize: 15),
                        );
                      },
                    )
                    : const Text('No ingredients available'),
                SizedBox(height: 0.02 * getHeight(context)),
                Container(
                  height: 1,
                  color: Colors.black,
                  width: double.infinity,
                ),
                Text('instructions', style: TextStyle(fontSize: 20)),
                SizedBox(height: 0.02 * getHeight(context)),
                recipe?.instructions != null
                    ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recipe!.instructions!.length,
                      itemBuilder: (BuildContext context, int index2) {
                        var point = 1 + index2;
                        return Text(
                          '($point) ${recipe!.instructions![index2]}',
                          style: TextStyle(fontSize: 15),
                        );
                      },
                    )
                    : const Text('No instructions available'),
                SizedBox(height: 0.02 * getHeight(context)),
                Container(
                  height: 1,
                  color: Colors.black,
                  width: double.infinity,
                ),
                SizedBox(height: 0.02 * getHeight(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
