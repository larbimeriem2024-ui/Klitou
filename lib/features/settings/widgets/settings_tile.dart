import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';

class SettingsTile extends StatelessWidget {
  final String image;
  final String title;
  final String? description;
  final VoidCallback? onTap;
  final Widget? trailing;
  const SettingsTile({
    super.key,
    required this.image,
    required this.title,
    this.description,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:  onTap,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.fieldBg,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(image, height: 25, width: 25),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColor.fontColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if(description != null)
                    Text(
                      description!,

                      style: TextStyle(
                        color: AppColor.description,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Image.asset('assets/imgs/arrow.png',
                                        color: AppColor.fieldText,
                                        height: 16,
                                        width: 16,),
          ],
        ),
      ),
    );
  }
}
