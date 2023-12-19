import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/UsersProvider.dart';
import '../core/utils/colors.dart';
import '../core/utils/strings.dart';
import '../data/models/vets_model.dart';
import 'package:yama_vet_admin/data/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:yama_vet_admin/screens/Profile.dart';

class VetRow extends StatefulWidget {
  const VetRow({
    super.key,
  });

  @override
  State<VetRow> createState() => _VetRowState();
}

class _VetRowState extends State<VetRow> {
  @override
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context, listen: false).get(context);
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    return Consumer<UsersProvider>(builder: (context, usersProvider, child) {
      return Container(
        width: mediaWidth,
        height: mediaWidth > 650 ? 900 : 500,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: usersProvider.users.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: mediaWidth > 650
                      ? .07 * mediaWidth
                      : .05 * MediaQuery.sizeOf(context).width,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 100.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://yama-vet.com/${usersProvider.users[index].imgPath}"),
                            fit: BoxFit.cover)),
                  ),
                ),
                SizedBox(
                  width: mediaWidth > 650
                      ? .03 * mediaWidth.w
                      : .05 * MediaQuery.sizeOf(context).width,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/icon_doctor.png"),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            usersProvider.users[index].name!,
                            style: TextStyle(
                                fontSize: mediaWidth > 650 ? 10.sp : 20.sp),
                          ),
                          SizedBox(
                            width: .1 * MediaQuery.sizeOf(context).width,
                          ),
                        ],
                      ),
                      MaterialButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        height: 30.h,
                        onPressed: () async {
                          await Provider.of<UsersProvider>(context,
                                  listen: false)
                              .delete(context, index);
                        },
                        child: Text(
                          "Delete".tr(),
                          style: TextStyle(
                              fontSize: mediaWidth > 650 ? 15.sp : 20.sp,
                              fontFamily: 'futur',
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: mediaWidth > 650 ? .05 * mediaWidth.w : 0,
                ),
                Spacer(),
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          "rating".tr(),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow[600],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          usersProvider.users[index].totalRate ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.sp),
                        ),
                        Text(
                          "/5",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Profile(userIndex: index)));
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[500],
                  ),
                )
              ],
            );
          },
        ),
      );
    });
  }

// Future deleteAccount() async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   String json = sharedPreferences.getString("token")!;
//   print(json);
//   var request =
//   http.MultipartRequest("DELETE", Uri.parse('$deletVetsLink/$ddd'));
//   print(Uri.parse('$deletVetsLink/$ddd'));
//   print(ddd);
//   request.headers['api-token'] = 'yama-vets';
//   // request.fields['id'] = id.toString();
//   request.headers['Authorization'] = 'Bearer$json';
//
//   return await request.send().then((response) async {
//     if (response.statusCode == 200) {
//       print(" vets deleted successfully!");
//       final responseData = await response.stream.toBytes();
//       final responseString = String.fromCharCodes(responseData);
//       print(responseString);
//
//       return true;
//     } else {
//       print(response.stream.toString());
//       print("error-----${await response.stream.bytesToString()}");
//       return false;
//     }
//   });
// }
}
