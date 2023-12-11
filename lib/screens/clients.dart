import 'package:flutter/material.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';
import 'package:yama_vet_admin/screens/menu.dart';
import 'package:yama_vet_admin/widgets/client_row.dart';

class Clients extends StatelessWidget {
  Clients({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height;
    double mediaWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: scaffoldColor,
        drawer: const Drawer(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(40))),
            width: 200,
            child: MenuScreen()),
        body: SafeArea(
            child: Expanded(
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
              SizedBox(
                height: .02 * MediaQuery.sizeOf(context).height,
              ),
              Row(children: [
                SizedBox(
                  width: .05 * MediaQuery.sizeOf(context).width,
                ),
                GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState!.openDrawer();
                    },
                    child: Image.asset("assets/images/menuIcon.png")),
              ]),
              const SizedBox(
                height: 20,
              ),
              Row(children: [
                SizedBox(
                  width: mediaWidth > 650 ? 30 : 0,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      weight: 100.5,
                      color: Colors.black,
                    )),
                SizedBox(
                  width:
                      mediaHeight > 900 ? .35 * mediaWidth : .15 * mediaWidth,
                ),
                Text(
                  'Client Profiles',
                  style: TextStyle(
                      fontFamily: 'futurBold', color: primary, fontSize: 20),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              // Center(
              //   child: Container(
              //     width: .9 * mediaWidth,
              //     height: 40,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(5),
              //         border: Border.all(color: Colors.grey)),
              //     child: const TextField(
              //       decoration: InputDecoration(
              //           border: InputBorder.none,
              //           prefixIcon: RotatedBox(
              //             quarterTurns: 1,
              //             child: Icon(
              //               Icons.search,
              //               color: Colors.grey,
              //               weight: 20,
              //             ),
              //           ),
              //           hintText: ' Search Doctors by Name ',
              //           hintStyle: TextStyle(fontSize: 17, color: Colors.grey)),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
 const ClientRow(),
      
            ])))));
  }
}
