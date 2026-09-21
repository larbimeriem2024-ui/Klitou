import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/settings/widgets/divider_settings.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });


  List<Widget> _buildChildrenWithDividers() {
  final result = <Widget>[];

  for (int i = 0; i < children.length; i++) {
    result.add(children[i]);

    if (i < children.length - 1) {
      result.add(const DividerSettings());
    }
  }

  return result;
}

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColor.apptheme,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16),
        Container(
          
          width: media.width,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(30),
          ),

          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: _buildChildrenWithDividers()),
          ),
        ),
      ],
    );
  }
}
