import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';


class PetsContainer extends StatefulWidget {
  const PetsContainer({super.key, required this.img, required this.text});
  final String img;
  final String text;

  @override
  State<PetsContainer> createState() => _PetsContainerState();
}

class _PetsContainerState extends State<PetsContainer> {
  bool ontap = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          ontap = !ontap;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 15.w),
        width: 70.w,
        height: 100.h,
        decoration: BoxDecoration(
            color: !ontap ? lightgray : primary,
            borderRadius: BorderRadius.circular(20.sp)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25.sp,
              backgroundImage:
              NetworkImage(
                  "https://yama-vet.com/${widget.img}"),

            ),
            SizedBox(
              height: 10.sp,
            ),
            Text(
              widget.text,
              style: GoogleFonts.roboto(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: !ontap ? Colors.black : Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
