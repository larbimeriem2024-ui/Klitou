import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/my_classes/time_box.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/time_box.dart';

// shared/common_widgets/meal_time_picker.dart
class MealTimePicker extends StatelessWidget {
  final List<TimeBoxF> mealtimes;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const MealTimePicker({
    super.key,
    required this.mealtimes,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mealtimes.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TimeBox(
            time: mealtimes[index].time,
            period: mealtimes[index].period,
            isSelected: selectedIndex == index,
            onTap: () => onSelected(index),
          ),
        ),
      ),
    );
  }
}