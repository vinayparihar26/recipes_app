import 'package:flutter/material.dart';
import 'package:recipes_app/responsive.dart';

class Widgets {
  static verticalSpace(String height) {
    return SizedBox(height: double.parse(height));
  }

  static horizontalSpace(String width) {
    return SizedBox(width: double.parse(width));
  }

  static text(String text, {TextStyle? style, Size? size}) {
    return Text(
      text,
      style: style ?? TextStyle(fontSize: size?.width),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  static InputDecoration searchInputDecoration(
    BuildContext context, {
    String hint = "Search for recipes, meals...",
  }) {
    return InputDecoration(
      hintText: hint,
      fillColor: Colors.white,
      filled: true,
      prefixIcon: Icon(Icons.search),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 0.01 * getWidth(context),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 0.01 * getWidth(context),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static textBlack(String text, {TextStyle? style, Size? size}) {
    return Text(
      text,
      style: style ?? TextStyle(fontSize: size?.width, color: Colors.black),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  static elevatedBtn(
    BuildContext context, {
    String? text,
    VoidCallback? onPressed,
    Color? color,
    double? width,
    double? height,
  }) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: const Text('Button'),
    );
  }

  static SizedBox heightSpacing(BuildContext context, double percent) {
    return SizedBox(height: percent * getHeight(context));
  }

  static Widget headingText(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20 * getResponsive(context),
        fontWeight: FontWeight.bold,
      ),
    );
  }

 static ButtonStyle customButtonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFCB202D),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
}
