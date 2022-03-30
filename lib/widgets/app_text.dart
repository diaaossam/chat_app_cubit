import 'package:chat_app/shared/helper/size_config.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String text;
  Color? color;
  double? textSize;
  FontWeight? fontWeight;
  TextDecoration? textDecoration;
  TextAlign? align;
  bool? isTitle;

  AppText(
      {required this.text,
      this.color,
      this.textSize,
      this.isTitle = false,
      this.fontWeight,
      this.textDecoration,
      this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align == null ? null : align,
      style: isTitle == true
          ? TextStyle(
              decoration: textDecoration == null ? null : textDecoration,
              fontSize: textSize == null ?
              getProportionateScreenWidth(28):
           getProportionateScreenHeight(textSize!),
              fontWeight: FontWeight.bold,
              color: color == null ? Colors.black : color,
              height: 1.5,
            )
          : TextStyle(
              decoration: textDecoration == null ? null : textDecoration,
              color: color == null ? Colors.black : color,
              fontSize: textSize == null
                  ? getProportionateScreenHeight(20.0)
                  : getProportionateScreenHeight(textSize!),
              fontWeight: fontWeight == null ? FontWeight.w400 : fontWeight,
            ),
    );
  }
}
