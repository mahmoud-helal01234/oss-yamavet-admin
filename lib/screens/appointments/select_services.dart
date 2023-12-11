import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/controllers/CategoriesProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/screens/appointments/widgets/AppointmentPet.dart';

import 'package:yama_vet_admin/screens/menu.dart';
import 'package:yama_vet_admin/widgets/choose_spec.dart';
import 'package:yama_vet_admin/widgets/custom_button.dart';
import 'package:yama_vet_admin/widgets/pets_container.dart';
import 'package:yama_vet_admin/widgets/select.dart';

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
    Provider.of<CategoriesProvider>(context, listen: false)
        .get(context);
    Provider.of<AppointmentsProvider>(context, listen: false)
        .initiateUpdateAppointmentRequest(widget.appointmentIndex!);
  }

  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery
        .sizeOf(context)
        .height; //!900
    double mediaWidth = MediaQuery
        .sizeOf(context)
        .width; //!400

    return Scaffold(
        key: scaffoldKey,
        drawer: const Drawer(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(40))),
            width: 200,
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
                          width: .05 * MediaQuery
                              .sizeOf(context)
                              .width,
                        ),
                        GestureDetector(
                            onTap: () {
                              scaffoldKey.currentState!.openDrawer();
                            },
                            child: Image.asset("assets/images/menuIcon.png")),
                      ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
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
                          Text(
                            "Book an appointment",
                            style: TextStyle(
                                fontFamily: 'futurBold',
                                color: primary,
                                fontSize: 20),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 90,
                        child: Consumer<AppointmentsProvider>(
                            builder: (context, appointmentsProvider, child) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: appointmentsProvider
                                      .appointments[widget.appointmentIndex!]
                                      .appointmentDetails!
                                      .length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return AppointmentPet(
                                        appointmentIndex: widget
                                            .appointmentIndex!,
                                        appointmentDetailsIndex: index


                                    );
                                  });
                            }),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey[400],
                        endIndent: 20,
                        indent: 20,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(
                          "Fluffy’s Services",
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: primary),
                        ),
                      ),
                      SizedBox(
                        height: .02 * MediaQuery
                            .sizeOf(context)
                            .height,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        child: Text("Choose Specialties",
                            style: GoogleFonts.roboto(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                      ),
                      Consumer<CategoriesProvider>(
                          builder: (context, categoriesProvider, child) {
                            return Container(
                              height: 100,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categoriesProvider
                                      .categories
                                      .length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedCategoryIndex = index;
                                        });
                                      },
                                      child: SpecialtiesContainer(
                                        img: 'assets/images/vaci.png',
                                        text: categoriesProvider
                                            .categories[index].nameAr!,
                                        textColor: selectedCategoryIndex ==
                                            index ? Colors.white : Colors.black,
                                        containerColor: selectedCategoryIndex ==
                                            index ? primary : Colors.white,
                                        imgwidth: 70,
                                      ),
                                    );
                                  }),
                            );
                          }
                      ),

                      Column(
                        children: [
                          Container(
                            height: mediaHeight > 900 ? .4 * mediaHeight : 155,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.grey[400],
                                    endIndent: 20,
                                    indent: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 5, bottom: 5),
                                    child: Text("Select Services",
                                        style: GoogleFonts.roboto(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Consumer<CategoriesProvider>(
                                      builder: (context, categoriesProvider,
                                          child) {
                                        return Container(
                                          height: 200,
                                          child: ListView.builder(
                                              itemCount: categoriesProvider
                                                  .categories[selectedCategoryIndex]
                                                  .services!.length,
                                              itemBuilder: (
                                                  BuildContext context,
                                                  int index) {
                                                return
                                                  SelectRow(
                                                    ontap: (){
                                                      Provider.of<AppointmentsProvider>(context, listen: false).
                                                      toggleServiceIdToPetForUpdateAppointmentRequest(
                                                          categoriesProvider
                                                      .categories[selectedCategoryIndex]
                                                      .services![index]!
                                                      .id!);
                                                    },
                                                      text: "${categoriesProvider
                                                          .categories[selectedCategoryIndex]
                                                          .services![index]!
                                                          .nameAr!} - ${categoriesProvider
                                                          .categories[selectedCategoryIndex]
                                                          .services![index]!
                                                          .nameEn!}",
                                                      price: categoriesProvider
                                                          .categories[selectedCategoryIndex]
                                                          .services![index]!
                                                          .price!.toString(),
                                                      checkbox:
                                                      Provider
                                                          .of<AppointmentsProvider>(context, listen: true).isServiceIdForSelectedPetIdAndAppointmentUpdateRequest(
                                                          categoriesProvider
                                                          .categories[selectedCategoryIndex]
                                                          .services![index]!
                                                          .id!)
                                                  );
                                              }),
                                        );
                                      }
                                  ),

                                  SelectRow(
                                    text: 'Lorem ipsum dolor sit.',
                                    price: '10',
                                    checkbox: true,
                                  ),
                                  SelectRow(
                                    text: 'Lorem ipsum dolor sit amet consectetur.',
                                    price: '15',
                                    checkbox: true,
                                  ),
                                  SelectRow(
                                    text: 'Lorem ipsum dsdolor sit',
                                    price: '5',
                                    checkbox: true,
                                  ),
                                  SelectRow(
                                    text: 'Lorem ipsum anqw sit.',
                                    price: '25',
                                    checkbox: true,
                                  ),
                                  SelectRow(
                                    text: 'Lorem ipsum dolor sit amet',
                                    price: '5',
                                    checkbox: true,
                                  ),
                                  SelectRow(
                                    text: 'Lorem ipsum dolor sit.',
                                    price: '10',
                                    checkbox: true,
                                  ),
                                  SelectRow(
                                    text: 'Lorem ipsum dolor sit amet consectetur.',
                                    price: '15',
                                    checkbox: true,
                                  ),
                                  SelectRow(
                                    text: 'Lorem ipsum dsdolor sit',
                                    price: '5',
                                    checkbox: true,
                                  ),
                                  SelectRow(
                                    text: 'Lorem ipsum anqw sit.',
                                    price: '25',
                                    checkbox: true,
                                  ),
                                  SelectRow(
                                    text: 'Lorem ipsum dolor sit amet',
                                    price: '5',
                                    checkbox: true,
                                  ),
                                  SelectRow(
                                    text: 'Lorem ipsum dolor sit.',
                                    price: '10',
                                    checkbox: true,
                                  ),
                                  SelectRow(
                                    text: 'Lorem ipsum dolor sit amet consectetur.',
                                    price: '15',
                                    checkbox: true,
                                  ),
                                  SelectRow(
                                    text: 'Lorem ipsum dsdolor sit',
                                    price: '5',
                                    checkbox: true,
                                  ),
                                  SelectRow(
                                    text: 'Lorem ipsum anqw sit.',
                                    price: '25',
                                    checkbox: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20,
                                    top: mediaHeight > 900
                                        ? .1 * mediaHeight
                                        : 20),
                                child: Text("Subtotal",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                const EdgeInsets.only(
                                    left: 20, top: 20, right: 10),
                                child: Text(
                                  "20\$",
                                  style: TextStyle(color: Colors.green[700]),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: mediaHeight > 900 ? 10 : .06 * mediaHeight,
                          ),
                          Container(
                            width: mediaWidth,
                            height: mediaHeight > 900
                                ? .15 * mediaHeight
                                : .2 * MediaQuery
                                .sizeOf(context)
                                .height,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
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
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 20),
                                      child: Text("Total",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: primary,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 20, right: 10),
                                      child: Text(
                                        "20\$",
                                        style: TextStyle(color: primary),
                                      ),
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
                                    // Navigator.pushNamed(context, checkOut);
                                  },
                                  text: 'Update',
                                  size: 20,
                                  buttomWidth: .75 * MediaQuery
                                      .sizeOf(context)
                                      .width,
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
