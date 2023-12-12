import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/utils/colors.dart';

class CustomAddButton extends StatelessWidget {
  CustomAddButton({super.key, required this.minwidth, this.onPress});
  final double minwidth;
  void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).width;

    return Center(
      child: MaterialButton(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        minWidth: minwidth,
        height: mediaWidth > 650 ? 35.h : 30.h,
        color: primary,
        onPressed: onPress,
        child: Text(
          "Add ",
          style: TextStyle(
              fontFamily: 'futur',
              color: Colors.white,
              fontSize: mediaWidth > 650 ? 22.sp : 17.sp),
        ),
      ),
    );
  }
}
