import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/profile_item.dart';
import 'package:flutter_application_9_klitou/features/profile/state/providers/profile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



List items = [
  {
    'icon':'assets/imgs/shopping_bag.png',
    'title':'My orders',
  },

  {
    'icon':'assets/imgs/ticket.png',
    'title':'Subscription',
  },

  {
    'icon':'assets/imgs/notification_profile.png',
    'title':'Notification',
  },

  {
    'icon':'assets/imgs/integoration.png',
    'title':'help & support',
  },

   {
    'icon':'assets/imgs/settings.png',
    'title':'settings',
  },






];




List pages = [
  '/orders',
  '/subscriptions',
  '/notifications',
  '/help',
  '/settings',



];

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    
  final profileAsync = ref.watch(currentProfileProvider);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      
                      decoration: BoxDecoration(
                        color: AppColor.white,
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
                
                
                
                
                    SizedBox(height: 5,),

                    profileAsync.when(data: (profile) {
                      return Column(
                        children: [

                          Text(profile.name,
                      style: TextStyle(
                        color: AppColor.fontColor, 
                        fontWeight: FontWeight.w700,
                        fontSize: 16, 
                      ),
                      ), 
                
                     SizedBox(height: 2,),
                
                    Text(profile.email,
                      style: TextStyle(
                        color: AppColor.description, 
                        fontWeight: FontWeight.w400,
                        fontSize: 14, 
                      ),
                      ), 

                        ],
                      );
                    }, 
                    error: (error, stackTrace) => Text(error.toString()), 
                    loading: () => CircularProgressIndicator(),)
                
                     
                
                      
                  ],
                ),
              ),

              SizedBox(height: 32,),

             ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var eachitem = items[index] as Map? ?? {};
                var eachpage = pages[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ProfileItem(
                    image: eachitem['icon'], 
                    title: eachitem['title'], 
                    thePage: eachpage,),
                );
              },
             ),

             SizedBox(height: 32,),

             
             






          
          
            ],
          ),
        ),
      )
    );
  }
}