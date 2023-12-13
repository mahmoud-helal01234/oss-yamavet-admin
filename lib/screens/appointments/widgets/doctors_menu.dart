import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/models/doctor_models.dart';
import 'package:yama_vet_admin/data/services/api.dart';

import '../../../controllers/AppointmentsProvider.dart';
import '../../../controllers/UsersProvider.dart';

// ignore: must_be_immutable
class DoctorsChooseMenu extends StatefulWidget {
  DoctorsChooseMenu({
    super.key,
  });

  @override
  State<DoctorsChooseMenu> createState() => _DoctorsChooseMenuState();
}

class _DoctorsChooseMenuState extends State<DoctorsChooseMenu> {
  DoctorModel? doctorModel;
  bool _isLoading = false;
  // List<bool> check = [];
  @override
  void initState() {

    super.initState();

    Provider.of<UsersProvider>(context, listen: false).get(null);


  }


  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    return _isLoading!
        ? Center(
            child: CircularProgressIndicator(
              color: primary,
            ),
          )
        : Container(
            width: 500,
            height: 400,
            child: Consumer<UsersProvider>(
                builder: (context, usersProvider, child) {
                  return ListView.builder(
                  itemCount: usersProvider.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    // print("doccccccccccccc$doctorList");
                    return Column(
                      children: [
                        Container(
                          width: mediaWidth > 650 ? 500 : 370,
                          height: 50,
                          // color: check[index] ? primary : Colors.transparent,
                          child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: mediaWidth > 650
                                      ? 1
                                      : .01 * MediaQuery.sizeOf(context).width,
                                ),
                                Container(
                                  width: 70,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://yama-vet.com/${usersProvider.users[index].imgPath}"),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: mediaWidth > 650
                                      ? 5
                                      : .01 * MediaQuery.sizeOf(context).width,
                                ),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/icon_doctor.png",
                                            color:
                                            // check[index] ? Colors.white:
                                            Colors.black,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            usersProvider.users![index].name!,
                                            style: TextStyle(
                                                color:
                                                // check[index]
                                                //     ?
                                                // Colors.white
                                                Colors.black
                                            ),
                                          ),
                                          SizedBox(
                                            width: mediaWidth > 400
                                                ? .15 *
                                                    MediaQuery.sizeOf(context).width
                                                : .05 * mediaWidth,
                                          ),
                                        ],
                                      ),
                                    ]),
                                Spacer(),
                                // Transform.scale(
                                //   scale: 1.3,
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(bottom: 5),
                                //     child: Checkbox(
                                //       fillColor: MaterialStateProperty.resolveWith(
                                //           (states) {
                                //         if (!states
                                //             .contains(MaterialState.selected)) {
                                //           return Colors.white;
                                //         }
                                //         return null;
                                //       }),
                                //       shape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular(1)),
                                //       side: BorderSide(
                                //         color: primary,
                                //         width: 1,
                                //       ),
                                //       activeColor:
                                //           check[index] ? Colors.white : primary,
                                //       checkColor:
                                //           check[index] ? primary : Colors.white,
                                //       value: check[index],
                                //       onChanged: (val) async {
                                //         setState(() {
                                //           if (val == true) {
                                //             doctors.add(doctorList[index]);
                                //           } else {
                                //             for (var i = 0;
                                //                 i < doctors.length;
                                //                 i++) {
                                //               if (doctors[i].id ==
                                //                   doctorList[index].id) {
                                //                 doctors.remove(doctors[i]);
                                //               }
                                //             }
                                //           }
                                //
                                //           check[index] = val!;
                                //         });
                                //         Map<String, String> doctorsMap = {};
                                //
                                //         for (int i = 0; i < doctors.length; i++) {
                                //           doctorsMap.addAll({
                                //             'doctors[${i.toString()}][id]':
                                //                 doctors[i].id.toString()
                                //           });
                                //         }
                                //         String encode = json.encode(doctorsMap);
                                //         SharedPreferences sharedPreferences =
                                //             await SharedPreferences.getInstance();
                                //         sharedPreferences.setString(
                                //             'doctoresEncoded', encode);
                                //         print(encode);
                                //       },
                                //     ),
                                //   ),
                                // ),
                              ]),
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 1.5,
                        ),
                      ],
                    );
                  },
                );
              }
            ),
          );
  }
}
