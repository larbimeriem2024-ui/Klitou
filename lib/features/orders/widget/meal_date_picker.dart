import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/date_box.dart';
import 'package:intl/intl.dart';

class MealDatePicker extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onPressed;
  final List<DateTime> availableDates;
  const MealDatePicker({super.key, required this.selectedIndex, required this.availableDates, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: DateBox(
                              dayName: DateFormat(
                                'EEE',
                              ).format(availableDates[index]),
                              dayDate: availableDates[index].day
                                  .toString()
                                  .padLeft(2, '0'),
                              isSelected: selectedIndex == index,
                              onTap: () => onPressed(index),
                            ),
                          );
                        },
                      ),
                    );
  }
}