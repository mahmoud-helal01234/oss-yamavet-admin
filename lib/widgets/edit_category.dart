import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker_widget/image_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/controllers/AppointmentsProvider.dart';
import 'package:yama_vet_admin/controllers/CategoriesProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';
import 'package:yama_vet_admin/data/services/api.dart';
import 'package:yama_vet_admin/widgets/custom_containers.dart';
import 'package:http/http.dart' as http;

import '../data/models/requests/UpdateCategoryRequest.dart';
import '../data/models/responses/CategoriesResponse.dart';

class EditCategory extends StatefulWidget {
  EditCategory({super.key,this.categoryIndex});
  int? categoryIndex;
  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  TextEditingController name_er = TextEditingController();

  TextEditingController name_en = TextEditingController();

  File? updated_file;
  File? choosen_file;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  int? id;
  int? ddd;

  // Future updateCategories() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String json = sharedPreferences.getString("token")!;
  //   print(json);
  //   var request = http.MultipartRequest("POST", Uri.parse(updateCategoryLink));
  //   request.headers['api-token'] = 'yama-vets';
  //   request.fields['id'] = id.toString();
  //   request.fields['name_ar'] = name_er.text;
  //   request.fields['name_en'] = name_en.text;
  //   request.headers['Authorization'] = 'Bearer${json}';
  //   if(updated_file != null) {
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'img_path',
  //       updated_file!.path,
  //     ));
  //   }
  //   return await request.send().then((response) async {
  //     if (response.statusCode == 200) {
  //       print("updated categories ********* !!!!!!!!!!!");
  //       return true;
  //     } else {
  //       print("error-----${await response.stream.bytesToString()}");
  //       return false;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height;
    double mediaWidth = MediaQuery.sizeOf(context).height;
    return Center(
      child: Container(
        margin: EdgeInsets.only(right: 30.sp, left: 30.sp),
        width: mediaWidth > 650 ? .5 * mediaWidth.w : .42 * mediaWidth,
        height: mediaWidth > 650 ? .35 * mediaHeight : .3 * mediaHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
            border: Border.all(color: primary, width: 2.w)),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              SizedBox(
                height: 10.h,
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.sp),
                    child: DottedBorder(
                      color: primary,
                      strokeWidth: 2,
                      dashPattern: [5, 5],
                      borderType: BorderType.Circle,
                      child: CircleAvatar(
                        radius: 28.sp,
                        backgroundColor: Colors.transparent,
                        child: CircleAvatar(
                          radius: 35.sp,
                          backgroundColor: Color(0xff0aaeac),
                          child: Image.asset(
                            "assets/images/vaci.png",
                            width: 100.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 25.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(20.sp)),
                        child: ImagePickerWidget(
                          editIcon: Center(
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 17.sp,
                            ),
                          ),
                          backgroundColor: primary,
                          diameter: 50.sp,
                          fit: BoxFit.none,
                          // initialImage: AssetImage("assets/images/upload.png"),
                          shape: ImagePickerWidgetShape.circle,
                          isEditable: true,
                          shouldCrop: true,
                          imagePickerOptions:
                              ImagePickerOptions(imageQuality: 65),
                          onChange: (file) {
                            print("I changed the file to: ${file.path}");
                            setState(() {
                              updated_file = File(file.path);
                            });
                          },
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 10.sp,
              ),
              EditAndAddContainer(
                enText: widget.categoryIndex != null?
                Provider.of<CategoriesProvider>(context,
                    listen: true)
                    .categories[widget.categoryIndex!].nameEn! : 'Category name',
                arText: widget.categoryIndex != null?
                Provider.of<CategoriesProvider>(context,
                    listen: true)
                    .categories[widget.categoryIndex!].nameAr! : 'اسم القسم',
                arController: name_er,
                enController: name_en,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    elevation: 10,
                    minWidth: 140.w,
                    height: 25.h,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.sp)),
                    color: Color(0xffba94b9),
                    onPressed: () {
                      Provider.of<CategoriesProvider>(context,
                          listen: false)
                          .toggleEditCategoryOpened();
                    },
                    child: Text("Cancel".tr(),
                        style: TextStyle(
                            fontFamily: 'futur',
                            color: Colors.white,
                            fontSize: 15.sp)),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Consumer<CategoriesProvider>(
                      builder: (context, categoriesProvider, child) {
                    return MaterialButton(
                      elevation: 10,
                      minWidth: 140.w,
                      height: 25.h,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.sp)),
                      color: primary,
                      onPressed: () async {
                        Provider.of<CategoriesProvider>(context, listen: false)
                            .update(
                                context,
                                UpdateCategoryRequest(context,
                                    id: categoriesProvider.categories[index].id,
                                    file: choosen_file,
                                    nameAr: name_er.text,
                                    nameEn: name_en.text));
                      },
                      child: Text("Update".tr(),
                          style: TextStyle(
                              fontFamily: 'futur',
                              color: Colors.white,
                              fontSize: 15.sp)),
                    );
                  }),
                ],
              ),
            ]);
          },
        ),
      ),
    );
  }
}
