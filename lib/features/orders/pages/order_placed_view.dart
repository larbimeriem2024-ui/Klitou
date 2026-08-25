import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/meals/pages/home_page.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/big_title.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/button.dart';


class OrderPlacedView extends StatefulWidget {
  final DateTime date;
  const OrderPlacedView({super.key, required this.date});

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

              BigTitle(title: 'Order Placed'),
              SizedBox(height: 8),

              Text(
                'Your food has been ordered.\nYou will Inshallah receive your order in this date\n ${widget.date}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.description,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),

              SizedBox(height: 8,),

              Text(
                'code #5218209945',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),

                
                
                ),

                SizedBox(height: 16,),

                Button(onClicked: () {
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (context) => HomePage(),),
                     (route) => false,);
                }, 
                color: AppColor.white, title: 'Go to Home', fontColor: AppColor.apptheme, isborder: true), 

                SizedBox(height: 16,), 
            ],
          ),
        ),
      ),
    );
  }
}
