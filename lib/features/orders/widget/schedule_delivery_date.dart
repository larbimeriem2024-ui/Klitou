
import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';


class ScheduleDeliveryDate extends StatelessWidget {
  const ScheduleDeliveryDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    );
  }
}
