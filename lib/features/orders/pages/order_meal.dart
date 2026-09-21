import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/core/constants/my_classes/time_box.dart';
import 'package:flutter_application_9_klitou/features/orders/state/providers/cart_provider.dart';
import 'package:flutter_application_9_klitou/features/orders/widget/meal_date_picker.dart';
import 'package:flutter_application_9_klitou/features/orders/widget/meal_header.dart';
import 'package:flutter_application_9_klitou/features/orders/widget/meal_time_picker.dart';
import 'package:flutter_application_9_klitou/features/orders/widget/quantity_view_all.dart';
import 'package:flutter_application_9_klitou/features/orders/widget/schedule_delivery_calendar.dart';
import 'package:flutter_application_9_klitou/features/orders/widget/schedule_delivery_date.dart';
import 'package:flutter_application_9_klitou/features/meals/models/meal_model.dart';
import 'package:flutter_application_9_klitou/features/orders/models/cart_item_model.dart';
import 'package:flutter_application_9_klitou/features/orders/pages/order_added_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final mealtimes = [
  TimeBoxF(period: 'Lunch', time: TimeOfDay(hour: 12, minute: 30)),
  TimeBoxF(period: 'Noon', time: TimeOfDay(hour: 13, minute: 15)),
];

class OrderMeal extends ConsumerStatefulWidget {
  final Meal meal;

  const OrderMeal({super.key, required this.meal});

  @override
  ConsumerState<OrderMeal> createState() => _OrderMealState();
}

class _OrderMealState extends ConsumerState<OrderMeal> {
  int quantity = 1;
  int selectedIndexTime = 0;
  int selectedIndexDay = 0;

  final DateTime now = DateTime.now();

  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = _availableDates[0];
    selectedTime = mealtimes.first.time;
  }

  List<DateTime> get _availableDates => List.generate(7, (index) {
    final date = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(Duration(days: index));
    return date;
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var state = ref.watch(cartProvider);
    var isLodading = state.isLoading;
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
                    return const Center(child: Text("Image failed to load"));
                  },
                ),

                InkWell(
                  onTap: () {
                    context.pop();
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
                    MealHeader(meal: widget.meal),
                    SizedBox(height: 16),
                   QuantityViewAll(quantity: (value) {
                     quantity = value;
                   },),

                    SizedBox(height: 16),

                    SizedBox(height: 16),
                    ScheduleDeliveryDate(),
                    SizedBox(height: 16),

                    MealTimePicker(
                      mealtimes: mealtimes,
                      selectedIndex: selectedIndexTime,
                      onSelected: (index) {
                        setState(() {
                          selectedIndexTime = index;
                          selectedTime = mealtimes[selectedIndexTime].time;
                        });
                      },
                    ),
                    SizedBox(height: 32),
                    ScheduleDeliveryCalendar(),
                    SizedBox(height: 16),
                    

                    MealDatePicker(selectedIndex: selectedIndexDay, availableDates: _availableDates, onPressed: (index) { setState(() {
                                  selectedIndexDay = index;
                                  selectedDate =
                                      _availableDates[selectedIndexDay];
                                });
                      
                    },),

                    SizedBox(height: 48),

                    
                    InkWell(
                      onTap: () async {
                        final deliveryAt = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );

                        // must be ordered at least 12 hs in advance
                        if (deliveryAt.difference(DateTime.now()) <
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
                        final cartItem = CartItem(
                          meal: widget.meal,
                          price: widget.meal.price,
                          quantity: quantity,
                          deliveryAt: deliveryAt,
                        );
                        try {
                          await ref
                              .read(cartProvider.notifier)
                              .addToCart(cartItem);

                          if (!context.mounted) return;

                          showModalBottomSheet(
                            backgroundColor: AppColor.backgroundColor,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) =>
                                OrderPlacedView(item: widget.meal.title),
                          );
                        } catch (e) {
                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to add item to cart: $e'),
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
                                isLodading ? 'Adding To Cart' : 'Add To Cart',
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
