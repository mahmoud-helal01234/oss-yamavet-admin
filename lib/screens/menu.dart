import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yama_vet_admin/controllers/ConfigurationsProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';

import 'package:url_launcher/url_launcher.dart';

import '../controllers/MyFatoorahController.dart';
import '../core/utils/strings.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Future<void> launchWhatsApp(String phone) async {
  //   final link = WhatsAppUnilink(
  //     phoneNumber: '${phone}',
  //     text: "",
  //   );
  //   await launch('$link');
  // }

  @override
  Widget build(BuildContext context) {

    //! change all icons in this page
    return Scaffold(
      backgroundColor: primary,
      drawer: Drawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                weight: 100.sp,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              changeLanguage(context);
            },
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.language,
                      color: lightpurple,
                    )),
                DropdownButton(
                  dropdownColor: primary,
                  value: EasyLocalization.of(context)!.locale,
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        'English'.tr(),
                        style: TextStyle(
                            fontSize: MediaQuery.sizeOf(context).width > 650
                                ? 10.sp
                                : 20.sp,
                            color: Colors.white),
                      ),
                      value: Locale('en'),
                    ),
                    DropdownMenuItem(
                      child: Text(
                        'Arabic'.tr(),
                        style: TextStyle(
                            fontSize: MediaQuery.sizeOf(context).width > 650
                                ? 10.sp
                                : 20.sp,
                            color: Colors.white),
                      ),
                      value: Locale('ar'),
                    ),
                  ],
                  onChanged: (locale) {
                    EasyLocalization.of(context)!.setLocale(locale!);
                  },
                )
              ],
            ),
          ),
          // SizedBox(
          //   height: .01 * MediaQuery.sizeOf(context).height,
          // ),
          // Row(
          //   children: [
          //     IconButton(
          //         onPressed: () {
          //           // Navigator.pushNamed(context, visitLogs);
          //         },
          //         icon: Icon(
          //           Icons.list_alt_sharp,
          //           color: lightpurple,
          //         )),
          //     const Text(
          //       "Visit logs ",
          //       style: TextStyle(
          //           fontFamily: 'futur', color: Colors.white, fontSize: 20),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: .01 * MediaQuery.sizeOf(context).height,
          ),
          Consumer<ConfigurationsProvider>(
              builder: (context, configurationsProvider, child) {
            return InkWell(
              onTap: () async {
                final Uri whatsappLaunchUri =
                Uri(scheme: 'https', host: 'wa.me', path: configurationsProvider.configurations!.whatsappNumber!);
                if (!await launchUrl(whatsappLaunchUri)) {
                  throw Exception('Could not launch $whatsappLaunchUri');
                }

              },
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.message,
                        color: lightpurple,
                      )),
                  Text(
                    "contactus".tr(),
                    style: TextStyle(
                      fontFamily: 'futur',
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: MediaQuery.sizeOf(context).width > 650
                          ? 12.sp
                          : 20.sp,
                    ),
                  ),
                ],
              ),
            );
          }),

          InkWell(
            onTap: () async {
              log("logout".tr());
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.clear();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  login, (Route<dynamic> route) => false);

              // api logout
            },
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                //* go to register screen
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.exit_to_app,
                      color: lightpurple,
                    )),
                Text(
                  "logout".tr(),
                  style: TextStyle(
                    fontFamily: 'futur',
                    color: Colors.white,
                    fontSize:
                        MediaQuery.sizeOf(context).width > 650 ? 12.sp : 17.sp,
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Text("powered by",style: TextStyle(color: Colors.white),),

          Text("Only Smart - Digi Dove",style: TextStyle(color: Colors.white)),
          SizedBox(height: 10,)
        ],
      ),
    );
  }

  changeLanguage(context) {
    String currentLang = context.locale.toString();

    if (currentLang == "en") {
      // Provider.of<SettingsProvider>(context,listen: false).changeLang("en");
      context.setLocale(const Locale('ar'));
    } else {
      context.setLocale(const Locale('en'));
      // Provider.of<SettingsProvider>(context,listen: false).changeLang("ar");
    }
  }
}
