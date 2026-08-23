import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';

class Textfield extends StatelessWidget {
  final TextEditingController controller ;
  final String title;
  final String icon;
  final String description1;
  final String? Function (String?)? validate;
  final FocusNode somethingFocusNode;

  const Textfield({super.key, required this.controller, required this.title, required this.icon, required this.description1, required this.validate, required this.somethingFocusNode});
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColor.fontColor,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 3),

        Center(
          child: TextFormField(
            controller: controller,
            validator: validate,
            focusNode: somethingFocusNode,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            style: TextStyle(
              color: AppColor.fontColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              
              
        
            ),
        
            decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(icon,
                  color: AppColor.description,
                                width: 8,
                                height: 8,),
                ),
              filled: true,
              fillColor: AppColor.fieldBg,
            
              hint: Text(
                description1,
                style: TextStyle(
                  color: AppColor.fieldText,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColor.fieldBg,
                )
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColor.red
                )
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)

              )
            ),
            
            
          ),
        ),
      ],
    );
      
      

    
  }
}