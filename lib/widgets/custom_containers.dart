import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditAndAddContainer extends StatelessWidget {
  const EditAndAddContainer(
      {super.key,
      required this.enText,
      required this.arText,
      required this.arController,
      required this.enController});
  final String enText;
  final String arText;
  final TextEditingController arController;
  final TextEditingController enController;
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        Container(
          width: mediaWidth > 650 ? 300.w : .35 * mediaWidth,
          height: 30.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.sp),
              border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: TextField(
              controller: enController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: enText,
                  hintStyle: TextStyle(
                      fontSize: mediaWidth > 650 ? 10.sp : 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey)),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          width: mediaWidth > 650 ? 300.w : .35 * mediaWidth,
          height: 30.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: EdgeInsets.only(right: 10.w, top: 8.h),
            child: TextField(
              controller: arController,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: arText,
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: TextStyle(
                      fontSize: mediaWidth > 650 ? 10.sp : 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
            ),
          ),
        ),
        SizedBox(
          height: 10.sp,
        ),
      ],
    );
  }
}
