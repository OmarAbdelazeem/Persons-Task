import 'package:flutter/material.dart';
import 'package:sofico_task/res/app_colors.dart';

class CustomButton extends StatelessWidget {
 final void Function()? onPressed;
 final String title;
 CustomButton({required this.onPressed,required  this.title});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 45,
        color: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed:onPressed,
      elevation:0,
      highlightColor: Colors.transparent,
      focusElevation: 0,
      child: Center(
        child: Text(title,style: TextStyle(color: AppColors.white),),
      ),
    );

  }
}
