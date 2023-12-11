import 'package:flutter/material.dart';
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
        margin: EdgeInsets.only(left: 15),
        width: 70,
        height: 100,
        decoration: BoxDecoration(
            color: !ontap ? lightgray : primary,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage:
              NetworkImage(
                  "https://yama-vet.com/${widget.img}"),

            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.text,
              style: GoogleFonts.roboto(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: !ontap ? Colors.black : Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
