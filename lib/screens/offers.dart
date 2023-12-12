import 'dart:developer';
import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:image_picker_widget/image_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/controllers/SliderOffersProvider.dart';

import 'package:yama_vet_admin/core/helper/dialog.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';
import 'package:yama_vet_admin/data/models/offers_model.dart';
import 'package:yama_vet_admin/data/models/requests/AddSliderOfferRequest.dart';
import 'package:yama_vet_admin/data/models/requests/UpdateSliderOfferRequest.dart';
import 'package:yama_vet_admin/data/services/api.dart';
import 'package:yama_vet_admin/screens/menu.dart';

class OfferScreen extends StatefulWidget {
  OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String role = '';

  @override
  void initState() {
    super.initState();
    Provider.of<SliderOffersProvider>(context, listen: false).get(context);
    initawaits();
  }

  void initawaits() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      role = sharedPreferences.getString("role")!;
    });

    log(role);
    log(role);
  }

  TextEditingController linkController = TextEditingController();

  //Image Picker function to get image from gallery
  File? choosen_file;
  File? updated_file;

  TextEditingController addLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height;
    double mediaWidth = MediaQuery.sizeOf(context).height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        key: scaffoldKey,
        backgroundColor: scaffoldColor,
        drawer:  Drawer(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.w),
                    bottomLeft: Radius.circular(40.w))),
            width: 200,
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
                          Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width > 650 ? 30.w : 0,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: mediaHeight > 900 ? 30.sp : 20.sp,
                    weight: 100.5,
                    color: Colors.black,
                  )),
              SizedBox(
                width:
                    mediaHeight > 900 ? .3 * mediaWidth : .15 * mediaWidth,
              ),
              Text(
                "Offers",
                style: TextStyle(
                    fontFamily: 'futurBold',
                    color: primary,
                    fontSize: mediaHeight > 900 ? 25.sp : 20.sp),
              ),
            ],
                          ),
                          SizedBox(
            height: mediaHeight > 900 ? 30.h : 10.h,
                          ),
                          (role != "vet")
              ? Center(
                  child: MaterialButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    minWidth: mediaHeight > 900
                        ? .6 * mediaWidth
                        : .45 * mediaWidth,
                    height: mediaHeight > 900 ? 40.h : 30.h,
                    color: primary,
                    onPressed: () {
                      setState(() {
                        Provider.of<SliderOffersProvider>(context,
                                listen: false)
                            .toggleIsAddingFormOpened();
                      });
                    },
                    child: Text(
                      "Add Offer",
                      style: TextStyle(
                          fontFamily: 'futur',
                          color: Colors.white,
                          fontSize: mediaHeight > 900 ? 25.sp : 17.sp),
                    ),
                  ),
                )
              : Container(),
                          SizedBox(
            height: mediaHeight > 900 ? 20.h : 10.h,
                          ),
                          Provider.of<SliderOffersProvider>(context, listen: true)
                  .isAddingFormOpened
              ? Center(
                  child: GestureDetector(
                    // onTap: () {
                    //   pickImage();
                    // },
                    child: Container(
                        width: .85 * MediaQuery.sizeOf(context).width,
                        height: .25 * MediaQuery.sizeOf(context).height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            border: Border.all(color: primary, width: 2.w)),
                        child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: [
                              DottedBorder(
                                  radius:  Radius.circular(20.sp),
                                  color: primary,
                                  dashPattern: [10, 5],
                                  strokeWidth: 1,
                                  child: Container(
                                    width: 300.w,
                                    child: Center(
                                      //todo all images fets
                                      child: ImagePickerWidget(
                                        editIcon:  Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 25.sp,
                                        ),
                                        backgroundColor: Colors.white,
                                        diameter: 70.sp,
                                        fit: BoxFit.none,
                                        initialImage: AssetImage(
                                            "assets/images/upload.png"),
                                        shape:
                                            ImagePickerWidgetShape.square,
                                        isEditable: true,
                                        shouldCrop: true,
                                        imagePickerOptions:
                                            ImagePickerOptions(
                                                imageQuality: 65),
                                        onChange: (file) {
                                          print(
                                              "I changed the file to: ${file.path}");
                                          setState(() {
                                            choosen_file = File(file.path);
                                          });
                                        },
                                      ),
                                    ),
                                  )),
                              Container(
                                width:
                                    .8 * MediaQuery.sizeOf(context).width,
                                height:
                                    .04 * MediaQuery.sizeOf(context).height,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.sp)),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 14.h, left: 5.w),
                                  child: TextField(
                                    controller: addLinkController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Link',
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                  ),
                                ),
                              ),
                              Center(
                                child: MaterialButton(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.sp)),
                                  minWidth: mediaHeight > 900
                                      ? .6 * mediaWidth
                                      : .4 * mediaWidth,
                                  height: mediaHeight > 900 ? 40.h : 30.h,
                                  color: primary,
                                  onPressed: () async {
                                    Provider.of<SliderOffersProvider>(
                                            context,
                                            listen: false)
                                        .create(
                                            context,
                                            AddSliderOfferRequest(context,
                                                link:
                                                    addLinkController.text,
                                                img: choosen_file));
                                  },
                                  child: Text(
                                    "Add ",
                                    style: TextStyle(
                                        fontFamily: 'futur',
                                        color: Colors.white,
                                        fontSize:
                                            mediaHeight > 900 ? 25.sp : 17.sp),
                                  ),
                                ),
                              ),
                            ])),
                  ),
                )
              : Container(),
                          Padding(
            padding: EdgeInsets.only(
                top: 20.h, left: mediaHeight > 900 ? 50.w : 20.w, bottom: 10.h),
            child: Text(
              "Current Offers",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: mediaHeight > 900 ? 25.sp : 17.sp),
            ),
                          ),
                          Center(
            child: Consumer<SliderOffersProvider>(
                builder: (context, sliderOffersProvider, child) {
              return Container(
                width: 300.w,
                height: 500.h,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: sliderOffersProvider.sliderOffers.length,
                    itemBuilder: (context, index) {
                      return Center(
                          child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                if (role != "vet") {
                                  setState(() {
                                    linkController.text =
                                        sliderOffersProvider
                                            .sliderOffers![index].link!;
                                  });
                                  dialogBuilder(
                                      context,
                                      "https://yama-vet.com/${sliderOffersProvider.sliderOffers[index].imgPath}",
                                      //!delete offers
                                      () async {
                                        Provider.of<SliderOffersProvider>(
                                                context,
                                                listen: false)
                                            .delete(context, index);
                                      },
                                      //*update offers
                                      ImagePickerWidget(
                                        editIcon:  Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 25.sp,
                                        ),
                                        backgroundColor: Color(0xff213442),
                                        diameter: 25.sp,
                                        fit: BoxFit.none,
                                        // initialImage: AssetImage(
                                        //     "assets/images/upload.png"),
                                        shape:
                                            ImagePickerWidgetShape.square,
                                        isEditable: true,
                                        shouldCrop: true,
                                        imagePickerOptions:
                                            ImagePickerOptions(
                                                imageQuality: 65),
                                        onChange: (file) {},
                                      ),
                                      () async {
                                        setState(() {
                                          Provider.of<SliderOffersProvider>(
                                                  context,
                                                  listen: false)
                                              .update(
                                                  context,
                                                  UpdateSliderOfferRequest(
                                                      context,
                                                      id: Provider.of<
                                                                  SliderOffersProvider>(
                                                              context,
                                                              listen: false)
                                                          .sliderOffers[
                                                              index]
                                                          .id,
                                                      link: linkController
                                                          .text,
                                                      img: updated_file!));
                                        });
                                      });
                                }
                              },
                              child: Container(
                                width: 400.w,
                                height: 150.h,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://yama-vet.com/${sliderOffersProvider.sliderOffers[index].imgPath}"),
                                        fit: BoxFit.cover)),
                              )),
                           SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ));
                    }),
              );
            }),
                          )
                        ]))));
  }

