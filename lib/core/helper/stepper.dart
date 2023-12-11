import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StepperScreen extends StatefulWidget {
  StepperScreen(
      {super.key,
      required this.status,
      required this.lineColor,
      required this.stepperColor,
      required this.textColor,
      this.finishColor});
  final Color lineColor;
  final Color stepperColor;
  final Color textColor;
  Color? finishColor;
  String status;

  @override
  State<StepperScreen> createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
 
  int activeStep2 = 0;
  int reachedStep = 0;
  int upperBound = 5;
  double progress = 0.2;
  Set<int> reachedSteps = <int>{0, 2, 4, 5};

  void increaseProgress() {
    if (progress < 1) {
      setState(() => progress += 0.2);
    } else {
      setState(() => progress = 0);
    }
  }
  Map<String,int> statusToStepMap = {

    "initiated" : 0,
    "accepted" : 1,
    "completed" : 2
  };

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      lineStyle: LineStyle(
          lineThickness: 2,
          lineType: LineType.normal,
          defaultLineColor: widget.lineColor,
          finishedLineColor: widget.finishColor,
          lineLength: 80),

      padding: EdgeInsets.all(8),
      activeStep: statusToStepMap[widget.status]!,
      // lineLength: 70,
      // lineSpace: 0,
      // lineType: LineType.normal,
      // defaultLineColor: Colors.white,
      // finishedLineColor: Colors.orange,
      activeStepTextColor: Colors.black87,
      finishedStepTextColor: Colors.black87,
      // internalPadding: 0,
      showLoadingAnimation: false,
      stepRadius: 8,
      showStepBorder: false,
      // lineDotRadius: 1.5,
      maxReachedStep: 2,
      steps: [
        EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                widget.stepperColor,
              ),
            ),
            // title: 'Initiated',
            customTitle: Text(
              "Initiated",
              style: TextStyle(color: widget.textColor, fontFamily: 'futuraMd'),
              textAlign: TextAlign.center,
            )),
        EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                statusToStepMap[widget.status]! >= 1 ? widget.stepperColor : Colors.white,
              ),
            ),
            customTitle: Text(
              "Accepted",
              style: TextStyle(fontFamily: 'futuraMd', color: widget.textColor),
              textAlign: TextAlign.center,
            )),
        EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                statusToStepMap[widget.status]! >= 2  ? widget.stepperColor : Colors.white,
              ),
            ),
            customTitle: Text(
              "Completed",
              style: TextStyle(fontFamily: 'futuraMd', color: widget.textColor),
              textAlign: TextAlign.center,
            )),
      ],
      onStepReached: (index) => setState(() => widget.status = getKeyByValue(index)!),
    );
  }

  String? getKeyByValue( int value) {
    for (var entry in statusToStepMap.entries) {
      if (entry.value == value) {
        return entry.key;
      }
    }
  }
}
