import 'package:flutter/material.dart';

import '../shared/styles/styles.dart';
import 'custom_surfix_icon.dart';

class CustomTextFormField extends StatelessWidget {
  bool isPassword;
  TextInputType? type;
  dynamic onChange;
  dynamic validate;
  dynamic onTap;
  dynamic onSaved;
  var controller;

  String lableText;
  String hintText;
  String? suffixIcon;

  CustomTextFormField(
      {this.isPassword = false,
      this.type = TextInputType.text,
      this.onChange,
      this.validate,
      this.onTap,
      this.onSaved,
        this.controller,
      required this.lableText,
      required this.hintText,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword == true ? true : false,
      keyboardType: type,
      onChanged: onChange,
      onSaved: onSaved,
      validator: validate,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: lableText,
        hintText: hintText,
        border: outlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon:
            suffixIcon == null ? null : CustomSurffixIcon(svgIcon: suffixIcon!),
      ),
    );
  }
}
