import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/core/constants/my_classes/time_box.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/date_box.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/quantity_view.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/time_box.dart';
import 'package:flutter_application_9_klitou/features/meals/models/meal_model.dart';
import 'package:flutter_application_9_klitou/features/orders/models/order_model.dart';
import 'package:flutter_application_9_klitou/features/orders/state/notifiers/order_notifier.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/order_placed_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';


final Mealtimes = [
  TimeBoxF(period: 'Lunch', time: TimeOfDay(hour: 12, minute: 30)),
  TimeBoxF(period: 'Noon', time: TimeOfDay(hour: 13, minute: 15)),
];

late DateTime selectedDate;
late TimeOfDay selectedTime;

class OrderMeal extends ConsumerStatefulWidget {
  final Meal meal;

  const OrderMeal({super.key, required this.meal});

  @override
  ConsumerState<OrderMeal> createState() => _OrderMealState();
}

class _OrderMealState extends ConsumerState<OrderMeal> {
  int selectedIndexTime = 0;

  int selectedIndexDay = 0;
  int quantity = 1;
  DateTime date = DateTime.now();
  TimeOfDay twelveThirty = TimeOfDay(hour: 12, minute: 30);
  final today = DateTime.now();

  List<DateTime> get dates => List.generate(
    7,
    (index) => DateTime(today.year, today.month, today.day + index),
  );
  late DateTime selectedDate;

  TimeOfDay selectedTime = Mealtimes[0].time;

  @override
  void initState() {
    selectedDate = dates[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  widget.meal.image,
                  height: media.height / 2,
                  width: media.width,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print(error);
                    return const Center(child: Text("Image failed to load"));
                  },
                ),

                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 45,
                      ),
                      child: Image.asset(
                        'assets/imgs/back.png',
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              width: media.width,
              decoration: BoxDecoration(
                color: AppColor.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity',
                          style: TextStyle(
                            color: AppColor.fontColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        QuantityView(
                          quantity: (ValueChanged) {
                            quantity = ValueChanged;
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Schedule Delivery ',
                          style: TextStyle(
                            color: AppColor.fontColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Change Date',
                            style: TextStyle(
                              color: AppColor.apptheme,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,

                        itemCount: Mealtimes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: TimeBox(
                              time: Mealtimes[index].time,
                              period: Mealtimes[index].period,
                              isSelected: selectedIndexTime == index,
                              onTap: () {
                                setState(() {
                                  selectedIndexTime = index;
                                  selectedTime =
                                      Mealtimes[selectedIndexTime].time;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Schedule Delivery ',
                          style: TextStyle(
                            color: AppColor.fontColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        InkWell(
                          onTap: () {},
                          child: Text(
                            'View Calendar',
                            style: TextStyle(
                              color: AppColor.apptheme,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: DateBox(
                              dayName: DateFormat('EEE').format(dates[index]),
                              dayDate: dates[index].day.toString().padLeft(
                                2,
                                '0',
                              ),
                              isSelected: selectedIndexDay == index,
                              onTap: () {
                                setState(() {
                                  selectedIndexDay = index;
                                  selectedDate = dates[selectedIndexDay];
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 48),

                    SizedBox(height: 32),
                    InkWell(
                      onTap: () async {
                        date = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );

                        final order = Order(
                          
                          meal: widget.meal, 
                          price: widget.meal.price, 
                          quantity: quantity, 
                          deliveryDate: date);

                        if (date.difference(DateTime.now()) <
                            Duration(hours: 12)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Orders must be placed at least 12 hours in advance.",
                              ),
                            ),
                          );
                          return;
                        }
                        try {
                          await ref.read(allOrdersProvider.notifier).addOrder(order);

                          if (!context.mounted) return;

                          showModalBottomSheet(
                            backgroundColor: AppColor.backgroundColor,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => OrderPlacedView(date: date),
                          );
                        } catch (e) {
                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to place order: $e'),
                            ),
                          );
                        }

                       
                      },
                      child: Container(
                        height: 55,
                        width: media.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColor.apptheme,
                        ),

                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Add to Cart',
                                style: TextStyle(
                                  color: AppColor.backgroundColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${widget.meal.price} DZ',
                                style: TextStyle(
                                  color: AppColor.backgroundColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
