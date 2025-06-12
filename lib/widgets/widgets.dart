import 'package:flutter/material.dart';

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
}
