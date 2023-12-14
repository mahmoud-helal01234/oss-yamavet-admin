import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';
import 'package:yama_vet_admin/data/models/requests/AddCategoryRequest.dart';
import 'package:yama_vet_admin/data/models/requests/AddServiceRequest.dart';
import 'package:yama_vet_admin/data/models/services_model.dart';
import 'package:yama_vet_admin/data/services/api.dart';
import 'package:yama_vet_admin/widgets/custom_add_buttom.dart';
import 'package:http/http.dart' as http;

import '../controllers/CategoriesProvider.dart';
import '../data/models/dtos/Service.dart';
import '../data/models/responses/CategoriesResponse.dart';

class AddServices extends StatefulWidget {
  AddServices({super.key, required this.categoryIndex});

  int? categoryIndex;
  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  TextEditingController name_ar = TextEditingController();
  TextEditingController name_en = TextEditingController();
  TextEditingController price = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    double mediaHeight = MediaQuery.sizeOf(context).height;
    return Center(
      child: Container(
        width: .95 * mediaWidth,
        height: .2 * mediaHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
            border: Border.all(color: primary, width: 2.w)),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: mediaWidth > 650 ? 400.w : 250.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.sp),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.w, top: 10.h),
                        child: TextField(
                          controller: name_en,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                              hintText: 'services'),
                        ),
                      ),
                    ),
                    Container(
                      width: 80.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.sp),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: TextField(
                          controller: price,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                              hintText: 'Price\t\t\t\t\t \$'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaWidth > 650 ? 20.h : 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: mediaWidth > 650 ? 400.w : 350.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.sp),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.w, top: 10.h),
                        child: TextField(
                            // textDirection: TextDirection.rtl,
                            controller: name_ar,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                              hintText: 'خدمة',
                            )
                            // hintTextDirection: TextDirection.rtl),
                            ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: mediaWidth > 650 ? 10.h : 10.h,
                ),
                Container(
                  width: .8 * mediaWidth,
                  height: 30.h,
                  child: MaterialButton(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.sp)),
                    height: mediaWidth > 650 ? 35.h : 30.h,
                    color: primary,
                    onPressed: () async {
                      Provider.of<CategoriesProvider>(context, listen: false)
                          .createService(
                              context,
                              AddServiceRequest(context,
                                  categoryId: Provider.of<CategoriesProvider>(
                                          context,
                                          listen: false)
                                      .categories[widget.categoryIndex!]
                                      .id!,
                                  nameAr: name_ar.text,
                                  nameEn: name_en.text,
                                  price: double.tryParse(price.text)));
                    },
                    child: Text(
                      "add".tr(),
                      style: TextStyle(
                          fontFamily: 'futur',
                          color: Colors.white,
                          fontSize: mediaWidth > 650 ? 22.sp : 17.sp),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
