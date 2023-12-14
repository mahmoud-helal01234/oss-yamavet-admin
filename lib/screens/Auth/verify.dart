//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:otp_pin_field/otp_pin_field.dart';
// import 'package:yama_vet_admin/core/utils/colors.dart';
// import 'package:yama_vet_admin/core/utils/strings.dart';
// import 'package:yama_vet_admin/widgets/custom_button.dart';
// import 'package:http/http.dart' as http;
//
// class VerifyScreen extends StatelessWidget {
//   VerifyScreen({super.key});
//   final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
//   verifyCode() async {
//     http.Response response = await http.post(Uri.parse(otpLink), headers: {
//       "api-token": "yama-vets"
//     }, body: {
//       "otp_code": _otpPinFieldController.currentState!.text,
//     });
//
//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = jsonDecode(response.body);
//       print("Sucess verify");
//       if (data['status'] == true) {
//         print(data);
//         print("sucess data");
//       } else {
//         print(data);
//       }
//     } else {
//       print(response.statusCode);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double mediaHeight = MediaQuery.sizeOf(context).height; //!900
//
//     return Scaffold(
//       backgroundColor: scaffoldColor,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: scaffoldColor,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               color: Colors.black,
//               size: 20,
//               weight: 500,
//             )),
//       ),
//       body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: 2 * MediaQuery.sizeOf(context).width,
//                 ),
//                 const Text(
//                   "Verification",
//                   style: TextStyle(fontFamily: 'futur', fontSize: 30),
//                 ),
//                 //! add photo here
//
//                 Image.asset("assets/images/verifylogo.png"),
//                 SizedBox(
//                   height: .05 * MediaQuery.sizeOf(context).height,
//                 ),
//                 OtpPinField(
//                     key: _otpPinFieldController,
//                     autoFillEnable: false,
//                     fieldWidth: mediaHeight > 900 ? 100 : 50,
//                     fieldHeight: mediaHeight > 900 ? 100 : 50,
//
//                     ///for Ios it is not needed as the SMS autofill is provided by default, but not for Android, that's where this key is useful.
//                     textInputAction: TextInputAction.done,
//
//                     ///in case you want to change the action of keyboard
//                     /// to clear the Otp pin Controller
//                     onSubmit: (text) {
//                       print('Entered pin is $text');
//
//                       /// return the entered pin
//                     },
//                     onChange: (text) {
//                       print('Enter on change pin is $text');
//
//                       /// return the entered pin
//                     },
//                     onCodeChanged: (code) {
//                       print('onCodeChanged  is $code');
//                     },
//
//                     /// to decorate your Otp_Pin_Field
//                     otpPinFieldStyle: OtpPinFieldStyle(
//                       textStyle: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//
//                       /// border color for inactive/unfocused Otp_Pin_Field
//                       defaultFieldBorderColor: secondary,
//
//                       /// border color for active/focused Otp_Pin_Field
//                       activeFieldBorderColor: primary,
//
//                       /// Background Color for inactive/unfocused Otp_Pin_Field
//                       defaultFieldBackgroundColor: secondary,
//
//                       /// Background Color for active/focused Otp_Pin_Field
//                       activeFieldBackgroundColor: Colors.white,
//
//                       /// Background Color for filled field pin box
//                       filledFieldBackgroundColor: primary,
//
//                       /// border Color for filled field pin box
//                       filledFieldBorderColor: primary,
//                     ),
//                     maxLength: 4,
//
//                     /// no of pin field
//                     showCursor: true,
//
//                     /// bool to show cursor in pin field or not
//                     cursorColor: primary,
//
//                     /// to choose cursor color
//
//                     middleChild: const Column(
//                       children: [
//                         SizedBox(height: 30),
//                         SizedBox(height: 10),
//                       ],
//                     ),
//                     showCustomKeyboard: false,
//                     showDefaultKeyboard: true,
//                     cursorWidth: 3,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     otpPinFieldDecoration:
//                         OtpPinFieldDecoration.defaultPinBoxDecoration),
//                 SizedBox(
//                   height: .05 * MediaQuery.sizeOf(context).height,
//                 ),
//                 CustomButton(
//                   size: 25,
//                   text: 'verify',
//                   onTap: () async {
//                     await verifyCode();
//                     Navigator.of(context).pushNamedAndRemoveUntil(dash, (Route<dynamic> route) => false);
//
//                   },
//                   buttomWidth: .75 * MediaQuery.sizeOf(context).width,
//                   height: .061 * mediaHeight,
//                 ),
//                 SizedBox(
//                   height:
//                       mediaHeight > 900 ? .05 * mediaHeight : .09 * mediaHeight,
//                 ),
//                 Image.asset(
//                   "assets/images/footer.png",
//                   width: MediaQuery.sizeOf(context).width,
//                   fit: BoxFit.cover,
//                 )
//               ],
//             ),
//           )),
//     );
//   }
// }

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';
import 'package:yama_vet_admin/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

