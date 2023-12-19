import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:yama_vet_admin/controllers/AuthProvider.dart';

import 'package:yama_vet_admin/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool remeberMe = false;
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height; //!900
    double mediaWidth = MediaQuery.sizeOf(context).width; //!400

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: mediaHeight > 800
                    ? .05 * mediaHeight
                    : .05 * MediaQuery.sizeOf(context).height,
              ),
              SizedBox(
                width: 1 * MediaQuery.sizeOf(context).width,
              ),
              Text("login".tr(),
                  style: GoogleFonts.roboto(
                      fontSize: mediaWidth > 650 ? 25.sp : 30.h,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: mediaHeight > 800
                    ? .07 * mediaHeight
                    : .05 * MediaQuery.sizeOf(context).height,
              ),
              Image.asset("assets/images/logologin.png"),
              Image.asset("assets/images/logotextlogin.png"),
              SizedBox(
                height: mediaHeight > 900
                    ? .1 * mediaHeight
                    : .05 * MediaQuery.sizeOf(context).height,
              ),
              Container(
                width: mediaWidth > 400 ? .85 * mediaWidth : .75 * mediaWidth,
                height: .06 * MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: mediaHeight > 900 ? 8.h : 0,
                      bottom: mediaHeight > 900 ? 8.h : 2.h),
                  child: TextFormField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: IconButton(
                          color: Colors.grey,
                          icon: const Icon(Icons.phone),
                          onPressed: () {},
                        ),
                        hintStyle: TextStyle(
                            fontSize: mediaWidth > 650 ? 9.sp : 15.sp),
                        hintText: 'Phone Number'),
                  ),
                ),
              ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width:
              //           mediaWidth > 400 ? .07 * mediaWidth : .1 * mediaWidth,
              //     ),
              //     Checkbox(
              //         fillColor: MaterialStateProperty.resolveWith((states) {
              //           if (!states.contains(MaterialState.selected)) {
              //             return Colors.white;
              //           }
              //           return null;
              //         }),
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(5)),
              //         side: BorderSide(
              //           color: primary,
              //           width: 1,
              //         ),
              //         activeColor: primary,
              //         checkColor: Colors.white,
              //         value: remeberMe,
              //         onChanged: (val) {
              //           setState(() {
              //             remeberMe = val!;
              //           });
              //         }),
              //     Text(
              //       "Remember me",
              //       style: TextStyle(
              //           fontSize: 18,
              //           color: primary,
              //           fontWeight: FontWeight.w400),
              //     )
              //   ],
              // ),
              SizedBox(
                height: .05 * MediaQuery.sizeOf(context).height,
              ),
              CustomButton(
                size: mediaWidth > 650 ? 20.sp : 25.sp,
                text: "login".tr(),
                onTap: () async {
                  // Provider.of<AuthProvider>(context,listen: false).
                  // login(context, LoginRequest(phone: phone.text,deviceId: "324-234-324"));

                  Provider.of<AuthProvider>(context, listen: false)
                      .loginWogood(context, phone.text, "324-234-324");
                },
                buttomWidth:
                    mediaWidth > 400 ? .85 * mediaWidth : .75 * mediaWidth,
                height: .061 * mediaHeight,
              ),
              SizedBox(
                height: 100.h,
              ),
              Image.asset(
                "assets/images/footer.png",
                width: MediaQuery.sizeOf(context).width,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      ),
    );
  }
}
