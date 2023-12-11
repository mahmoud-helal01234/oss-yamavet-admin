import 'package:flutter/material.dart';

class EditAndAddContainer extends StatelessWidget {
  const EditAndAddContainer(
      {super.key, required this.enText, required this.arText, required this.arController, required this.enController});
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
          width: .35 * mediaWidth,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: TextField(
              controller: enController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: enText,
                  hintStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey)),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: .35 * mediaWidth,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: EdgeInsets.only(right: 10, top: 8),
            child: TextField(
              controller: arController,
              textDirection:TextDirection.rtl,
              decoration: InputDecoration(

                  border: InputBorder.none,
                  hintText: arText,
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
