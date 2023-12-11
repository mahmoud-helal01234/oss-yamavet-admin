import 'package:flutter/material.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';

class ReminderBody extends StatelessWidget {
  const ReminderBody(
      {super.key,
      required this.doctorName,
      required this.sendDate,
      required this.text,
      required this.width,
      required this.height,
      required this.textAlign});
  final String doctorName;
  final String sendDate;
  final String text;
  final double width;
  final double height;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: primary,
                backgroundImage:
                    ExactAssetImage("assets/images/female_one.png"),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  sendDate,
                  style: TextStyle(
                      color: Colors.grey[400], fontWeight: FontWeight.w500),
                )
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: mediaWidth > 650 ? 20 : 10),
              child: MaterialButton(
                // elevation: 5,
                minWidth: 100,
                height: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: Colors.red,
                onPressed: () {},
                child: const Text("Delete",
                    style: TextStyle(
                        fontFamily: 'futur',
                        color: Colors.white,
                        fontSize: 15)),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Card(
            elevation: 7,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: Color(0xffefefef),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                      height: 2,
                      fontSize:
                          MediaQuery.sizeOf(context).width > 650 ? 17 : 13),
                  textAlign: textAlign,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.grey,
          thickness: .5,
          endIndent: 10,
          indent: 10,
        )
      ],
    );
  }
}
