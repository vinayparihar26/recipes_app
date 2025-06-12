import 'package:flutter/material.dart';
import 'package:recipes_app/api/api.dart';

class Helper {
   static void addRecipe(ScaffoldMessengerState messenger) async {
    var data = {"name": "Tasty Pizza1"};
    var response = await Api().addRecipe(data);
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text("Recipe added: ${response.toString()}"),
      ),
    );
  }
  static void updateRecipe(ScaffoldMessengerState messenger) async {
    var data = {"name": "Tasty Pizza"};
    var response = await Api().updateRecipe('1', data);
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: Text("Recipe updated: ${response.toString()}"),
      ),
    );
  }

 static void deleteRecipeById(ScaffoldMessengerState messenger) async {
    var response = await Api().deleteRecipeById('1');
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text("Recipe deleted: ${response.toString()}"),
      ),
    );
  }

static  void showRecipeOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.add, color: Colors.green),
                title: Text('Add Recipe'),
                onTap: () {
                  Navigator.pop(context);
                  Helper.addRecipe(ScaffoldMessenger.of(context));
                },
              ),
              ListTile(
                leading: Icon(Icons.edit, color: Colors.blue),
                title: Text('Update Recipe'),
                onTap: () {
                  Navigator.pop(context);
                  Helper.updateRecipe(ScaffoldMessenger.of(context));
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Delete Recipe'),
                onTap: () {
                  Navigator.pop(context);
                  Helper.deleteRecipeById(ScaffoldMessenger.of(context));
                },
              ),
            ],
          ),
        );
      },
    );
  }
  
}
