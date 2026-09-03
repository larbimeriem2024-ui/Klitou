import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/big_title.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/button.dart';
import 'package:go_router/go_router.dart';


class OrderPlacedView extends StatefulWidget {
  final String item;
  const OrderPlacedView({super.key, required this.item});

  @override
  State<OrderPlacedView> createState() => _OrderPlacedViewState();
}

class _OrderPlacedViewState extends State<OrderPlacedView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SizedBox(
      
      width: media.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SingleChildScrollView(
          
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/imgs/true.png',
                  height: 50,
                  width: 50,
                  color: AppColor.apptheme,
                  ),
              ),

              BigTitle(title: 'Item Added'),
              SizedBox(height: 8),

              Text(
                'You have added ${widget.item} to your Cart ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.description,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),

              SizedBox(height: 16,),
               Button(onClicked: () {
                  context.go('/cart');
                }, 
                color: AppColor.apptheme, title: 'Check Cart', fontColor: AppColor.white, isborder: false), 
                SizedBox(height: 16,),

                Text('or'),

             

                SizedBox(height: 16,),

                Button(onClicked: () {
                  context.go('/menu');
                }, 
                color: AppColor.white, title: 'explore more meals', fontColor: AppColor.apptheme, isborder: true), 

                SizedBox(height: 16,), 
            ],
          ),
        ),
      ),
    );
  }
}
