import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/core/common_widgets/big_title.dart';
class QuantityView extends StatefulWidget {
  final Function(int) quantity;
  const QuantityView({super.key, required this.quantity});

  @override
  State<QuantityView> createState() => _QuantityViewState();
}

class _QuantityViewState extends State<QuantityView> {
   int initialQuantity = 1 ;

  void increaseQuantity (){
    initialQuantity++;
    setState(() {
      
    });
    widget.quantity(initialQuantity);
  }

  void decreaseQuantity (){
    initialQuantity--;
    setState(() {
      
    });
    widget.quantity(initialQuantity);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColor.rowbox
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: (){
                if(initialQuantity>0){
                decreaseQuantity();
                }
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColor.backgroundColor
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/imgs/minus.png',
                  height: 20,
                  width: 20,),
                ),
              ),
            ),
            
            
            SizedBox(width: 16,),
            BigTitle(title: initialQuantity.toString()),
            SizedBox(width: 16,),
            
            
             InkWell(
              onTap: (){
                
                increaseQuantity();
                
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColor.apptheme
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('assets/imgs/plus.png'),
                ),
              ),
            ),
            
            
            
            
          ],
        ),
      ),
    
      
    );
  }
}