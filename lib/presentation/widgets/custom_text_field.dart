import 'package:flutter/material.dart';
import 'package:sofico_task/res/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  CustomTextField({
    required this.hintText,
    required this.controller,
    this.onTap,
    this.validator,
    this.keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onTap: onTap,
      keyboardType: keyboardType,
      controller: controller,
      readOnly: onTap != null ? true : false,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 0.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0.0),
        ),
        enabledBorder: OutlineInputBorder(),
      ),
    );
  }
}
