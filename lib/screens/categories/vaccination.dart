import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';

import 'package:yama_vet_admin/data/services/api.dart';
import 'package:yama_vet_admin/screens/menu.dart';
import 'package:yama_vet_admin/widgets/add_services.dart';
import 'package:yama_vet_admin/widgets/edit_category.dart';
import 'package:yama_vet_admin/widgets/select.dart';
import 'package:yama_vet_admin/widgets/update_services.dart';

import '../../controllers/CategoriesProvider.dart';
import '../../data/models/dtos/Service.dart';
import '../../data/models/responses/CategoriesResponse.dart';

// ignore: must_be_immutable
class Vaccination extends StatefulWidget {
  Vaccination({super.key, required this.categoryIndex});

  int categoryIndex;

  @override
  State<Vaccination> createState() => _VaccinationState();
}

class _VaccinationState extends State<Vaccination> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  File? updated_file;
  Category? categoriesModel;
  List<Category> categoriesList = [];
  Service? servicesModel;

  // List<ServicesModel> servicesList = [];
  @override
  void initState() {
    super.initState();
    setState(() {});

    // getServices();
  }

  Api api = Api();
  int? id;

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
                    width: mediaWidth > 650 ? 30.w : 0,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: mediaWidth > 650 ? 30.sp : 20.sp,
                        weight: 100.5,
                        color: Colors.black,
                      )),
                  SizedBox(
                    width: mediaHeight > 900
                        ? .1 * mediaWidth.w
                        : .15 * mediaWidth,
                  ),
                  Text(
                    "vaccination".tr(),
                    style: TextStyle(
                        fontFamily: 'futurBold',
                        color: primary,
                        fontSize: mediaWidth > 650 ? 15.sp : 20),
                  ),
                  SizedBox(
                    height: mediaHeight > 900 ? 20.h : 0,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: mediaWidth > 650 ? 50.w : 20.w,
                    top: 10.h,
                    bottom: 10.h,
                    right: 10.w),
                child: Text(
                  "categories".tr(),
                  style: TextStyle(
                      fontSize: mediaHeight > 900 ? 20.sp : 17.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: mediaWidth > 650 ? 20.h : 0,
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Card(
                      elevation: 7,
                      margin: EdgeInsets.only(left: 20.w),
                      child: Container(
                        // margin: EdgeInsets.only(left: 20),
                        // width: .6 * mediaWidth,
                        height: mediaWidth > 650
                            ? .15 * mediaHeight
                            : .1 * mediaHeight,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(7.sp)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Consumer<CategoriesProvider>(
                                builder: (context, categoriesProvider, child) {
                              return CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://yama-vet.com/${categoriesProvider.categories[widget.categoryIndex].imgPath}"),
                                radius: 30.sp,
                              );
                            }),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Consumer<CategoriesProvider>(builder:
                                    (context, categoriesProvider, child) {
                                  return Text(
                                    categoriesProvider
                                            .categories[widget.categoryIndex]
                                            .nameEn! +
                                        " - " +
                                        categoriesProvider
                                            .categories[widget.categoryIndex]
                                            .nameAr!,
                                    style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize:
                                            mediaWidth > 650 ? 20.sp : 15.sp),
                                  );
                                }),
                                SizedBox(
                                  height: 7.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Edit",
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize:
                                              mediaWidth > 650 ? 15.sp : 12),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<CategoriesProvider>(context,
                                            listen: false)
                                            .toggleEditCategoryOpened();
                                      },
                                      child: SvgPicture.asset(
                                        "assets/images/edit_one.svg",
                                        width: mediaWidth > 650 ? 35 : 20,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 1,
                    child: GestureDetector(
                      onTap: () async {
                        Provider.of<CategoriesProvider>(context, listen: false)
                            .delete(context, widget.categoryIndex);
                      },
                      child: Container(
                        width: mediaWidth > 650 ? 15.w : 20.w,
                        height: mediaWidth > 650 ? 20.h : 20.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red),
                        child: Center(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 15.sp,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            Provider.of<CategoriesProvider>(context,
                listen: true)
                .editCategoryOpened ? EditCategory(categoryIndex:widget.categoryIndex!) : Container(),
              Padding(
                padding: EdgeInsets.only(
                    left: 20.w, top: 10.h, bottom: 10.h, right: 10.w),
                child: Text(
                  "services".tr(),
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                width: 500.w,
                height: 200.h,
                child: Consumer<CategoriesProvider>(
                    builder: (context, categoriesProvider, child) {
                  return ListView.builder(
                    itemCount: categoriesProvider
                        .categories[widget.categoryIndex].services!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SelectRow(
                        ontap: () {
                          setState(() {
                            if (Provider.of<CategoriesProvider>(context,
                                        listen: false)
                                    .serviceToUpdate !=
                                null) {
                              Provider.of<CategoriesProvider>(context,
                                      listen: false)
                                  .serviceToUpdate = null;
                            } else {
                              Provider.of<CategoriesProvider>(context,
                                          listen: false)
                                      .serviceToUpdate =
                                  categoriesProvider
                                      .categories[widget.categoryIndex]
                                      .services![index];
                            }
                          });
                        },
                        text: categoriesProvider
                                .categories[widget.categoryIndex]
                                .services![index]
                                .nameEn! +
                            " - " +
                            categoriesProvider.categories[widget.categoryIndex]
                                .services![index].nameAr!,
                        price: categoriesProvider
                            .categories[widget.categoryIndex]
                            .services![index]
                            .price
                            .toString(),
                        checkbox: false,
                      );
                    },
                  );
                }),
              ),
              SizedBox(
                height: 5.h,
              ),
              Provider.of<CategoriesProvider>(context, listen: true)
                          .serviceToUpdate !=
                      null
                  ? UpdateService()
                  : Container(),
              SizedBox(
                height: 20.h,
              ),
              Provider.of<CategoriesProvider>(context, listen: true)
                      .addServiceOpened
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          Provider.of<CategoriesProvider>(context,
                                  listen: false)
                              .toggleAddServiceOpened();
                        });
                      },
                      child: AddServices(categoryIndex: widget.categoryIndex))
                  : Center(
                      child: DottedBorder(
                          radius: Radius.circular(20.sp),
                          color: primary,
                          dashPattern: [10, 5],
                          strokeWidth: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                Provider.of<CategoriesProvider>(context,
                                        listen: false)
                                    .toggleAddServiceOpened();
                              });
                            },
                            child: Container(
                                width: .9 * MediaQuery.sizeOf(context).width,
                                height: .03 * MediaQuery.sizeOf(context).height,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "addservices".tr(),
                                    style: TextStyle(
                                        fontSize: mediaWidth > 650 ? 10.sp : 15,
                                        color: primary,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                          )),
                    ),
              SizedBox(
                height: 10,
              ),
            ]))));
  }
}
