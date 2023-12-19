import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:image_picker_widget/image_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/controllers/SliderOffersProvider.dart';

import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/models/requests/AddSliderOfferRequest.dart';
import 'package:yama_vet_admin/screens/menu.dart';

import '../controllers/SettingsProvider.dart';

class OfferScreen extends StatefulWidget {
  OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Provider.of<SliderOffersProvider>(context, listen: false).get(context);
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
        drawer: Drawer(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.w),
                    bottomLeft: Radius.circular(40.w))),
            width: mediaWidth > 650 ? 150.w : 200.w,
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
                    width: mediaHeight > 900 ? 80.w : .15 * mediaWidth,
                  ),
                  Text(
                    "offers".tr(),
                    style: TextStyle(
                        fontFamily: 'futurBold',
                        color: primary,
                        fontSize: mediaHeight > 900 ? 20.sp : 20.sp),
                  ),
                ],
              ),
              SizedBox(
                height: mediaHeight > 900 ? 30.h : 10.h,
              ),
              (Provider.of<SettingsProvider>(context, listen: true).role !=
                      "vet")
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
                          "addoffer".tr(),
                          style: TextStyle(
                              fontFamily: 'futur',
                              color: Colors.white,
                              fontSize: mediaHeight > 900 ? 20.sp : 17.sp),
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
                            height: mediaWidth > 650
                                ? .27 * mediaHeight.h
                                : .25 * MediaQuery.sizeOf(context).height,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                border: Border.all(color: primary, width: 2.w)),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  DottedBorder(
                                      radius: Radius.circular(20.sp),
                                      color: primary,
                                      dashPattern: [10, 5],
                                      strokeWidth: 1,
                                      child: Container(
                                        width: 300.w,
                                        child: Center(
                                          //todo all images fets
                                          child: ImagePickerWidget(
                                            editIcon: Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 20.sp,
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
                                        borderRadius:
                                            BorderRadius.circular(5.sp)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 14.h, left: 5.w),
                                      child: TextField(
                                        controller: addLinkController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'link'.tr(),
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
                                        "add".tr(),
                                        style: TextStyle(
                                            fontFamily: 'futur',
                                            color: Colors.white,
                                            fontSize: mediaHeight > 900
                                                ? 20.sp
                                                : 17.sp),
                                      ),
                                    ),
                                  ),
                                ])),
                      ),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.only(
                    top: 20.h,
                    left: mediaHeight > 900 ? 50.w : 20.w,
                    bottom: 10.h),
                child: Text(
                  "currentoffers".tr(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: mediaHeight > 900 ? 20.sp : 17.sp),
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
                                    if (Provider.of<SettingsProvider>(context,
                                                listen: false)
                                            .role !=
                                        "vet") {
                                      setState(() {
                                        linkController.text =
                                            sliderOffersProvider
                                                .sliderOffers![index].link!;
                                      });
                                      dialogBuilder(context,
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
                                            editIcon: Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 20.sp,
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
                                          null
                                          // () async {
                                          //   setState(() {
                                          //     Provider.of<SliderOffersProvider>(
                                          //             context,
                                          //             listen: false)
                                          //         .update(
                                          //             context,
                                          //             UpdateSliderOfferRequest(
                                          //                 context,
                                          //                 id: Provider.of<
                                          //                             SliderOffersProvider>(
                                          //                         context,
                                          //                         listen: false)
                                          //                     .sliderOffers[
                                          //                         index]
                                          //                     .id,
                                          //                 link: linkController
                                          //                     .text,
                                          //                 img: updated_file!));
                                          //   });
                                          // }

                                          );
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

  Future<void> dialogBuilder(
      BuildContext context,
      String img,
      void Function()? onDeletePress,
      Widget customWidget,
      void Function()? onUpdatePress) {
    double mediaHeight = MediaQuery.sizeOf(context).height; //!900
    double mediaWidth = MediaQuery.sizeOf(context).width; //!400
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return Container(
                    width: width * 0.9,
                    height: ScreenUtil().screenHeight * 0.4,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      elevation: 30,
                      child: Container(
                        width: mediaWidth,
                        height: .42 * mediaHeight,
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
                        child: SingleChildScrollView(
                          child: Column(children: [
                            SizedBox(
                              height: mediaWidth > 650 ? 20 : 10,
                            ),
                            Container(
                              width: .5 * mediaWidth,
                              height: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(img),
                                      fit: BoxFit.cover)),
                              // child: Image.network(
                              //   img,
                              //   width: 150,
                              //   fit: BoxFit.fitWidth,
                              //   // height: mediaWidth > 650 ? 200 : 120,
                              //   // fit: BoxFit.fitHeight,
                              // ),
                            ),
                            onUpdatePress == null
                                ? Container()
                                : Positioned(
                                    bottom: 0,
                                    left: 4,
                                    right: 4,
                                    child: Container(
                                      height: mediaWidth > 650 ? 30 : 25,
                                      width: 285,
                                      decoration: const BoxDecoration(
                                          color: Color(0xff213442),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5))),
                                      child: StatefulBuilder(
                                        builder: (BuildContext context,
                                            void Function(void Function())
                                                setState) {
                                          return Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Change Image".tr(),
                                                  style: TextStyle(
                                                      fontFamily: 'futur',
                                                      color: Colors.white,
                                                      fontSize: mediaWidth > 650
                                                          ? 20
                                                          : 15),
                                                ),
                                                customWidget,
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )),
                            onUpdatePress == null
                                ? Container()
                                : SizedBox(
                                    height: mediaWidth > 650 ? 20 : 10,
                                  ),
                            onUpdatePress == null
                                ? Container()
                                : Container(
                                    height: mediaWidth > 650 ? 40 : 30,
                                    width: .75 * mediaWidth,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 5, left: 4),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'www.exmple.com/image.jpg',
                                            hintStyle: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey)),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: mediaWidth > 650 ? 10 : 0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MaterialButton(
                                  elevation: 10,
                                  minWidth: mediaWidth > 650 ? 400 : 140,
                                  height: mediaWidth > 650 ? 35 : 25,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  color: const Color(0xffba94b9),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel".tr(),
                                      style: TextStyle(
                                          fontFamily: 'futur',
                                          color: Colors.white,
                                          fontSize:
                                              mediaWidth > 650 ? 22 : 15)),
                                ),
                                SizedBox(
                                  width: mediaWidth > 650 ? 30 : 10,
                                ),
                                onUpdatePress == null
                                    ? Container()
                                    : MaterialButton(
                                        elevation: 10,
                                        minWidth: mediaWidth > 650 ? 200 : 140,
                                        height: mediaWidth > 650 ? 35 : 25,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        color: primary,
                                        onPressed: onUpdatePress,
                                        child: Text("Update".tr(),
                                            style: TextStyle(
                                                fontFamily: 'futur',
                                                color: Colors.white,
                                                fontSize: mediaWidth > 650
                                                    ? 22
                                                    : 15)),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: mediaWidth > 650 ? 10 : 0,
                            ),
                            MaterialButton(
                              elevation: 10,
                              minWidth: mediaWidth > 650 ? 400 : 140,
                              height: mediaWidth > 650 ? 35 : 25,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: Colors.red,
                              onPressed: onDeletePress,
                              child: Text("Delete".tr(),
                                  style: TextStyle(
                                      fontFamily: 'futur',
                                      color: Colors.white,
                                      fontSize: mediaWidth > 650 ? 22 : 15)),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ));
  }
}
