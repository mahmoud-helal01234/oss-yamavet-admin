import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String role ='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initawaits();
  }
  void initawaits() async{
    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();

    Future.delayed(
      Duration(seconds: 5),
          () {
            if(sharedPreferences.containsKey("token"))
            { Navigator.of(context).pushNamedAndRemoveUntil(dash, (Route<dynamic> route) => false);}
                else{
                  Navigator.pushNamed(context, login);
                }
      },
    );
    log(role);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logoone.png"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logotext.png"),
                ],
              ),
            ],
          ),
        ));
  }
}