class VerifyScreen extends StatefulWidget {
  VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();

  verifyCode() async {
    http.Response response = await http.post(Uri.parse(otpLink), headers: {
      "api-token": "yama-vets"
    }, body: {
      "otp_code": _otpPinFieldController.currentState!.text,
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print("Sucess verify");
      if (data['status'] == true) {
        print(data);
        print("sucess data");
      } else {
        print(data);
      }
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height; //!900

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: scaffoldColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
              weight: 500,
            )),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 2 * MediaQuery.sizeOf(context).width,
                ),
                 Text(
                  "Verification".tr(),
                  style: TextStyle(fontFamily: 'futur', fontSize: 30),
                ),
                //! add photo here

                Image.asset("assets/images/verifylogo.png"),
                SizedBox(
                  height: .05 * MediaQuery.sizeOf(context).height,
                ),
                OtpPinField(
                    key: _otpPinFieldController,
                    autoFillEnable: false,
                    fieldWidth: mediaHeight > 900 ? 100 : 50,
                    fieldHeight: mediaHeight > 900 ? 100 : 50,

                    ///for Ios it is not needed as the SMS autofill is provided by default, but not for Android, that's where this key is useful.
                    textInputAction: TextInputAction.done,

                    /// to decorate your Otp_Pin_Field
                    otpPinFieldStyle: OtpPinFieldStyle(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),

                      /// border color for inactive/unfocused Otp_Pin_Field
                      defaultFieldBorderColor: secondary,

                      /// border color for active/focused Otp_Pin_Field
                      activeFieldBorderColor: primary,

                      /// Background Color for inactive/unfocused Otp_Pin_Field
                      defaultFieldBackgroundColor: secondary,

                      /// Background Color for active/focused Otp_Pin_Field
                      activeFieldBackgroundColor: Colors.white,

                      /// Background Color for filled field pin box
                      filledFieldBackgroundColor: primary,

                      /// border Color for filled field pin box
                      filledFieldBorderColor: primary,
                    ),
                    maxLength: 4,

                    /// no of pin field
                    showCursor: true,

                    /// bool to show cursor in pin field or not
                    cursorColor: primary,

                    /// to choose cursor color

                    middleChild: const Column(
                      children: [
                        SizedBox(height: 30),
                        SizedBox(height: 10),
                      ],
                    ),
                    showCustomKeyboard: false,
                    showDefaultKeyboard: true,
                    cursorWidth: 3,
                    mainAxisAlignment: MainAxisAlignment.center,
                    otpPinFieldDecoration:
                    OtpPinFieldDecoration.defaultPinBoxDecoration, onSubmit: (String text) {  }, onChange: (String text) {  },),
                SizedBox(
                  height: .05 * MediaQuery.sizeOf(context).height,
                ),
                CustomButton(
                  size: 25,
                  text: 'verify',
                  onTap: () async {
                    await verifyCode();
                    Navigator.of(context).pushNamedAndRemoveUntil(dash, (Route<dynamic> route) => false);

                  },
                  buttomWidth: .75 * MediaQuery.sizeOf(context).width,
                  height: .061 * mediaHeight,
                ),
                SizedBox(
                  height:
                  mediaHeight > 900 ? .05 * mediaHeight : .09 * mediaHeight,
                ),
                Image.asset(
                  "assets/images/footer.png",
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.cover,
                )
              ],
            ),
          )),
    );
  }
}

