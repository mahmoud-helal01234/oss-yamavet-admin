import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yama_vet_admin/core/helper/stepper.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/widgets/notification_stepper.dart';

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height; //!900
    double mediaWidth = MediaQuery.sizeOf(context).width; //!400
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: mediaHeight > 900 ? 10 : 5,
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "Order #21669",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'futuraMd',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: mediaHeight > 900
                  ? .7 * mediaWidth
                  : .4 * MediaQuery.sizeOf(context).width,
            ),
            const Text(
              "50\$",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Fluffy, Spoty',
            style: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              weight: 30,
              color: Colors.white,
            ),
            Text(
              "5 November",
              style: GoogleFonts.roboto(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            //^backend
            Stack(
              children: [
                SizedBox(
                  width: 150,
                  height: 55,
                  child: Image.asset(
                    "assets/images/spoty.png",
                    width: 50,
                    height: 30,
                  ),
                ),
                Positioned(
                  right: 75,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5, right: 6, top: 2),
                    child: Image.asset(
                      "assets/images/fluffy.png",
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        //!google maps
        const Row(
          children: [
            Icon(
              Icons.location_on,
              size: 27,
              color: Colors.white,
            ),
            Text(
              "Sorrento Vally , Sen Diego, CA",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        NotificationStepper(),
        const Divider(
          color: Colors.white60,
          thickness: 1,
          endIndent: 10,
          indent: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //^backend
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Order #21669",
                    style: TextStyle(
                        fontFamily: 'futuraMd',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: mediaHeight > 900
                      ? .7 * mediaWidth
                      : .4 * MediaQuery.sizeOf(context).width,
                ),
                const Text(
                  "50\$",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            //^backend
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Max',
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  weight: 30,
                  color: Colors.white,
                ),
                Text(
                  "5 November",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
                SizedBox(
                  width: mediaHeight > 900
                      ? .67 * mediaWidth
                      : .38 * MediaQuery.sizeOf(context).width,
                ),
                Image.asset("assets/images/max.png")
              ],
            ),
            //!google maps
            const Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 27,
                  color: Colors.white,
                ),
                Text(
                  "Sorrento Vally , Sen Diego, CA",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: mediaHeight > 900 ? 50 : 10,
                ),
                Image.asset(
                  "assets/images/dr.png",
                ),
                SizedBox(
                  width: mediaHeight > 900 ? 30 : 5,
                ),
                Image.asset(
                  "assets/images/icon_doctor.png",
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "Dr. Benjamin Carter",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: mediaHeight > 900 ? .5 * mediaWidth : 5,
                ),
                Column(
                  children: [
                    //^backend
                    Row(
                      children: [
                        const Text(
                          "Rating",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.white),
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.yellow[600],
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          "4.7",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        Text(
                          "/5",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //*notification stepper
            NotificationStepper(),
          ],
        ),
      ],
    );
  }
}
