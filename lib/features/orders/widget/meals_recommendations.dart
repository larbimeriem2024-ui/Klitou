import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/meals/state/notifiers/meals_notifier.dart';
import 'package:flutter_application_9_klitou/features/meals/widgets/recommended_meals.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/view_all.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MealsRecommendations extends ConsumerWidget {
  const MealsRecommendations({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(allMealsProvider);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(
              'Recommended for you ',
              style: TextStyle(
                color: AppColor.fontColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            ViewAll(
              onPressed: () {
                context.go('/menu');
              },
            ),
          ],
        ),

        meals.when(
          data: (meals) {
            return SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, index) {
                  var dish = meals[index];
                  return RecommendedMeals(
                    meal: dish,
                    onTap: () {
                      context.push('/order-meal', extra: dish);
                    },
                  );
                },
              ),
            );
          },
          error: (error, stackTrace) {
            return Text('Error: $error');
          },
          loading: () {
            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}
