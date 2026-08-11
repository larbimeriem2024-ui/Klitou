import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common/app_color.dart';
import 'package:flutter_application_9_klitou/common_widgets/dish_view.dart';
import 'package:flutter_application_9_klitou/services/meals_service.dart';
import 'package:flutter_application_9_klitou/views/menu/order_meal.dart';


List <String> row=[
  'All',
  'Traditional',
  'Healthy',
  'Easter',
];




class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selected = 0;
  bool isloadingp = false;
  
  final MealsService mealsService = MealsService();
  final TextEditingController mealSearchController = TextEditingController();

  List <dynamic> meals = [];

  Future <void> searchMeals(String query) async{
    if(query.isEmpty){
      setState(() {
        meals =[];
      });
      return;
    }
    setState(() {
      isloadingp = true;
    });
    
    
    meals = await mealsService.searchMeals(query);
    print(meals);
    setState(() {
      isloadingp = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 8),

              TextField(
                controller: mealSearchController,
                onChanged: searchMeals,
                decoration: InputDecoration(
                  hintText: 'Explore dishes',
                  hintStyle: TextStyle(color: AppColor.fieldText),
                  prefixIcon: Icon(Icons.search, color: AppColor.description),
                  suffixIcon: mealSearchController.text.isNotEmpty? InkWell(
                    onTap: () {
                      mealSearchController.clear();
                      setState(() {
                        
                      });
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
              
          
                Text(
                    'Explore dishes ',
                    style: TextStyle(
                      color: AppColor.fontColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              SizedBox(height: 32,),
          
    mealSearchController.text.isEmpty? FutureBuilder<List<Map<String, dynamic>>>(
                
  future: MealsService.getMeals(),
  builder: (context, snapshot) {

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    }

    final dishes = snapshot.data ?? [];

    return ListView.builder(
      shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
      itemCount: dishes.length,
      itemBuilder: (context, index) {
        final dish = dishes[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DishView(
            image: dish['image_url'],
            name: dish['name'],
            price: dish['price'].toString(),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderMeal(image: dish['image_url'] , title: dish['name'], rank: dish['rating'], id: dish['id'], price: dish['price'],
              ),));
            },
          ),
        );
      },
    );
  },
): meals.isNotEmpty? ListView.builder(
                shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: meals.length,
                itemBuilder: (context, index) {
                  var set = meals[index] as Map? ?? {};
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: DishView(image: set['image_url'], name: set['name'], price: set['price'].toString(), onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderMeal(
                                    image: set['image_url'],
                                    title: set['name'],
                                    rank: set['rating'],
                                    id: set['id'],
                                    price: set['price'],
                                  ),
                                ),
                              );
                            },),
                  );
                },): Center(child: Text(
                  'No meals found :( ',
                  style: TextStyle(
                    color: AppColor.apptheme,
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),
                  ),)
            ],
          ),
        ),
      ),
    );
  }
}
