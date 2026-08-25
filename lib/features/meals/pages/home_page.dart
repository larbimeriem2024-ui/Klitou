

import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/meals/pages/menu_page.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/description_text.dart';
import 'package:flutter_application_9_klitou/features/meals/state/notifiers/meals_notifier.dart';
import 'package:flutter_application_9_klitou/features/meals/widgets/dish_view.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/view_all.dart';
import 'package:flutter_application_9_klitou/features/meals/state/providers/meals_provider.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/order_meal.dart';
import 'package:flutter_application_9_klitou/features/profile/state/providers/profile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List <String> row=[
  'All',
  'Traditional',
  'Healthy',
  'Easter',
];

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key,});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
 
  bool isloadingp= false;
  int selected = 0;
  int index = 0;
  
  final TextEditingController mealSearchController = TextEditingController();  
  @override
  Widget build(BuildContext context) {
    
    final meals = ref.watch(filteredMealsProvider);
    final profileAsync = ref.watch(currentProfileProvider);
    

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),

              profileAsync.when(
                    data: (profile) {
                    return  Row(
                children: [
                  Text(
                    'hey, ',
                    style: TextStyle(
                      color: AppColor.fontColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  
                  Expanded(
                    child: Text(profile.name,
                      style: TextStyle(
                        color: AppColor.apptheme,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              );
                  }, 
                  error: (error, stackTrace) => Text(error.toString()), 
                  loading: () => CircularProgressIndicator(),),

             

              SizedBox(height: 2),
              DescriptionText(title: 'Ready for your next study session meal?'),

              SizedBox(height: 32),

              TextField(
                controller: mealSearchController,
                onChanged: (value) {
                  ref.read(searchProvider.notifier).updateQuery(value);
                },
              
                decoration: InputDecoration(
                  hintText: 'Explore dishes',
                  hintStyle: TextStyle(color: AppColor.fieldText),
                  prefixIcon: Icon(Icons.search, color: AppColor.description),
                  suffixIcon: mealSearchController.text.isNotEmpty? InkWell(
                    onTap: () {
                      mealSearchController.clear();
                      ref.read(searchProvider.notifier).clear();
                    },
                    child: Icon(Icons.close),
                  ): null,
                  filled: true,
                  fillColor: AppColor.fieldBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: AppColor.apptheme, width: 1),
                  ),
                ),
              ),

              SizedBox(height: 32),
              
              SizedBox(
                height: 45,

                child: ListView.builder( 
                  scrollDirection: Axis.horizontal,
                  itemCount: row.length,
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
                        color: selected == index? AppColor.apptheme: AppColor.rowbox,
                        borderRadius: BorderRadius.circular(20)
                                    
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                        child: Text(row[index],
                        style: TextStyle(
                          color: selected == index ?AppColor.white: AppColor.description,
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                        ),
                        ),
                      ),
                                    
                    ),
                  );
                },),
              ),

              SizedBox(height: 32,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    'Explore dishes ',
                    style: TextStyle(
                      color: AppColor.fontColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  ViewAll(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MenuPage(),));
                  },),
                ],
              ),

              SizedBox(height: 32),

              meals.when(
                data: (meals) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      var dish = meals[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: DishView(
                          
                        meal: dish ,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderMeal(meal: dish),));
                          
                        },),
                      );
                    }, );
                }, 
                error: (error, stackTrace) {
                  return Text('Error: $error'); 
                  },
                loading: (){
                   return CircularProgressIndicator();})
 
       
                
            ],
          ),
        ),
      ),
    );
  }
}
