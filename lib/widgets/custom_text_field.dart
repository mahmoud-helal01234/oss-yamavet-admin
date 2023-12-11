import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hinttext,
      required this.icon,
      required this.width, required this.controller});
  final String hinttext;
  final IconData icon;
  final double width;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: Padding(
        padding: EdgeInsets.only(top: 3, bottom: 2),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                icon,
                size: 30,
                color: Colors.grey,
              ),
              hintText: hinttext,
              hintStyle:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
