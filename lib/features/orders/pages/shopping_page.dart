import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/total_Price.dart/widget/billet_card.dart';
import 'package:flutter_application_9_klitou/core/common_widgets/button.dart';
import 'package:flutter_application_9_klitou/features/orders/state/notifiers/order_notifier.dart';
import 'package:flutter_application_9_klitou/features/orders/widget/bought_dish.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';




class ShoppingPage extends ConsumerStatefulWidget {
  const ShoppingPage({super.key});

  @override
  ConsumerState<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends ConsumerState<ShoppingPage> {
  final TextEditingController promoCode = TextEditingController();
 


  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(allOrdersProvider);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8,),
              Text('Selected items',
              style: TextStyle(
                color: AppColor.description , 
                fontSize: 16, 
                fontWeight: FontWeight.w400,
              )
              ),

              SizedBox(height: 16,),

              orders.when(data: (orders) {
                print('$orders');
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: BoughtDish(order: order, onDelete: () async{
                       await ref.read(allOrdersProvider.notifier).deleteOrder(index);
                      }, ),
                    );
                  }, );
              },
              error: (error, stackTrace) => Text('Error: $error'),
              
              loading: () => CircularProgressIndicator(),
              ),
             

             
          
              BilletCard(), 

              SizedBox(height: 32,),
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     

                    Expanded(
                      child: TextFormField(
                                  controller: promoCode,
                                  validator:(valule) {
                            return null;
                            
                          }, 
                                  autocorrect: false,
                                  style: TextStyle(
                                    color: AppColor.fontColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    
                                    
                              
                                  ),
                              
                                  decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Image.asset( 'assets/imgs/promo_code.png',
                                  width: 8,
                                  height: 8,),
                                      ),
                                    filled: true,
                                    fillColor: AppColor.fieldBg,
                                  
                                    hint: Text(
                                      'Promo Code',
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
                    SizedBox(width: 8,),
                    InkWell(
                          onTap: () {
                            
                          },
                          child: Container(
                            
                            
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColor.backgroundColor,
                              border:  Border.all(
                                color: AppColor.apptheme
                              ),
                          
                          
                              
                            ),
                          
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text('apply', 
                                style: TextStyle(
                                  color: AppColor.apptheme,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20
                                
                                
                                ),
                                ),
                              ),
                            ),
                          ),
                        )


                  ],
                ),
                
              ) ,
              
              
          SizedBox(height: 101,)
              
              
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Button(
            onClicked: () async{
              final response = await Supabase.instance.client.functions.invoke(
                'checkout',
                 );

              print(response.data);
              final paymentUrl = response.data['payment_url'];

print(paymentUrl);

final url = Uri.parse(response.data['payment_url']);

await launchUrl(
  url,
  mode: LaunchMode.externalApplication,
);
            }, 
            color: AppColor.apptheme, 
            title: 'Check Now', 
            fontColor: AppColor.backgroundColor, 
            isborder: false),
        )),
    );
  }
}