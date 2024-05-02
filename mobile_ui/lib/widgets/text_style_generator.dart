import 'package:flutter/material.dart';

class TextStyleGenerator extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLine;
  final TextOverflow? overflow;
  final TextAlign? alignment;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final Color? decorationColor;
  final Paint? foreground;
  final double? letterSpacing;
  final double? height;

  const TextStyleGenerator({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.maxLine,
    this.overflow,
    this.alignment,
    this.fontStyle,
    this.decoration,
    this.decorationStyle,
    this.decorationThickness,
    this.decorationColor,
    this.foreground,
    this.letterSpacing,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      maxLines: maxLine,
      overflow: overflow,
      textAlign: alignment,
      style: TextStyle(
        letterSpacing: letterSpacing,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        decorationColor: decorationColor,
        foreground: foreground,
        height: height,
      ),
    );
  }
}
