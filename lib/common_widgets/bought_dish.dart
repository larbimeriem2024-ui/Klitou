import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common/app_color.dart';
import 'package:flutter_application_9_klitou/common_widgets/delete_item.dart';
import 'package:flutter_application_9_klitou/common_widgets/description_text.dart';
import 'package:flutter_application_9_klitou/notifiers/total_price_notifier.dart';
import 'package:provider/provider.dart';

class BoughtDish extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final int quantity;
  final DateTime date;
  final int index;

  const BoughtDish({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
    required this.date,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Container(
      height: 128,
      width: media.width,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
       
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(15),
              child: Image.network(
                image,
                width: (media.width / 2) - 60,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
        
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: AppColor.fontColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                    '$price DZ',
                    style: TextStyle(
                      color: AppColor.apptheme,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                    ],
                  ),
                  Expanded(child: SizedBox()),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text( 'qty: $quantity ',
                           style: TextStyle(
                            color: AppColor.fontColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                           ),
                           ), 
                           SizedBox(height: 5,),   
                  Row(
                    children: [
                      Image.asset(
                        'assets/imgs/watch.png',
                        height: 16,
                        width: 16,
                        ),

                      SizedBox(width: 5,), 
                      DescriptionText(title: date.toString().split('.').first.substring(0,16)),
                    ],
                  ),

                        ],
                      ),

                       GestureDetector(
                    onTap: () async{
                     await  DeleteItem().showDeleteDialog(context, index);
                      context
                          .read<TotalPriceNotifier>()
                          .removeSubtotalCalc();
                    },
                    child: Image.asset(
                      'assets/imgs/delete.png',
                      height: 18,
                      width: 16,
                      ),
                  ),

                    ],
                  ),
                  
                 
                  
                      
                  
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
