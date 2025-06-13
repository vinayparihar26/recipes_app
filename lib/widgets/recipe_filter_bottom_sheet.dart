
import 'package:flutter/material.dart';
import 'package:recipes_app/widgets/widgets.dart';

class RecipeFilterBottomSheet extends StatelessWidget {
  final String? tempSelectedSort;
  final Function(String?) onClear;
  final Function(String selectedSort) onApply;

  const RecipeFilterBottomSheet({
    super.key,
    required this.tempSelectedSort,
    required this.onClear,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    String? localSelectedSort = tempSelectedSort;

    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Widgets.heightSpacing(context, 0.01),
              Widgets.headingText(context, 'Filters'),
              ...[
                {'label': 'All', 'value': 'all'},
                {'label': 'Name', 'value': 'name'},
                {'label': 'Calories', 'value': 'caloriesPerServing'},
                {'label': 'Cook Time', 'value': 'cookTimeMinutes'},
              ].map((item) {
                return RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  title: Text(item['label']!),
                  value: item['value']!,
                  groupValue: localSelectedSort,
                  onChanged: (value) {
                    setState(() => localSelectedSort = value);
                  },
                );
              }).toList(),

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
                      setState(() => localSelectedSort = null);
                      onClear(null);
                    },
                    child: Widgets.textBlack('Clear All'),
                  ),
                  ElevatedButton(
                    style: Widgets.customButtonStyle(),
                    onPressed: () {
                      if (localSelectedSort != null) {
                        onApply(localSelectedSort!);
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Apply',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
