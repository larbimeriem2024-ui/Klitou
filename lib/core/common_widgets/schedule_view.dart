import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/core/common_widgets/big_title.dart';
import 'package:flutter_application_9_klitou/core/common_widgets/description_text.dart';
import 'package:flutter/cupertino.dart';

class ScheduleView extends StatefulWidget {
  final Function(DateTime) date;
  const ScheduleView({super.key, required this.date});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  final now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        
        width: media.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15), 
            blurRadius: 20, 
            spreadRadius: 10
          ),
      
            
          ]
      
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigTitle(title: 'Schedule'), 
              SizedBox(height: 8,),
              DescriptionText(title: 'select the timing you want to receive your meal at:  '),
              SizedBox(height: 16,),
              
              SizedBox(
        height: 100,
        child: CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,
      initialDateTime: now,
      minimumDate: now,
       
      
      onDateTimeChanged: (date) {
        final deliveryTime =DateTime(
          date.year, 
          date.month, 
          date.day,
          12,
          0,
          0
        );
        
        widget.date(deliveryTime);
      },
        ),
      ), 
      SizedBox(height: 16,
      ),

      
            ],
          ),
        ),
      
        
      ),
    );
  }
}