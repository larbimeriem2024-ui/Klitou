import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/subscription_box.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/why_subscribe.dart';
import 'package:flutter_application_9_klitou/views/profile/notification_page.dart';

List subs = [
  {
    'isWhite': true,
    'status':'Essential',
    'image': 'assets/imgs/meal.png',
    'title':'Weekly Starter',
    'price':'1000 Dz',
    'period': 'week',
    's1':'5 healthy student meals',
    's2':'standard delivery',
    's3':'15% off all meals',
  },

  {
    'isWhite': false,
    'status':'Most Popular',
    'image': 'assets/imgs/most_popular.png',
    'title':'Monthly Gourmet',
    'price':'2000 Dz',
    'period': 'month',
    's1':'25 chef-curated meals',
    's2':'priority delivery',
    's3':'20% off all orders',
  },

  {
    'isWhite': true,
    'status':'Best Value',
    'image': 'assets/imgs/best_value.png',
    'title':'Semester Elite',
    'price':'3000 Dz',
    'period': 'semester',
    's1':'unlimited standard meals',
    's2':'Priority Delivery',
    's3':'Free weekend dessert',
  },

];

List whySubs = [
  {
    'icon':'assets/imgs/big_savings.png',
    'title':'Big Savings',
  },

  {
    'icon':'assets/imgs/timer_saver.png',
    'title':'Time Saver',
  },

  {
    'icon':'assets/imgs/reliable.png',
    'title':'Reliable',
  },

  {
    'icon':'assets/imgs/nutrition.png',
    'title':'Nutrition',
  },
];


class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {

  int isSelected = 0;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor : AppColor.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: AppColor.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/imgs/back.png', 
                height: 25,
                width: 25,
                
                
                
                ),
            ), 
            
            Text(
             'Subscription',
              style: TextStyle(
                color: AppColor.apptheme, 
                fontSize: 24,
                fontWeight: FontWeight.w600
              ),
              ),
        
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(),));
              },
              child: Image.asset(
                'assets/imgs/bell.png', 
                height: 25,
                width: 25,
                
                
                
                ),
            ), 
        
        
        
          ],
        ),
      ),
     body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 45),
        child: Column(

          children: [

            Stack(
              children: [
               ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(20),
                child: Image.asset('assets/imgs/fuel_your_ambition.png')),

                Container(
                        width: media.width,
                        height: 176,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color(0xFF076148).withValues(alpha: 0.7), // Dark
                              Color(
                                0xFF0B7A5A,).withValues(alpha: 0.4), // Slightly lighter
                              Color(
                                0xFF10966E,).withValues(alpha: 0.2), // Even lighter
                            ],
                            stops: [0.0, 0.5, 1.0],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fuel Your Ambition',
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Premium meal plans designed for student life.',
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
          ]),
            SizedBox(height: 32,), 

            Container(
              width: media.width/2 +16,
              decoration: BoxDecoration(
                color: AppColor.rowbox,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelected = 0;
                        });
                      },
                      child: Container(
                        width: media.width / 4,
                        decoration: BoxDecoration(
                          color: isSelected ==0 ? AppColor.apptheme : null, 
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Monthly',
                              style: TextStyle(
                                color: isSelected == 0? AppColor.backgroundColor: AppColor.fontColor,
                                fontSize: 14, 
                                fontWeight: FontWeight.w400
                              ),
                              ),
                          ),
                        ),
                      ),
                    ),
                
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelected = 1;
                        });
                      },
                      child: Container(
                        width: media.width / 4 ,

                        decoration: BoxDecoration(
                          color: isSelected == 1? AppColor.apptheme : Colors.transparent, 
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Center(
                            child: Text(
                              'Quarterly',
                              style: TextStyle(
                                color:isSelected == 1? AppColor.backgroundColor: AppColor.fontColor,
                                fontSize: 14, 
                                fontWeight: FontWeight.w400
                              ),
                              ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32,),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: subs.length,
              itemBuilder: (context, index) {
                var set = subs[index] as Map? ?? {};
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SubscriptionBox(
                    isWhite: set['isWhite'], 
                    status: set['status'], 
                    image: set['image'], 
                    title: set['title'], 
                    price: set['price'], 
                    period: set['period'],
                    s1: set['s1'], 
                    s2: set['s2'], 
                    s3: set['s3']),
                );
              
            },),
            SizedBox(height: 16,),

            Text(
              'Why subscribe?',
              style: TextStyle(
                color: AppColor.fontColor,
                fontSize: 24,
                fontWeight: FontWeight.w700
              ),
              ),
            SizedBox(height: 16,),

            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: whySubs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                 mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                ), 
              itemBuilder: (context, index) {
                var set = whySubs[index] as Map? ?? {};
                return WhySubscribe(icon: set['icon'], title: set['title']);
              },),

              SizedBox(height: 32,),

              Container(
                width: media.width,
                decoration: BoxDecoration(
                  color: AppColor.rowbox,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Have questions about plans?',
                              style: TextStyle(
                                color: AppColor.fontColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400
                              ),
                              ),
                              Text(
                              'Our suppor team is here to help.',
                              style: TextStyle(
                                color: AppColor.description,
                                fontSize: 16,
                                fontWeight: FontWeight.w400
                              ),
                              ),
                          ],
                        ),

                        Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              'assets/imgs/have_questions.png',
                              height: 16,
                              width: 16,
                              ),
                          ),
                        )
                    
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 100,)

            

          ],
        ),
      )),
    );
  }
}