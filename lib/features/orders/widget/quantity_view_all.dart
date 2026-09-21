import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/quantity_view.dart';

class QuantityViewAll extends StatelessWidget {
  final ValueChanged<int> quantity;
  const QuantityViewAll({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                          quantity: quantity
                        ),
                      ],
                    );
  }
}