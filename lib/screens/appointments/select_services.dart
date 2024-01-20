import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/controllers/CategoriesProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/screens/appointments/widgets/AppointmentPet.dart';
import 'package:yama_vet_admin/screens/appointments/widgets/SelectServiceRow.dart';

import 'package:yama_vet_admin/screens/menu.dart';
import 'package:yama_vet_admin/widgets/choose_spec.dart';
import 'package:yama_vet_admin/widgets/custom_button.dart';

import '../../controllers/AppointmentsProvider.dart';

class SelectServices extends StatefulWidget {
  SelectServices({super.key, required this.appointmentIndex});

  int? appointmentIndex;

  @override
  State<SelectServices> createState() => _SelectServicesState();
}

class _SelectServicesState extends State<SelectServices> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CategoriesProvider>(context, listen: false).get(context);
    Provider.of<AppointmentsProvider>(context, listen: false)
        .initiateUpdateAppointmentRequest(widget.appointmentIndex!);
  }

  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height; //!900
    double mediaWidth = MediaQuery.sizeOf(context).width; //!400

    return Scaffold(
        key: scaffoldKey,
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
              // SizedBox(
              //   height: .02 * MediaQuery.sizeOf(context).height,
              // ),
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
                height: 10.h,
              ),
              Row(
                children: [
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
                  Text(
                    "Book an appointment".tr(),
                    style: TextStyle(
                        fontFamily: 'futurBold',
                        color: primary,
                        fontSize: 20.sp),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 90.h,
                child: Consumer<AppointmentsProvider>(
                    builder: (context, appointmentsProvider, child) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: appointmentsProvider
                          .appointments[widget.appointmentIndex!]
                          .appointmentDetails!
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return AppointmentPet(
                            appointmentIndex: widget.appointmentIndex!,
                            appointmentDetailsIndex: index);
                      });
                }),
              ),

              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 1,
                color: Colors.grey[400],
                endIndent: 20,
                indent: 20,
              ),
              SizedBox(
                height: 5.h,
              ),
              Center(
                child: Text(
                  "Fluffy’s Services",
                  style: GoogleFonts.roboto(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: primary),
                ),
              ),
              SizedBox(
                height: .02 * MediaQuery.sizeOf(context).height,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, bottom: 10.h),
                child: Text("Choose Specialties".tr(),
                    style: GoogleFonts.roboto(
                        fontSize: 17.sp, fontWeight: FontWeight.w600)),
              ),
              Consumer<CategoriesProvider>(
                  builder: (context, categoriesProvider, child) {
                return Container(
                  height: 100.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoriesProvider.categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategoryIndex = index;
                            });
                          },
                          child: SpecialtiesContainer(
                            img: 'assets/images/vaci.png',
                            text: categoriesProvider.categories[index].nameAr!,
                            textColor: selectedCategoryIndex == index
                                ? Colors.white
                                : Colors.black,
                            containerColor: selectedCategoryIndex == index
                                ? primary
                                : Colors.white,
                            imgwidth: 70.w,
                          ),
                        );
                      }),
                );
              }),

              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        thickness: 1,
                        color: Colors.grey[400],
                        endIndent: 20,
                        indent: 20,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20.w, top: 5.h, bottom: 5.h),
                        child: Text("Select Services".tr(),
                            style: GoogleFonts.roboto(
                                fontSize: 17.sp, fontWeight: FontWeight.w600)),
                      ),
                      Consumer<CategoriesProvider>(
                          builder: (context, categoriesProvider, child) {
                        return Container(
                          height: 200.h,
                          child: ListView.builder(
                              itemCount: categoriesProvider
                                  .categories[selectedCategoryIndex]
                                  .services!
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                return SelectServiceRow(
                                    ontap: () {
                                      print("onTap");
                                      Provider.of<AppointmentsProvider>(context,
                                              listen: false)
                                          .toggleServiceIdToPetForUpdateAppointmentRequest(
                                              categoriesProvider
                                                  .categories[
                                                      selectedCategoryIndex]
                                                  .services![index]!
                                                  .id!);
                                    },
                                    text:
                                        "${categoriesProvider.categories[selectedCategoryIndex].services![index]!.nameAr!} - ${categoriesProvider.categories[selectedCategoryIndex].services![index]!.nameEn!}",
                                    price: categoriesProvider
                                        .categories[selectedCategoryIndex]
                                        .services![index]!
                                        .price!
                                        .toString(),
                                    checkbox: Provider.of<AppointmentsProvider>(
                                            context,
                                            listen: true)
                                        .isServiceIdForSelectedPetIdAndAppointmentUpdateRequest(
                                            categoriesProvider
                                                .categories[
                                                    selectedCategoryIndex]
                                                .services![index]!
                                                .id!));
                              }),
                        );
                      }),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.only(
                  //           left: 20,
                  //           top: mediaHeight > 900
                  //               ? .1 * mediaHeight
                  //               : 20),
                  //       child: Text("Subtotal",
                  //           style: TextStyle(
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.w500,
                  //           )),
                  //     ),
                  //     const Spacer(),
                  //     Padding(
                  //       padding:
                  //       const EdgeInsets.only(
                  //           left: 20, top: 20, right: 10),
                  //       child: Consumer<AppointmentsProvider>(
                  //           builder: (context, appointmentsProvider, child) {
                  //             return Text(
                  //               appointmentsProvider.
                  //               calculateTotalForUpdateAppointmentRequest(context)
                  //                   .toString()
                  //             ,
                  //             style: TextStyle(color: Colors.green[700]),
                  //           );
                  //         }
                  //       ),
                  //     )
                  //   ],
                  // ),

                  Container(
                    width: mediaWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.sp),
                            topRight: Radius.circular(30.sp)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 3,
                              blurRadius: 4)
                        ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.w, top: 20.h),
                              child: Text("Total".tr(),
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: primary,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w, top: 20.h, right: 10.w),
                              child: Consumer<AppointmentsProvider>(builder:
                                  (context, appointmentsProvider, child) {
                                return Text(
                                  appointmentsProvider
                                      .calculateTotalForUpdateAppointmentRequest(
                                          context)
                                      .toString(),
                                  style: TextStyle(color: primary),
                                );
                              }),
                            )
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey[400],
                          endIndent: 20,
                          indent: 20,
                        ),
                        CustomButton(
                          onTap: () {
                            Provider.of<AppointmentsProvider>(context,
                                    listen: false)
                                .update(context);
                          },
                          text: 'Update',
                          size: 20.sp,
                          buttomWidth: .75 * MediaQuery.sizeOf(context).width,
                          height: .05 * mediaHeight,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ]))));
  }
}
