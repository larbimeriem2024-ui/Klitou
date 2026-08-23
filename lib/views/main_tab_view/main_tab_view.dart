

import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/auth/state/notifier/auth_notifier.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/shopping_page.dart';
import 'package:flutter_application_9_klitou/services/profile_service.dart';
import 'package:flutter_application_9_klitou/features/meals/pages/home_page.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/auth_gate.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/sign_up_page.dart';
import 'package:flutter_application_9_klitou/features/meals/pages/menu_page.dart';
import 'package:flutter_application_9_klitou/views/profile/help_support_page.dart';
import 'package:flutter_application_9_klitou/views/profile/my_orders_page.dart';
import 'package:flutter_application_9_klitou/views/profile/notification_page.dart';
import 'package:flutter_application_9_klitou/views/profile/profile_page.dart';
import 'package:flutter_application_9_klitou/views/settings/settings_page.dart';
import 'package:flutter_application_9_klitou/views/profile/subscription_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
List <String> icons = [
'assets/imgs/home.png',
'assets/imgs/meal.png',
'assets/imgs/cart.png',
'assets/imgs/user.png',
];

List <String> iconsPressed = [
  'assets/imgs/home_pressed.png',
  'assets/imgs/meal_pressed.png',
  'assets/imgs/cart_pressed.png',
  'assets/imgs/user_pressed.png',
  
];



List <String> pagesName = [
'Home',
'Menu',
'Cart',
'Profile'
];

List drawerItems= [
  {
    
    'title':'Home',
    'icon':'assets/imgs/home_pressed.png'
    
  },
   {
    'title':'My orders',
    'icon' :'assets/imgs/meal_pressed.png',
    
  },
   {
    'title':'Subscriptions',
    'icon':'assets/imgs/ticket.png',
    
    
  },
   {
    'title':'Notifications',
    'icon':'assets/imgs/bell.png',
    
    
  },

  {
    'title':'Help & Support',
    'icon':'assets/imgs/integoration.png',
  },
  
  {
    'title':'Settings',
    'icon':'assets/imgs/settings.png',
  },

];





class MainTabView extends ConsumerStatefulWidget {
  
  const MainTabView({super.key, });

  @override
  ConsumerState<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends ConsumerState<MainTabView> {
  bool isLoading = false;

   @override
  void initState() {
    load();
    super.initState();
  }

  Future<void> load() async {
    try {
      print("Loading profile...");
      await Future.delayed(const Duration(milliseconds: 500));

      await ProfileService.loadProfile();

      print(ProfileService.name);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error is in here check loading data $e');
    }
  }

  
 
   int selectedIndex = 0;
   int theSelected = -1 ;
    

   
  
  final PageStorageBucket bucket = PageStorageBucket();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Widget>  pages =[
  HomePage(
    onShowAll: () {
      setState(() {
        selectedIndex = 1;
      });
      
    },
  ),
  MenuPage(),
  ShoppingPage(),
  ProfilePage()
];

late List drawerPage =[
  
  MainTabView(),
  MyOrdersPage(),
  SubscriptionPage(),
  NotificationPage(),
  HelpSupportPage(),
  SettingsPage()
];


  
  
  @override
  Widget build(BuildContext context) {
   
    
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: AppColor.backgroundColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                        'Klitou',
                        style: TextStyle(
                          color: AppColor.apptheme, 
                          fontWeight: FontWeight.w700,
                          fontSize: 24, 
                        ),
                        ),
                SizedBox(height: 32,), 
                Row(
                  children: [
                    Container(
                        height: 50,
                        width: 50,
                        
                        decoration: BoxDecoration(
                          color: AppColor.apptheme,
                          shape: BoxShape.circle,
                         
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ClipOval(
                            
                            child: Image.asset('assets/imgs/menu2.png', 
                            
                            fit: BoxFit.cover,
                            ),
                                          
                            
                            
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                        '${ProfileService.name}',
                        style: TextStyle(
                          color: AppColor.fontColor, 
                          fontWeight: FontWeight.w700,
                          fontSize: 16, 
                        ),
                        ), 
                  
                       SizedBox(height: 2,),
                  
                      Text(
                        '${ProfileService.email}',
                        style: TextStyle(
                          color: AppColor.description, 
                          fontWeight: FontWeight.w400,
                          fontSize: 14, 
                        ),
                        ),  
                  ],
                )
                  
                    
                  ],
                ),
                SizedBox(height: 32,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: drawerItems.length,
                  itemBuilder: (context, index) {
                    var set = drawerItems[index] as Map? ?? {};
                    var pg = drawerPage[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            theSelected = index;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => pg,));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: theSelected !=index? Colors.transparent: AppColor.rowbox,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  set['icon'],
                                  height: 20,
                                  width: 20,
                                  color: AppColor.fontColor,
                                  ),
                                 SizedBox(width: 16,), 
                                Text(
                                  set['title'],
                                  style: TextStyle(
                                    color: AppColor.fontColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                  ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );

                  
                  
                },),

                SizedBox(height: 32,),

                Divider(),

                Expanded(child: SizedBox()),

                GestureDetector(
                  onTap: () async {
                  await ref.read(authNotifierProvider.notifier).logout();
                 
                },
                  child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/imgs/logout.png',
                            height: 25,
                            width: 25,
                          ),
                  
                          SizedBox(width: 8),
                  
                          Text(
                            'Sign Out',
                            style: TextStyle(
                              color: AppColor.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                ),

                    SizedBox(height: 20,)

                
              ],
            ),
          ),
        ),

      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: AppColor.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
             onTap: () {
               _scaffoldKey.currentState?.openDrawer();
             },
              child: Image.asset(
                'assets/imgs/three_bar.png', 
                height: 25,
                width: 25,
                
                
                
                ),
            ), 
            
            Text(
              pagesName[selectedIndex],
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
      body: PageStorage(bucket: bucket, child: pages[selectedIndex]
       ),
     bottomNavigationBar:  SafeArea(child: navbar()),
     
      
      
      
    ); 
        

    
  }
  Widget navbar(){

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 70,
      
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
      ),
        
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: icons.map(( e) {
          int index = icons.indexOf(e);
          
          bool isSelected = index== selectedIndex;
          return Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                
    
                });
              },
              child:
                  Container(
                    
                    height: 52,
                    width: 68.95,
                    
                    decoration: BoxDecoration(
                      color: isSelected? AppColor.fieldBg: Colors.transparent,
                      borderRadius: BorderRadius.circular(12)
                      
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                         isSelected == false? e: iconsPressed[index],
                          height:index == 0 || index == 1 ? 24: 20, 
                          width: index== 2? 25: 20,
                          fit: BoxFit.cover,
                          
                          
                                            ),
                        
                                            SizedBox(height: 2,),
                        
                        Text(
                          pagesName[index],
                          style: TextStyle(
                            color: isSelected == false? AppColor.description : AppColor.apptheme,
                            fontSize: 12,
                          ),
                          )                    
                      ],
                    ),
                  ), 
                  
                  
                
              
            ),
    
          );
        }
        ).toList()
    
        
      ),
      
    ),
  );
}

} 
  