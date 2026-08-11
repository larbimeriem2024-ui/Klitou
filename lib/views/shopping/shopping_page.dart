import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common/app_color.dart';
import 'package:flutter_application_9_klitou/common_widgets/billet_card.dart';
import 'package:flutter_application_9_klitou/common_widgets/bought_dish.dart';
import 'package:flutter_application_9_klitou/common_widgets/button.dart';
import 'package:flutter_application_9_klitou/services/order_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';




class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  final TextEditingController promoCode = TextEditingController();
  late Future<List<Map<String, dynamic>>> cartFuture;

@override
void initState() {
  super.initState();
  cartFuture = OrderService.getCart();
}

void refreshCart() {
  setState(() {
    cartFuture = OrderService.getCart();
  });
}
  @override
  Widget build(BuildContext context) {
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
             

              FutureBuilder(future: cartFuture, builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    }

    final dishes = snapshot.data ?? [];
     
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dishes.length,
      itemBuilder:(context, index) {
        final dish = dishes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: () {
             
               
            },
            child: BoughtDish(image: (dish['meals']['image_url']).toString() , title: dish['meals']['name'], price: dish['price'].toString(), quantity: dish['quantity'], date: DateTime.parse(dish['date'],), index: dish['id'], )),
        );

      });

              },),
          
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