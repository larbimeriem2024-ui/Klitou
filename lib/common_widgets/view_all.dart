import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common/app_color.dart';


class ViewAll extends StatefulWidget {
  final VoidCallback onPressed;
  const ViewAll({super.key,required this.onPressed});

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: InkWell(
        onTap: widget.onPressed,
        child: Text(
          'See All',
          style: TextStyle(
            color: AppColor.apptheme,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          )),
    );
  }
}