import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';

class NotificationBox extends StatelessWidget {
  final bool isRead;
  final String icon;
  final String title;
  final String message;
  final String timeAgo;

  const NotificationBox({
    super.key,
    required this.isRead,
    required this.icon,
    required this.title,
    required this.message,
    required this.timeAgo
    
    });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
                width: media.width,
                
                decoration: BoxDecoration(
                  color:  AppColor.white,
                  borderRadius: BorderRadiusDirectional.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: AppColor.fieldBg,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            icon,
                            color: isRead? AppColor.fieldText: AppColor.description,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                  
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      title,
                                      style: TextStyle(
                                        color: AppColor.fontColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                            
                                  Text(
                                    timeAgo,
                                    style: TextStyle(
                                      color: AppColor.description,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8,),             
                              Text(
                                message,
                                style: TextStyle(
                                  color: AppColor.description,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
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