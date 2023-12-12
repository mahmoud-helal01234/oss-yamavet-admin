import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/screens/menu.dart';
import 'package:yama_vet_admin/widgets/pets_container.dart';

import '../controllers/ClientsProvider.dart';

class ClientProfile extends StatefulWidget {
  ClientProfile({super.key, required this.clientIndex});
  int? clientIndex;
  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height;
    double mediaWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: scaffoldColor,
        drawer: Drawer(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.sp),
                    bottomLeft: Radius.circular(40.sp))),
            width: 200.w,
            child: MenuScreen()),
        body: SafeArea(
            child: widget.clientIndex == null
                ? Container()
                : Consumer<ClientsProvider>(
                    builder: (context, clientsProvider, child) {
                    return SingleChildScrollView(
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
                                child:
                                    Image.asset("assets/images/menuIcon.png")),
                          ]),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(children: [
                            SizedBox(
                              width: mediaWidth > 650 ? 30.w : 0,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 20.sp,
                                  weight: 100.5,
                                  color: Colors.black,
                                )),
                            SizedBox(
                              width: mediaHeight > 900
                                  ? .35 * mediaWidth
                                  : .15 * mediaWidth,
                            ),
                            Text(
                              ' Profile',
                              style: TextStyle(
                                  fontFamily: 'futurBold',
                                  color: primary,
                                  fontSize: 20),
                            ),
                          ]),
                          SizedBox(
                            height: 10.h,
                          ),
                          Stack(
                            children: [
                              Center(
                                  child: CircleAvatar(
                                radius: 60.sp,
                                backgroundColor: primary,
                                backgroundImage: ExactAssetImage(
                                    "assets/images/female_one.png"),
                              )),
                              Positioned(
                                  right: mediaWidth > 650 ? 380.w : 100.w,
                                  bottom: 0,
                                  child: Container(
                                    width: 40.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        color: primary,
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(20.sp)),
                                    child: const Center(
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                              child: Text(
                            clientsProvider.clients[widget.clientIndex!].name!,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17.sp),
                          )),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                              child: Text(
                            clientsProvider.clients[widget.clientIndex!].phone!,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                                color: Colors.grey),
                          )),
                          Card(
                            margin: EdgeInsets.only(left: 20, top: 20),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              width: 70.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  "Pets",
                                  style: TextStyle(
                                      fontFamily: 'futur', color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            height: 300.h,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 3,
                                      crossAxisSpacing: 3),
                              itemBuilder: (_, index) {
                                return PetsContainer(
                                    img: clientsProvider
                                        .clients[widget.clientIndex!]
                                        .pets![index]
                                        .imgPath!,
                                    text: clientsProvider
                                        .clients[widget.clientIndex!]
                                        .pets![index]
                                        .name!);
                              },
                              itemCount: clientsProvider
                                  .clients[widget.clientIndex!].pets!.length,
                            ),
                          ),
                        ]));
                  })));
  }
}
