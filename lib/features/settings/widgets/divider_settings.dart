import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';

class DividerSettings extends StatelessWidget {
  const DividerSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Divider(color: AppColor.rowbox, thickness: 0.5),
    );
  }
}
