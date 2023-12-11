import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
// import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SelectRow extends StatefulWidget {
  SelectRow(
      {super.key,
      this.ontap,
      required this.text,
      required this.price,
      required this.checkbox});
  final String text;
  final String price;
  void Function()? ontap;
  final bool checkbox;

  @override
  State<SelectRow> createState() => _SelectRowState();
}

class _SelectRowState extends State<SelectRow> {
  bool remeberMe = false;

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height; //!900

    return Container(
      height: 25,
      child: Row(
        children: [
          SizedBox(
            width:
                mediaHeight > 900 ? 10 : .05 * MediaQuery.sizeOf(context).width,
          ),
          Text(widget.text,
              style: TextStyle(
                height: 0,
                fontSize: 13,
                color: remeberMe ? primary : Colors.black,
                fontWeight: FontWeight.w400,
              )),
          Spacer(),
          Text(
            "${widget.price}\$",
            style: TextStyle(height: 0, color: Colors.green[600]),
          ),
          GestureDetector(
            onTap: widget.ontap,
            child: widget.checkbox
                ? Checkbox(
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (!states.contains(MaterialState.selected)) {
                        return Colors.white;
                      }
                      return null;
                    }),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    side: BorderSide(
                      color: primary,
                      width: 1,
                    ),
                    activeColor: primary,
                    checkColor: Colors.white,
                    value: remeberMe,
                    onChanged: (val) {
                      setState(() {
                        remeberMe = val!;
                      });
                    })
                : Container(
                    margin: EdgeInsets.only(right: 10, left: 10, top: 5),
                    width: 25,
                    height: 50,
                    decoration: BoxDecoration(
                        color: primary, borderRadius: BorderRadius.circular(2)),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/images/edit.svg",
                        width: 20,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
