import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/meals/state/notifiers/meals_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchForMeals extends ConsumerStatefulWidget {
  const SearchForMeals({super.key});

  @override
  ConsumerState<SearchForMeals> createState() => _SearchForMealsState();
}

class _SearchForMealsState extends ConsumerState<SearchForMeals> {
  final TextEditingController mealSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: mealSearchController,
      onChanged: (value) {
        ref.read(searchProvider.notifier).updateQuery(value);
      },

      decoration: InputDecoration(
        hintText: 'Explore dishes',
        hintStyle: TextStyle(color: AppColor.fieldText),
        prefixIcon: Icon(Icons.search, color: AppColor.description),
        suffixIcon: mealSearchController.text.isNotEmpty
            ? InkWell(
                onTap: () {
                  mealSearchController.clear();
                  ref.read(searchProvider.notifier).clear();
                },
                child: Icon(Icons.close),
              )
            : null,
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
    );
  }
}
