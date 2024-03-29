import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hinttext,
      required this.icon,
      required this.width,
      required this.controller});
  final String hinttext;
  final IconData icon;
  final double width;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 45.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: Padding(
        padding: EdgeInsets.only(top: 3.h, bottom: 2.h),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                icon,
                size: MediaQuery.sizeOf(context).width > 650 ? 20.sp : 30.sp,
                color: Colors.grey,
              ),
              hintText: hinttext,
              hintStyle: TextStyle(
                  fontSize:
                      MediaQuery.sizeOf(context).width > 650 ? 10.sp : 20.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
