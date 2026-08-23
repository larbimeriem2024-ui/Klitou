import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/core/common_widgets/notification_box.dart';

List<String> rowp = ['All', 'Orders', 'Promos'];

List notificationsToday= [
  {
    'isRead': false,
    'icon':'assets/imgs/delivery.png',
    'title':'Your meal is  mins away',
    'timeAgo':'2m ago',
    'message':'Driver Alex is approaching with your order from Sage Kitchen. Get ready!',
  },

   {
    'isRead': false,
    'icon':'assets/imgs/true.png',
    'title':'Order confirmed',
    'timeAgo':'15m ago',
    'message':'YOur order #KL-8291 has been recieved and is being prepared by the chef',
  },
];

List notificationYesterday= [
  {
    'isRead': true,
    'icon':'assets/imgs/delivery.png',
    'title':'new Badge Unlocked',
    'timeAgo':'1d ago',
    'message': "You've reached Regular Student Status, Enjoy your new rewards:!",
  },

   {
    'isRead': true,
    'icon':'assets/imgs/true.png',
    'title':'Login Detected',
    'timeAgo':'1d ago',
    'message':'A new login was detected on a Mac in London. Was this you?',
  },
];



class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
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
              child: Image.asset('assets/imgs/back.png', height: 25, width: 25),
            ),

            Text(
              'Notification',
              style: TextStyle(
                color: AppColor.apptheme,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: rowp.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: selected == index
                              ? AppColor.apptheme
                              : AppColor.rowbox,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 25,
                          ),
                          child: Text(
                            rowp[index],
                            style: TextStyle(
                              color: selected == index
                                  ? AppColor.white
                                  : AppColor.description,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 32),

              Text(
                'TODAY',
                style: TextStyle(
                  color: AppColor.apptheme,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: notificationsToday.length,
                itemBuilder: (context, index) {
                  var set = notificationsToday[index] as Map? ?? {};
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: NotificationBox(
                      isRead: set['isRead'],
                      icon: set['icon'], 
                      title: set['title'], 
                      message: set['message'], 
                      timeAgo: set['timeAgo']),
                  );
                },),
                SizedBox(height: 16,),


                Container(
                width: media.width,
                
                decoration: BoxDecoration(
                  color:  AppColor.fieldBg,
                  borderRadius: BorderRadiusDirectional.circular(15),
                  border: Border.all(
                    color: AppColor.rowbox
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: AppColor.apptheme,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            'assets/imgs/congrats.png',
                            color:  AppColor.white,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                  
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Flash Sale: 20% off Rice Dishes!',
                                      style: TextStyle(
                                        color: AppColor.apptheme,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                            
                                  Text(
                                    '1h ago',
                                    style: TextStyle(
                                      color: AppColor.apptheme,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8,),             
                              Text(
                                'Study fuel alert! Use code RICE20 for an exclusive discount until midnight',
                                style: TextStyle(
                                  color: AppColor.fontColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

                

                SizedBox(height: 32,),
                 Text(
                'YESTERDAY',
                style: TextStyle(
                  color: AppColor.description,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 16,),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: notificationsToday.length,
                itemBuilder: (context, index) {
                  var set = notificationYesterday[index] as Map? ?? {};
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: NotificationBox(
                      isRead: set['isRead'],
                      icon: set['icon'], 
                      title: set['title'], 
                      message: set['message'], 
                      timeAgo: set['timeAgo']),
                  );
                },),
              
              SizedBox(height: 100,),




                

              
            ],
          ),
        ),
      ),
    );
  }
}
