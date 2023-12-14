import 'package:easy_localization/easy_localization.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';

class NotificationStepper extends StatefulWidget {
  const NotificationStepper({super.key});

  @override
  State<NotificationStepper> createState() => _NotificationStepperState();
}

class _NotificationStepperState extends State<NotificationStepper> {
  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStepIconColor: primary,
      lineStyle: LineStyle(
          lineThickness: 2.sp,
          lineType: LineType.normal,
          defaultLineColor: Colors.white,
          finishedLineColor: Colors.white,
          lineLength: 80.sp),
      padding: EdgeInsets.all(8.sp),
      activeStep: 0,
      activeStepTextColor: primary,
      finishedStepTextColor: Colors.black87,
      showLoadingAnimation: false,
      stepRadius: 8.sp,
      showStepBorder: false,
      maxReachedStep: 2,
      steps: [
        EasyStep(
            customStep: CircleAvatar(
              radius: 8.sp,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 7.sp,
                backgroundColor: Colors.red,
              ),
            ),
            // title: 'Initiated',
            customTitle: Text(
              "Initiated".tr(),
              style: TextStyle(color: Colors.white, fontFamily: 'futuraMd'),
              textAlign: TextAlign.center,
            )),
        EasyStep(
            customStep: CircleAvatar(
              radius: 8.sp,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 7.sp,
                backgroundColor: Colors.red,
                // statusToStepMap[widget.status]! >= 1
                //     ? widget.stepperColor
                //     : Colors.white,
              ),
            ),
            customTitle: Text(
              "Accepted".tr(),
              style: TextStyle(fontFamily: 'futuraMd', color: Colors.white),
              textAlign: TextAlign.center,
            )),
        EasyStep(
            customStep: CircleAvatar(
              radius: 8.sp,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 7.sp,
                backgroundColor: Colors.red,
              ),
            ),
            customTitle: Text(
              "Completed".tr(),
              style: TextStyle(fontFamily: 'futuraMd', color: Colors.white),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
