import 'dart:ui';

import 'package:flutter/material.dart';

class ChipsWidget extends StatelessWidget {
  const ChipsWidget(
      {Key? key,
      required this.index,
      required this.title,
      required this.onDelete,
      this.decoration})
      : super(key: key);

  final ChipsDecoration? decoration;
  final int index;
  final String title;
  final Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
            color: decoration?.chipsBacgroundColor ?? Colors.grey,
            borderRadius: BorderRadius.circular(99)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                title,
                style: TextStyle(
                        color: decoration?.chipsForegroundColor ?? Colors.white)
                    .copyWithStyle(style: decoration?.style),
                maxLines: 1,
              ),
            ),
            GestureDetector(
              onTap: () {
                onDelete(index);
              },
              child: Icon(
                Icons.close,
                color: decoration?.chipsForegroundColor ?? Colors.white,
              ),
            )
          ],
        ));
  }
}

class ChipsDecoration {
  final Color? chipsBacgroundColor;
  final Color? chipsForegroundColor;
  final TextStyle? style;
  ChipsDecoration(
      {this.chipsBacgroundColor, this.chipsForegroundColor, this.style});
}

extension CustomTextStyle on TextStyle {
  TextStyle copyWithStyle({TextStyle? style}) {
    return TextStyle(
      inherit: style?.inherit ?? this.inherit,
      color: this.foreground == null && style?.foreground == null
          ? style?.color ?? this.color
          : null,
      backgroundColor: this.background == null && style?.background == null
          ? style?.backgroundColor ?? this.backgroundColor
          : null,
      fontSize: style?.fontSize ?? this.fontSize,
      fontWeight: style?.fontWeight ?? this.fontWeight,
      fontStyle: style?.fontStyle ?? this.fontStyle,
      letterSpacing: style?.letterSpacing ?? this.letterSpacing,
      wordSpacing: style?.wordSpacing ?? this.wordSpacing,
      textBaseline: style?.textBaseline ?? this.textBaseline,
      height: style?.height ?? this.height,
      leadingDistribution:
          style?.leadingDistribution ?? this.leadingDistribution,
      locale: style?.locale ?? this.locale,
      foreground: style?.foreground ?? this.foreground,
      background: style?.background ?? this.background,
      shadows: style?.shadows ?? this.shadows,
      fontFeatures: style?.fontFeatures ?? this.fontFeatures,
      decoration: style?.decoration ?? this.decoration,
      decorationColor: style?.decorationColor ?? this.decorationColor,
      decorationStyle: style?.decorationStyle ?? this.decorationStyle,
      decorationThickness:
          style?.decorationThickness ?? this.decorationThickness,
      fontFamily: style?.fontFamily ?? this.fontFamily,
      fontFamilyFallback: style?.fontFamilyFallback ?? this.fontFamilyFallback,
      overflow: style?.overflow ?? this.overflow,
    );
  }
}
