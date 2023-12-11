import 'package:flutter/material.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';

class DashCard extends StatelessWidget {
  const DashCard(
      {super.key, required this.img, required this.text, required this.size});
  final String img;
  final String text;
  final double size;
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).width;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: .43 * mediaWidth,
        height: 150,
        decoration: BoxDecoration(
            border: Border.all(color: primary),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(img),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(
                  fontFamily: 'futur', color: primary, fontSize: size),
            )
          ],
        ),
      ),
    );
  }
}
