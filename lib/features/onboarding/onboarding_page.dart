
import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/button.dart';
import 'package:go_router/go_router.dart';


List pages = [
  {
    'image':'assets/imgs/save_time.png',
    'title': 'Save Time',
    'description':'No more waiting 20–30 minutes in line or rushing between classes. Order ahead and pick up when it is ready ',
  },
  {
    'image':'assets/imgs/eat_better.png',
    'title': 'Eat Better',
    'description':'Take a break from the same unhealthy meals. Enjoy fresh, varied food every day. ',
  },
  {
    'image':'assets/imgs/do_not_skip_launch.png',
    'title': 'Do not Skip Lunch',
    'description':'Busy schedule? Grab a meal without sacrificing your study time.',
  }
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController controller = PageController();
  int selectedpage = 0;

  @override
  void initState() {
   
    super.initState();
    controller.addListener((){
      setState(() {
        selectedpage = controller.page?.floor() ?? 0;
      });

    }
      
    );
  }
  
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      
      body: PageView.builder(
        controller: controller,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          var pgs = pages[index] as Map? ?? {};
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: media.width,
                height: media.height *0.6,
                child: Image.asset(pgs['image'].toString(),
                height: media.height * 0.6,
                fit: BoxFit.cover,
                ),
                
              ),
      
              SizedBox(height: 20,),
               Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: pages.map((e) {
                        var index = pages.indexOf(e);
                        return Container(
                          margin: EdgeInsets.all(2),
                          height: 8,
                          width: index == selectedpage? 45: 20,
                          decoration: BoxDecoration(
                            color: index == selectedpage? AppColor.apptheme: AppColor.rowbox,
                            borderRadius: BorderRadius.circular(10),
                            
                          ),
                        );
                        
                      },
                    ).toList()),
              ),

              SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.only(left: 20 , right: 20),
                child: Text(pgs['title'].toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 26
                  ,
                  
                  
                  
                ),),
              ),
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(pgs['description'].toString(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColor.description,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                                ),
                ),
              ),
              SizedBox(height: 20,),

             

                  Expanded(child: SizedBox()),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Button(
                  onClicked: () {
                    selectedpage++;
                    if (selectedpage>=3){
                      context.push('/signup');
                    }
                    controller.animateToPage(selectedpage, duration: Duration(microseconds: 500), curve: Curves.bounceInOut);
                  },
                  color: AppColor.apptheme, 
                  title: 'Next', 
                  fontColor: AppColor.white, 
                  isborder: false),
              ), 

              SizedBox(height: 20,)
              
              
              
      
            ],
          );
          
        },),
    );
  }
}