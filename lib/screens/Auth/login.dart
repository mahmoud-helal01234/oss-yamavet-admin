import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';

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
  login() async {
    http.Response response = await http.post(Uri.parse(loginLink), body: {
      "phone": phone.text,
      "device_id": "324-234-324",
    }, headers: {
      "api-token": "yama-vets",
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('sucess');
      if (data['status'] == true) {
        print('sucess data');
        print("login token !!!!!!!!${data['data']['token']}");
        print("login data !!!!!!!!${data}");
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('token', data['data']['token']);

      } else {
        print('fail to load data');
        print(data);
      }
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height; //!900
    double mediaWidth = MediaQuery.sizeOf(context).width; //!400

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Expanded(
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
                Text("Login",
                    style: GoogleFonts.roboto(
                        fontSize: mediaHeight > 900 ? 50 : 30,
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
                        top: mediaHeight > 900 ? 8 : 0,
                        bottom: mediaHeight > 900 ? 8 : 0),
                    child: TextFormField(
                      controller: phone,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: IconButton(
                            color: Colors.grey,
                            icon: const Icon(Icons.phone),
                            onPressed: () {},
                          ),
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
                  size: 25,
                  text: 'Login',
                  onTap: () async {
                    await login();
                    Navigator.pushNamed(context, verify);
                  },
                  buttomWidth:
                      mediaWidth > 400 ? .85 * mediaWidth : .75 * mediaWidth,
                  height: .061 * mediaHeight,
                ),
                SizedBox(
                  height:
                      mediaHeight > 900 ? .2 * mediaHeight : .07 * mediaHeight,
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
      ),
    );
  }
}
