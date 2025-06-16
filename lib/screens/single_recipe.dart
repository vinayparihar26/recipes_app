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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 58, 72),
        title: Text(recipe?.name ?? ''),
        elevation: 4,
      ),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                recipe == null
                    ? const CircularProgressIndicator()
                    : Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.network(
                        recipe!.image ?? '',
                        height: 0.25 * getHeight(context),
                        width: double.infinity,
                        fit: BoxFit.fill,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                      ),
                    ),
                SizedBox(height: 0.02 * getHeight(context)),
                Text(
                  recipe?.name ?? 'No name available',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 0.01 * getHeight(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.timer),
                        Text('${recipe?.cookTimeMinutes ?? 'N/A'} min'),
                      ],
                    ),
                    SizedBox(width: 0.10 * getWidth(context)),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.person_2),
                        Text(' ${recipe?.servings ?? 'N/A'} serving'),
                      ],
                    ),
                    SizedBox(width: 0.10 * getWidth(context)),
                    Column(
                      children: [
                        Icon(CupertinoIcons.flame),
                        Text('${recipe?.caloriesPerServing ?? 'N/A'} kcal'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 0.01 * getHeight(context)),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5 * getResponsive(context)),
                        ),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          recipe?.difficulty ?? 'No difficulty available',
                        ),
                      ),
                    ),

                    SizedBox(width: 0.01 * getWidth(context)),
                    Container(
                      color: Colors.green.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          ' ${recipe?.cuisine ?? 'No cuisine available'}',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.02 * getHeight(context)),
                Text('ingredients'),
                recipe?.ingredients != null
                    ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recipe!.ingredients!.length,
                      itemBuilder: (BuildContext context, int index1) {
                        var point = 1 + index1;
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            child: Text(
                              '$point',
                             
                            ),
                          ),
                          title: Text(recipe!.ingredients![index1]),
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
                SizedBox(height: 0.02 * getHeight(context)),
                Text(
                  'instructions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 0.02 * getHeight(context)),
                recipe?.instructions != null
                    ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recipe!.instructions!.length,
                      itemBuilder: (BuildContext context, int index2) {
                        var point = 1 + index2;
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 15,
                            child: Text('$point'),
                          ),
                          title: Text(recipe!.instructions![index2]),
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
