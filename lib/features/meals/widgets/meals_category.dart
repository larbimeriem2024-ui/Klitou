import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';

List<String> row = ['All', 'Traditional', 'Healthy', ];

class MealsCategory extends StatefulWidget {
  const MealsCategory({super.key});

  @override
  State<MealsCategory> createState() => _MealsCategoryState();
}

class _MealsCategoryState extends State<MealsCategory> {
  int selected = 0;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                color: selected == index ? AppColor.apptheme : AppColor.rowbox,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 25,
                ),
                child: Text(
                  row[index],
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
    );
  }
}
