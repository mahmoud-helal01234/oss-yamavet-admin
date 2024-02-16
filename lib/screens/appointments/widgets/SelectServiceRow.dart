import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
// import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SelectServiceRow extends StatefulWidget {
  SelectServiceRow(
      {super.key,
      this.ontap,
      required this.text,
      required this.price,
      required this.checkbox});

  final String text;
  final String price;
  void Function()? ontap;
  bool checkbox;

  @override
  State<SelectServiceRow> createState() => _SelectServiceRowState();
}

class _SelectServiceRowState extends State<SelectServiceRow> {
  bool remeberMe = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: .02.sw, right: .02.sw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 0.65.sw,
            child: Text(
              widget.text,
              style: TextStyle(
                height: 0,
                fontSize: 13,
                color: remeberMe ? primary : Colors.black,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.clip,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 0.15.sw,
                child: Text(
                  "${widget.price}\$",
                  style: TextStyle(height: 0, color: Colors.green[600]),
                ),
              ),
              SizedBox(
                width: 0.07.sw,
                child: Checkbox(
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
                    value: widget.checkbox,
                    onChanged: (val) {
                      widget.ontap!.call();
                      setState(() {
                        widget.checkbox = val!;
                      });
                    }),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
