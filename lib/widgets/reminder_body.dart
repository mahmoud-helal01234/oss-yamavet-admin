import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';

import '../controllers/RemindersProvider.dart';

class ReminderBody extends StatelessWidget {
  const ReminderBody(
      {super.key,
      required this.reminderIndex,
      required this.width,
      required this.height,
      required this.textAlign});
  final int reminderIndex;
  final double width;
  final double height;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 20.w,
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.sp)),
              child: CircleAvatar(
                radius: 30.sp,
                backgroundColor: primary,
                backgroundImage:
                    ExactAssetImage("assets/images/female_one.png"),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Provider.of<RemindersProvider>(context, listen: true).reminders[reminderIndex].client !=
                      null &&
                      Provider.of<RemindersProvider>(context, listen: true).reminders[reminderIndex]
                          .client!.name !=
                          null
                      ? Provider.of<RemindersProvider>(context, listen: true)
                      .reminders[reminderIndex].client!.name!
                      : "client",
                  style: TextStyle(
                      fontSize: mediaWidth > 650 ? 15.sp : 17.sp,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  Provider.of<RemindersProvider>(context, listen: true)
                      .reminders[reminderIndex].appointmentDate!,
                  style: TextStyle(
                      fontSize: mediaWidth > 650 ? 10.sp : 12.sp,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: mediaWidth > 650 ? 20.w : 10.w),
              child: MaterialButton(
                // elevation: 5,
                minWidth: 100.w,
                height: 30.h,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.sp)),
                color: Colors.red,
                onPressed: () {
                  Provider.of<RemindersProvider>(context, listen: false)
                      .delete(context, reminderIndex);
                },
                child: Text("Delete".tr(),
                    style: TextStyle(
                        fontFamily: 'futur',
                        color: Colors.white,
                        fontSize: 15.sp)),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Center(
          child: Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp)),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: Color(0xffefefef),
                  borderRadius: BorderRadius.circular(10.sp)),
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Text(
                  Provider.of<RemindersProvider>(context, listen: true)
                      .reminders[reminderIndex].description!,
                  style: TextStyle(
                      height: 2.h,
                      fontSize:
                          MediaQuery.sizeOf(context).width > 650 ? 9.w : 13.w),
                  textAlign: textAlign,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
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
