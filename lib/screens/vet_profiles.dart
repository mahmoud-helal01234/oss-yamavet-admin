import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_widget/image_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/controllers/UsersProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';
import 'package:yama_vet_admin/data/models/requests/AddUserRequest.dart';
import 'package:yama_vet_admin/data/models/vets_model.dart';
import 'package:yama_vet_admin/data/services/api.dart';
import 'package:yama_vet_admin/screens/menu.dart';
import 'package:yama_vet_admin/widgets/custom_text_field.dart';

import 'package:yama_vet_admin/widgets/vet_row.dart';
import 'package:http/http.dart' as http;

class VetProfiles extends StatefulWidget {
  VetProfiles({super.key});

  @override
  State<VetProfiles> createState() => _VetProfilesState();
}

class _VetProfilesState extends State<VetProfiles> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController roleController = TextEditingController();
  File? choosen_file;
  Api api = Api();
  bool? _isLoading;

  @override
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context, listen: false)
        .get(context);
    roleController.text = "admin";
    print("vet_profiles");
  }



  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height;
    double mediaWidth = MediaQuery.sizeOf(context).height;
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
                  width: mediaHeight > 900 ? 30 : 0,
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
                      mediaHeight > 900 ? .25 * mediaWidth : .15 * mediaWidth,
                ),
                Text(
                  'Vet Profile',
                  style: TextStyle(
                      fontFamily: 'futurBold', color: primary, fontSize: 20),
                ),
              ]),
              Container(
                width: .9 * mediaWidth,
                height: 50,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: MaterialButton(
                        color: primary,
                        minWidth: mediaHeight > 900
                            ? .65 * mediaWidth
                            : .43 * mediaWidth,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          dialogBuilder(
                            context,
                          );
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontFamily: 'futur'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: mediaHeight > 900 ? 20 : 10,
              ),
              // Center(
              //   child: Container(
              //     width:
              //         mediaHeight > 900 ? .65 * mediaWidth : .43 * mediaWidth,
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
              // SizedBox(
              //   height: mediaHeight > 900 ? 20 : 10,
              // ),
              GestureDetector(child: VetRow()),
            ])))));
  }

  Future<void> dialogBuilder(
    BuildContext context,
  ) {

    File? choosen_file;

    double mediaHeight = MediaQuery.sizeOf(context).height; //!900
    double mediaWidth = MediaQuery.sizeOf(context).width; //!400

    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return showDialog<void>(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {

          return SingleChildScrollView(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Card(
                    // margin: EdgeInsets.only(
                    //   top: mediaWidth > 650
                    //       ? .3 * mediaHeight
                    //       : .25 * mediaHeight,
                    // ),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    elevation: 30,
                    // color: Colors.white,
                    child: Container(
                      width: mediaWidth,
                      height: .71 * mediaHeight,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                spreadRadius: 1,
                                blurRadius: 20)
                          ]),
                      child: StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return Column(children: [
                            SizedBox(
                              height: .05 * mediaHeight,
                            ),
                            ImagePickerWidget(
                              editIcon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 25,
                              ),
                              backgroundColor: Colors.white,
                              diameter: 150,
                              fit: BoxFit.none,
                              initialImage:
                                  AssetImage("assets/images/profile.png"),
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
                            SizedBox(
                              height: .05 * mediaHeight,
                            ),
                            CustomTextField(
                              hinttext: 'Name',
                              icon: Icons.person_outline,
                              width: .8 * mediaWidth,
                              controller: nameController,
                            ),
                            SizedBox(
                              height: .02 * mediaHeight,
                            ),
                            CustomTextField(
                              hinttext: 'Phone Number',
                              icon: Icons.phone,
                              width: .8 * mediaWidth,
                              controller: phoneController,
                            ),
                            SizedBox(
                              height: .02 * mediaHeight,
                            ),
                            GestureDetector(
                              onTap: () {
                                showMenu(
                                  // shadowColor: primary,
                                    constraints: BoxConstraints(
                                        minWidth: mediaWidth > 650
                                            ? 800
                                            : 270,
                                        maxWidth: mediaWidth > 650
                                            ? mediaWidth
                                            : 370),
                                    color: const Color(0xffefefef),
                                    // elevation: 5,
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        side: BorderSide(
                                            color: primary)),
                                    position:
                                    RelativeRect.fromLTRB(
                                        mediaWidth > 650 ? 2 : 50,
                                        400,
                                        1,
                                        1),
                                    items: [
                                      PopupMenuItem(
                                          onTap: () {
                                            setState(() {
                                              roleController.text = "vet";
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
                                            builder: (BuildContext
                                            context,
                                                void Function(
                                                    void
                                                    Function())
                                                setState) {
                                              return Text("Admin");
                                            },
                                          )),
                                    ]);
                              },
                              child: Container(
                                width: .8 * mediaWidth,
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: primary)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 3, bottom: 2),
                                  child: TextField(
                                    controller: roleController,
                                    enabled: false,

                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.admin_panel_settings,
                                          size: 30,
                                          color: primary,
                                        ),
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            showMenu(
                                                // shadowColor: primary,
                                                constraints: BoxConstraints(
                                                    minWidth: mediaWidth > 650
                                                        ? 800
                                                        : 270,
                                                    maxWidth: mediaWidth > 650
                                                        ? mediaWidth
                                                        : 370),
                                                color: const Color(0xffefefef),
                                                // elevation: 5,
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                    side: BorderSide(
                                                        color: primary)),
                                                position:
                                                RelativeRect.fromLTRB(
                                                    mediaWidth > 650 ? 2 : 50,
                                                    400,
                                                    1,
                                                    1),
                                                items: [
                                                  PopupMenuItem(
                                                      onTap: () {
                                                        setState(() {

                                                          roleController.text = "vet";
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
                                                        builder: (BuildContext
                                                                context,
                                                            void Function(
                                                                    void
                                                                        Function())
                                                                setState) {
                                                          return Text("Admin");
                                                        },
                                                      )),
                                                ]);
                                          },
                                          child: Icon(
                                            Icons.keyboard_arrow_down_outlined,
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
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MaterialButton(
                                  elevation: 10,
                                  minWidth: 140,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  color: const Color(0xffba94b9),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel",
                                      style: TextStyle(
                                          fontFamily: 'futur',
                                          color: Colors.white,
                                          fontSize: 20)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function()) setState) {
                                    return MaterialButton(
                                      elevation: 10,
                                      minWidth: 140,
                                      height: 40,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      color: primary,
                                      onPressed: () async {

                                        await Provider.of<UsersProvider>(context, listen: false)
                                            .create(context,
                                            AddUserRequest(context,
                                                name: nameController.text,
                                                phone: phoneController.text,
                                                role:roleController.text,
                                                img: choosen_file));


                                      },
                                      child:  const Text("Create",
                                              style: TextStyle(
                                                  fontFamily: 'futur',
                                                  color: Colors.white,
                                                  fontSize: 20)),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ]);
                        },
                      ),
                    ),
                  )
                ]),
          );
        });
  }
}
