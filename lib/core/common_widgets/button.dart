
import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
class Button extends StatelessWidget {

  final VoidCallback onClicked;
  final Color color;
  final String title;
  final Color fontColor;
  final bool isborder ;

  const Button({super.key,required this.onClicked, required this.color, required this.title, required this.fontColor, required this.isborder });

  @override
  Widget build(BuildContext context) {
   var media = MediaQuery.of(context).size;
    return InkWell(
      onTap: onClicked,
      child: Container(
        height: 55 ,
        width: media.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
          border:  isborder == true ? Border.all(color: AppColor.apptheme) : null,
      
      
          
        ),
      
        child: Center(
          child: Text(title, 
          style: TextStyle(
            color: fontColor,
            fontWeight: FontWeight.w500,
            fontSize: 20
          
          
          ),
          ),
        ),
      ),
    );
  }
}