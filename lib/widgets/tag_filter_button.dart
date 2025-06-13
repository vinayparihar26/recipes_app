
import 'package:flutter/material.dart';

class TagsFilterButton extends StatelessWidget {
  final Future<void> Function() getAllTags;
  final void Function() getAllRecipes;
  final void Function(String tag) getRecipesByTag;
  final List<String> tagsList;
  final double Function(BuildContext context) getResponsive;
  final double Function(BuildContext context) getWidth;
  final double Function(BuildContext context) getHeight;

  const TagsFilterButton({
    super.key,
    required this.getAllTags,
    required this.getAllRecipes,
    required this.getRecipesByTag,
    required this.tagsList,
    required this.getResponsive,
    required this.getWidth,
    required this.getHeight,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await getAllTags();
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: [
                          Text(
                            " Filter by Tags",
                          
                          ),
                          Spacer(),
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
                    SizedBox(height: 10 * getResponsive(context)),
                    Wrap(
                      spacing: 8 * getResponsive(context),
                      runSpacing: 8 * getResponsive(context),
                      children: tagsList.map((tag) {
                        return ActionChip(
                          avatar: Icon(Icons.tag),
                          label: Text(tag),
                          onPressed: () { 
                            Navigator.pop(context);
                            getRecipesByTag(tag);
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
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Icon(Icons.tag, size: 20 * getResponsive(context)),
              SizedBox(width: 0.02 * getWidth(context)),
              Text("Tags"),
            ],
          ),
        ),
      ),
    );
  }
}