// Future addOffers() async {
//   var request = http.MultipartRequest("POST", Uri.parse(offersLink));
//   request.headers['api-token'] = 'yama-vets';
//
//   request.fields['link'] =; //^ null if not text
//   request.files.add(await http.MultipartFile.fromPath(
//     'img_path',
//     !.path,
//   ));
//   return await request.send().then((response) async {
//     if (response.statusCode == 200) {
//       print("Uploaded!");
//
//       return true;
//     } else {
//       print("error-----${await response.stream.bytesToString()}");
//       return false;
//     }
//   });
// }
//
// Future updateOffers() async {
//   var request = http.MultipartRequest("POST", Uri.parse(updateOfferLink));
//   request.headers['api-token'] = 'yama-vets';
//   request.fields['id'] = id.toString();
//   request.fields['link'] = ;
//   request.files.add(await http.MultipartFile.fromPath(
//     'img_path',
//     ,
//   ));
//   return await request.send().then((response) async {
//     if (response.statusCode == 200) {
//       print("updated !!!!!!!!!!!");
//       return true;
//     } else {
//       print("error-----${await response.stream.bytesToString()}");
//       return false;
//     }
//   });
// }
//
// Future deleteOffer() async {
//   var request =
//   http.MultipartRequest("DELETE", Uri.parse('$deletOfferLink/$ddd'));
//   request.headers['api-token'] = 'yama-vets';
//   request.fields['id'] = id.toString();
//   request.files.clear();
//   return await request.send().then((response) async {
//     if (response.statusCode == 200) {
//       print(" image deleted successfully!");
//       final responseData = await response.stream.toBytes();
//       final responseString = String.fromCharCodes(responseData);
//       print(responseString);
//
//       return true;
//     } else {
//       print("error-----${await response.stream.bytesToString()}");
//       return false;
//     }
//   });
// }
}
