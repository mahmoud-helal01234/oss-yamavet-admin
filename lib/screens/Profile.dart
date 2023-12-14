import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker_widget/image_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/models/requests/UpdateUserRequest.dart';
import 'package:yama_vet_admin/data/services/api.dart';
import 'package:yama_vet_admin/screens/menu.dart';
import 'package:yama_vet_admin/widgets/custom_button.dart';
import 'package:yama_vet_admin/widgets/custom_text_field.dart';

import '../controllers/UsersProvider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.userIndex});

  final int? userIndex;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  File? choosen_file;
  Api api = Api();

  @override
  void initState() {
    super.initState();

    nameController.text = Provider.of<UsersProvider>(context, listen: false)
        .users[widget.userIndex!]
        .name!;
    phoneController.text = Provider.of<UsersProvider>(context, listen: false)
        .users[widget.userIndex!]
        .phone!;
    roleController.text = Provider.of<UsersProvider>(context, listen: false)
        .users[widget.userIndex!]
        .role!;
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height;
    double mediaWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: scaffoldColor,
        drawer: Drawer(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.sp),
                    bottomLeft: Radius.circular(40.sp))),
            width: 200.w,
            child: MenuScreen()),
        body: SafeArea(
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
                  width:
                      mediaHeight > 900 ? .38 * mediaWidth : .22 * mediaWidth,
                ),
                Text(
                  'profile'.tr(),
                  style: TextStyle(
                      fontFamily: 'futurBold', color: primary, fontSize: 20.sp),
                ),
              ]),
              SizedBox(
                height: 10.h,
              ),
              Stack(
                children: [
                  Consumer<UsersProvider>(
                      builder: (context, usersProvider, child) {
                    return Center(
                        child:
                            Provider.of<UsersProvider>(context, listen: false)
                                        .users[widget.userIndex!]
                                        .imgPath !=
                                    null
                                ? Image.network(
                                    "https://yama-vet.com/${usersProvider.users[widget.userIndex!].imgPath}",
                                    width: 120.w,
                                    height: 60.h,
                                  )
                                : Container(
                                    width: 120.w,
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle),
                                  )
                        //     :
                        // Image.asset("assets/images/profile_doc.png")
                        );
                  }),
                  Positioned(
                      right: mediaWidth > 650 ? 380.w : 120.w,
                      bottom: 0,
                      child: Container(
                        width: 35.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                            color: primary,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20.sp)),
                        child: ImagePickerWidget(
                          editIcon: Center(
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                          ),
                          backgroundColor: primary,
                          diameter: 70.sp,
                          fit: BoxFit.none,
                          // initialImage: AssetImage("assets/images/profile.png"),
                          shape: ImagePickerWidgetShape.circle,
                          isEditable: true,
                          shouldCrop: true,
                          imagePickerOptions:
                              ImagePickerOptions(imageQuality: 65),
                          onChange: (file) {
                            print("I changed the file to: ${file.path}");
                            setState(() {
                              choosen_file = File(file.path);
                            });
                          },
                        ),
                      ))
                ],
              ),
              Consumer<UsersProvider>(builder: (context, usersProvider, child) {
                return Container(
                  width: 500.w,
                  height: 600.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                              child: Text(
                            usersProvider.users[widget.userIndex!].name!,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17.sp),
                          )),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                              child: Text(
                            usersProvider.users[widget.userIndex!].phone!,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                                color: Colors.grey),
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "role".tr(),
                                    style: TextStyle(
                                        color: primary,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17.sp),
                                  ),
                                  Text(
                                    usersProvider
                                        .users[widget.userIndex!].role!,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                "|",
                                style: TextStyle(
                                    fontSize: 70.sp,
                                    color: primary,
                                    fontWeight: FontWeight.w100),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "orders".tr(),
                                    style: TextStyle(
                                        color: primary,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17.sp),
                                  ),
                                  Text(
                                    usersProvider.users[widget.userIndex!]
                                        .appointmentNumber!
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Text(
                                "|",
                                style: TextStyle(
                                    fontSize: 70.sp,
                                    color: primary,
                                    fontWeight: FontWeight.w100),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "rating".tr(),
                                        style: TextStyle(
                                            color: primary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17.sp),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow[600],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        usersProvider.users[widget.userIndex!]
                                                .totalRate ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "/5",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: .05 * mediaWidth,
                          ),
                          Center(
                            child: CustomTextField(
                              hinttext:
                                  usersProvider.users[widget.userIndex!].name!,
                              icon: Icons.person_outline_outlined,
                              width: .9 * mediaWidth,
                              controller: phoneController,
                            ),
                          ),
                          SizedBox(
                            height: .02 * mediaWidth,
                          ),
                          Center(
                            child: CustomTextField(
                              hinttext:
                                  usersProvider.users[widget.userIndex!].phone!,
                              icon: Icons.phone,
                              width: .9 * mediaWidth,
                              controller: nameController,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showMenu(
                                      // shadowColor: primary,
                                      constraints: BoxConstraints(
                                          minWidth:
                                              mediaWidth > 650 ? 800.w : 270.w,
                                          maxWidth: mediaWidth > 650
                                              ? mediaWidth
                                              : 370.w),
                                      color: const Color(0xffefefef),
                                      // elevation: 5,
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          side: BorderSide(color: primary)),
                                      position: RelativeRect.fromLTRB(
                                          mediaWidth > 650 ? 2.w : 50.w,
                                          400.h,
                                          1.w,
                                          1.w),
                                      items: [
                                        PopupMenuItem(
                                            onTap: () {
                                              setState(() {
                                                roleController.text = "vet";
                                              });
                                            },
                                            value: "vet",
                                            child: StatefulBuilder(
                                              builder: (BuildContext context,
                                                  void Function(void Function())
                                                      setState) {
                                                return const Text("Vet");
                                              },
                                            )),
                                        PopupMenuItem(
                                            onTap: () {
                                              setState(() {
                                                roleController.text = "admin";
                                              });
                                            },
                                            value: 1,
                                            child: StatefulBuilder(
                                              builder: (BuildContext context,
                                                  void Function(void Function())
                                                      setState) {
                                                return Text("Admin".tr());
                                              },
                                            )),
                                      ]);
                                },
                                child: Container(
                                  width: .8 * mediaWidth,
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      border: Border.all(color: primary)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 3.h, bottom: 2.h),
                                    child: TextField(
                                      controller: roleController,
                                      enabled: false,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Icon(
                                            Icons.admin_panel_settings,
                                            size: 30.sp,
                                            color: primary,
                                          ),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              showMenu(
                                                  // shadowColor: primary,
                                                  constraints: BoxConstraints(
                                                      minWidth: mediaWidth > 650
                                                          ? 800.w
                                                          : 270.w,
                                                      maxWidth: mediaWidth > 650
                                                          ? mediaWidth
                                                          : 370.w),
                                                  color:
                                                      const Color(0xffefefef),
                                                  // elevation: 5,
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.sp),
                                                      side: BorderSide(
                                                          color: primary)),
                                                  position:
                                                      RelativeRect.fromLTRB(
                                                          mediaWidth > 650
                                                              ? 2.w
                                                              : 50.w,
                                                          400.h,
                                                          1.w,
                                                          1.h),
                                                  items: [
                                                    PopupMenuItem(
                                                        onTap: () {
                                                          setState(() {
                                                            roleController
                                                                .text = "vet";
                                                          });
                                                        },
                                                        value: "vet",
                                                        child: StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              void Function(
                                                                      void
                                                                          Function())
                                                                  setState) {
                                                            return const Text(
                                                                "Vet");
                                                          },
                                                        )),
                                                    PopupMenuItem(
                                                        onTap: () {
                                                          setState(() {
                                                            roleController
                                                                .text = "admin";
                                                          });
                                                        },
                                                        value: 1,
                                                        child: StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              void Function(
                                                                      void
                                                                          Function())
                                                                  setState) {
                                                            return Text(
                                                                "Admin".tr());
                                                          },
                                                        )),
                                                  ]);
                                            },
                                            child: Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
                                              color: primary,
                                            ),
                                          ),
                                          hintText: 'Admin',
                                          hintStyle: TextStyle(
                                              color: primary,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   width: .43 * mediaWidth,
                              //   height: 45,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(10),
                              //       border: Border.all(color: primary)),
                              //   child: Padding(
                              //     padding:
                              //         const EdgeInsets.only(top: 3, bottom: 2),
                              //     child: TextField(
                              //       decoration: InputDecoration(
                              //           border: InputBorder.none,
                              //           prefixIcon: ImageIcon(
                              //             AssetImage(
                              //                 "assets/images/privacy.png"),
                              //             color: primary,
                              //           ),
                              //           suffixIcon: Icon(
                              //             Icons.keyboard_arrow_down_outlined,
                              //             color: primary,
                              //           ),
                              //           hintText: 'Doctor',
                              //           hintStyle: TextStyle(
                              //               color: primary,
                              //               fontWeight: FontWeight.w500)),
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //   width: .43 * mediaWidth,
                              //   height: 45,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(10),
                              //       border: Border.all(color: Colors.grey)),
                              //   child: const Padding(
                              //     padding: EdgeInsets.only(top: 3, bottom: 2),
                              //     child: TextField(
                              //       decoration: InputDecoration(
                              //           border: InputBorder.none,
                              //           prefixIcon: ImageIcon(
                              //             AssetImage("assets/images/lock.png"),
                              //             // color: Colors.grey,
                              //           ),
                              //           suffixIcon: Icon(
                              //             Icons.keyboard_arrow_down_outlined,
                              //             color: Colors.grey,
                              //           ),
                              //           hintText: 'Active',
                              //           hintStyle: TextStyle(
                              //               color: Colors.grey,
                              //               fontWeight: FontWeight.w500)),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: mediaWidth > 650 ? 20.h : 10.h,
                          ),
                          Center(
                            child: CustomButton(
                                onTap: () async {
                                  print("update");
                                  await Provider.of<UsersProvider>(context,
                                          listen: false)
                                      .update(
                                          context,
                                          UpdateUserRequest(context,
                                              id: Provider.of<UsersProvider>(
                                                      context,
                                                      listen: false)
                                                  .users[widget.userIndex!]
                                                  .id!,
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              role: roleController.text));
                                },
                                text: 'Update'.tr(),
                                buttomWidth: .8 * mediaWidth,
                                height: mediaWidth > 650 ? 45.h : 40.h),
                          )
                        ],
                      );
                    },
                  ),
                );
              }),
            ]))));
  }
}
