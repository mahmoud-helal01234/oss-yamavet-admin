import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class SpecialtiesContainer extends StatefulWidget {
  SpecialtiesContainer({
    super.key,
    required this.img,
    required this.text,
    required this.textColor,
    required this.containerColor, required this.imgwidth,
  });
  final String img;
  final String text;
  final Color textColor;
  final Color containerColor;
  final double imgwidth;
  @override
  State<SpecialtiesContainer> createState() => _SpecialtiesContainerState();
}

class _SpecialtiesContainerState extends State<SpecialtiesContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        child: Column(
          children: [
            Image.asset(
              widget.img,
              width: widget.imgwidth,
            ),
            Container(
              width: 90.w,
              height: 20.h,
              decoration: BoxDecoration(
                  color: widget.containerColor,
                  borderRadius: BorderRadius.circular(5.sp)),
              child: Center(
                child: Text(
                  widget.text,
                  style: GoogleFonts.roboto(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: widget.textColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
