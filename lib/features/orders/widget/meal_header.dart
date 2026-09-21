import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/meals/models/meal_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class MealHeader extends ConsumerStatefulWidget {
  final Meal meal;
  const MealHeader({super.key , required this.meal});

  @override
  ConsumerState<MealHeader> createState() => _MealHeaderState();
}

class _MealHeaderState extends ConsumerState<MealHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.meal.title,
                          style: TextStyle(
                            color: AppColor.apptheme,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.fieldBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColor.rowbox),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/imgs/star.png',
                                  height: 20,
                                  width: 20,
                                  color: AppColor.apptheme,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '4.8',
                                  style: TextStyle(
                                    color: AppColor.apptheme,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
  }
}