import 'package:flutter/material.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.text,
      this.onTap,
      this.size,
      required this.buttomWidth, required this.height});
  final String text;
  void Function()? onTap;
  double? size;
  final double buttomWidth;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: primary,
        child: Container(
          width: buttomWidth,
          height: height,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontFamily: 'futur', color: Colors.white, fontSize: size),
            ),
          ),
        ),
      ),
    );
  }
}
