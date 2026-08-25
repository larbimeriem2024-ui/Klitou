import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/description_text.dart';
import 'package:flutter_application_9_klitou/features/total_Price.dart/state/provider/tota_price_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class BilletCard extends ConsumerWidget {
   BilletCard({super.key});

  final TextEditingController promoCode = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final totalPrice = ref.watch(totalPriceProvider);

    
    
    return Card(
      color: AppColor.white,
        child:Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Summary',
                style: TextStyle(
                  color: AppColor.fontColor,
                  fontSize: 16, 
                  fontWeight: FontWeight.w600
                ),
                
                ), 
          
             SizedBox(height: 16,),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       
                  children: [
                    DescriptionText(title: 'SubTotal'),
                    Text(
                      '700',
                      style: TextStyle(
                        color: AppColor.description,
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                      ),
                      )
                  ],
                ),



                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       
                  children: [
                    DescriptionText(title: 'Delivery Fee'),
                    Text(
                      '100.00',
                      style: TextStyle(
                        color: AppColor.description,
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                      ),
                      )
                  ],
                ),


                Divider(
                  color: AppColor.description,
                  thickness: 0.5,
                ), 


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       
                  children: [
                    Text('Total Amount',
                    style: TextStyle(
                      color: AppColor.fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600

                    ),
                    ),
                    Text(
                      totalPrice.toString(),
                      style: TextStyle(
                        color: AppColor.apptheme,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                      ), 
                      
                  ],

                  

                ),

               
            ],
          ),
        )




    );
  }
}