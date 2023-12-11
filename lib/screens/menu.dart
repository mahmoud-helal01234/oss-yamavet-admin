import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/controllers/ConfigurationsProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

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
    double mediaHeight = MediaQuery.sizeOf(context).height; //!900

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
              icon: const Icon(
                Icons.close,
                weight: 100,
              ))
        ],
      ),
      body: Column(
        children: [
          // Row(
          //   children: [
          //     IconButton(
          //         onPressed: () {},
          //         icon: Icon(
          //           Icons.language,
          //           color: lightpurple,
          //         )),
          //     const Text(
          //       "English",
          //       style: TextStyle(
          //           fontFamily: 'futur', color: Colors.white, fontSize: 17),
          //     ),
          //     IconButton(
          //         onPressed: () {},
          //         icon: const Icon(
          //           Icons.keyboard_arrow_down_outlined,
          //           color: Colors.white,
          //         ))
          //   ],
          // ),
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
                await launchUrl(Uri.parse(Platform.isAndroid
                    ? "https://wa.me/${configurationsProvider.configurations!.whatsappNumber!}/"
                    : "https://api.whatsapp.com/send")
                );
              },
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send_to_mobile_sharp,
                        color: lightpurple,
                      )),
                  const Text(
                    "Contact Us",
                    style: TextStyle(
                        fontFamily: 'futur', color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            );
          }),
          SizedBox(
            height: mediaHeight > 900
                ? .6 * mediaHeight
                : .49 * MediaQuery.sizeOf(context).height,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              //* go to register screen
              IconButton(
                  onPressed: () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.clear();
                    Navigator.of(context).pushNamedAndRemoveUntil(login, (Route<dynamic> route) => false);

                    // api logout
                  },
                  icon: Icon(
                    Icons.exit_to_app,
                    color: lightpurple,
                  )),
              const Text(
                "Logout",
                style: TextStyle(
                    fontFamily: 'futur', color: Colors.white, fontSize: 17),
              )
            ],
          )
        ],
      ),
    );
  }
}
