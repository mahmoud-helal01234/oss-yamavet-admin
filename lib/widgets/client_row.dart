import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/controllers/ClientsProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/models/clients_model.dart';
import 'package:yama_vet_admin/data/services/api.dart';
import 'package:yama_vet_admin/screens/client_profile.dart';

import '../controllers/UsersProvider.dart';
import '../core/utils/strings.dart';

class ClientRow extends StatefulWidget {
  const ClientRow({super.key});

  @override
  State<ClientRow> createState() => _ClientRowState();
}

class _ClientRowState extends State<ClientRow> {
  @override
  void initState() {
    super.initState();
    Provider.of<ClientsProvider>(context, listen: false).get(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientsProvider>(
        builder: (context, clientsProvider, child) {
      return Container(
        width: 400.w,
        height: MediaQuery.sizeOf(context).height > 900 ? 700.h : 500.h,
        child: ListView.builder(
          itemCount: clientsProvider.clients.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    print("here:");
                    // Navigator.pushNamed(context, clientProfile);
                    // Navigator.pushNamed(
                    //   context,
                    //   clientProfile,
                    //   arguments: {
                    //     'clientIndex': index,
                    //   },
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ClientProfile(clientIndex: index)),
                    );
                  },
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15.w,
                      ),
                      Container(
                        width: 50.w,
                        height: 55.h,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(5.sp)),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Image.asset("assets/images/female_one.png"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        clientsProvider.clients[index].name!,
                        style: TextStyle(
                            fontSize: MediaQuery.sizeOf(context).width > 650
                                ? 10.sp
                                : 7.sp),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            "active".tr(),
                            style: TextStyle(
                                fontSize: MediaQuery.sizeOf(context).width > 650
                                    ? 10.sp
                                    : 7.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Switch(
                              activeColor: primary,
                              value:
                                  clientsProvider.clients[index].active == '1'
                                      ? true
                                      : false,
                              onChanged: (val) {
                                Provider.of<ClientsProvider>(context,
                                        listen: false)
                                    .toggleActivation(context, index);
                              }),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20.sp,
                            color: Colors.grey,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  indent: 10.h,
                  endIndent: 10.h,
                  thickness: .5.w,
                )
              ],
            );
          },
        ),
      );
    });
  }
}
