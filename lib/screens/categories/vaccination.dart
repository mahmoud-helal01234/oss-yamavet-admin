import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
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

  bool ontap = false;
  bool? _isLoadingc;
  File? updated_file;
  Category? categoriesModel;
  List<Category> categoriesList = [];
  Service? servicesModel;

  // List<ServicesModel> servicesList = [];
  @override
  void initState() {
    super.initState();
    _isLoadingc = true;
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
              Row(
                children: [
                  SizedBox(
                    width: mediaWidth > 650 ? 30 : 0,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: mediaWidth > 650 ? 30 : 20,
                        weight: 100.5,
                        color: Colors.black,
                      )),
                  SizedBox(
                    width:
                        mediaHeight > 900 ? .3 * mediaWidth : .15 * mediaWidth,
                  ),
                  Text(
                    "Vaccination/Services",
                    style: TextStyle(
                        fontFamily: 'futurBold', color: primary, fontSize: 20),
                  ),
                  SizedBox(
                    height: mediaHeight > 900 ? 20 : 0,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: mediaWidth > 650 ? 50 : 20, top: 10, bottom: 10),
                child: Text(
                  "Category",
                  style: TextStyle(
                      fontSize: mediaHeight > 900 ? 25 : 17,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: mediaWidth > 650 ? 20 : 0,
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 7,
                      margin: const EdgeInsets.only(left: 20),
                      child: Container(
                        // margin: EdgeInsets.only(left: 20),
                        // width: .6 * mediaWidth,
                        height: .1 * mediaHeight,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(7)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                             Consumer<CategoriesProvider>(builder:
                                    (context, categoriesProvider, child) {
                                    return CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://yama-vet.com/${categoriesProvider.categories[widget.categoryIndex].imgPath}"),
                                      radius: 30,
                                    );
                                  }),
                            SizedBox(
                              width: 10,
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
                                        .nameEn! + " - " +
                                        categoriesProvider
                                            .categories[widget.categoryIndex]
                                            .nameAr!,
                                    style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize: mediaWidth > 650 ? 20 : 15),
                                  );
                                }),
                                const SizedBox(
                                  height: 7,
                                ),
                                // Row(
                                //   children: [
                                //     Text(
                                //       "Edit",
                                //       style: TextStyle(
                                //           color: Colors.grey[400],
                                //           fontSize: mediaWidth > 650 ? 17 : 12),
                                //     ),
                                //     const SizedBox(
                                //       width: 5,
                                //     ),
                                //     GestureDetector(
                                //       onTap: () {
                                //         setState(() {
                                //           ontap = !ontap;
                                //         });
                                //       },
                                //       child: SvgPicture.asset(
                                //           "assets/images/edit_one.svg"),
                                //     )
                                //   ],
                                // )
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
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red),
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              ontap ? EditCategory() : Container(),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: Text(
                  "Services",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                width: 500,
                height: 200,
                child: Consumer<CategoriesProvider>(
                    builder: (context, categoriesProvider, child) {
                  return ListView.builder(
                    itemCount: categoriesProvider
                        .categories[widget.categoryIndex].services!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SelectRow(
                        ontap: () {
                          setState(() {
                            if (Provider.of<CategoriesProvider>(context,listen: false).serviceToUpdate != null) {
                              Provider.of<CategoriesProvider>(context,listen: false).serviceToUpdate = null;
                            } else {
                              Provider.of<CategoriesProvider>(context,listen: false).serviceToUpdate = categoriesProvider
                                  .categories[widget.categoryIndex]
                                  .services![index];
                            }
                          });
                        },
                        text: categoriesProvider
                            .categories[widget.categoryIndex]
                            .services![index]
                            .nameEn! + " - " + categoriesProvider
                            .categories[widget.categoryIndex]
                            .services![index]
                            .nameAr!,
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
                height: 5,
              ),
              Provider.of<CategoriesProvider>(context,listen: true).serviceToUpdate != null
                  ? UpdateService()
                  : Container(),
              SizedBox(
                height: 20,
              ),
                Provider.of<CategoriesProvider>(context,listen: true).addServiceOpened
                  ? GestureDetector(onTap: () {
                      setState(() {
                        Provider.of<CategoriesProvider>(context,listen: false).toggleAddServiceOpened();
                      });
                    }, child: AddServices(categoryIndex: widget.categoryIndex))
                  : Center(
                      child: DottedBorder(
                          radius: const Radius.circular(20),
                          color: primary,
                          dashPattern: const [10, 5],
                          strokeWidth: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                Provider.of<CategoriesProvider>(context,listen: false).toggleAddServiceOpened();
                              });
                            },
                            child: Container(
                                width: .9 * MediaQuery.sizeOf(context).width,
                                height: .03 * MediaQuery.sizeOf(context).height,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "Add Services",
                                    style: TextStyle(
                                        color: primary,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                          )),
                    ),
            ])))));
  }
}
