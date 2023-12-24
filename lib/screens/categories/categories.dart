import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker_widget/image_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/controllers/CategoriesProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';
import 'package:yama_vet_admin/data/models/requests/AddCategoryRequest.dart';
import 'package:yama_vet_admin/screens/menu.dart';
import 'package:yama_vet_admin/screens/categories/vaccination.dart';
import 'package:yama_vet_admin/widgets/custom_add_buttom.dart';
import 'package:yama_vet_admin/widgets/custom_containers.dart';
import 'package:http/http.dart' as http;

class CategoryChoose extends StatefulWidget {
  const CategoryChoose({super.key});

  @override
  State<CategoryChoose> createState() => _CategoryChooseState();
}

class _CategoryChooseState extends State<CategoryChoose> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool ontap = false;
  File? choosen_file;
  File? updated_file;
  int? id;
  int? ddd;
  bool? _isLoading = false;
  TextEditingController name_er = TextEditingController();
  TextEditingController name_en = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  Future<void> getCategories() async {
    setState(() {
      _isLoading = true;
    });

    Provider.of<CategoriesProvider>(context, listen: false).get(context);
    setState(() {
      _isLoading = false;
    });
  }

  Future deletCategory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String json = sharedPreferences.getString("token")!;
    print(json);
    var request =
        http.MultipartRequest("DELETE", Uri.parse('$deleteCategoryLink/$ddd'));
    request.headers['api-token'] = 'yama-vets';
    request.fields['id'] = id.toString();
    request.headers['Authorization'] = 'Bearer${json}';
    request.files.clear();
    return await request.send().then((response) async {
      if (response.statusCode == 200) {
        print(" category deleted successfully!");
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        print(responseString);

        return true;
      } else {
        print("error-----${await response.stream.bytesToString()}");
        return false;
      }
    });
  }

  Future addCategory(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String json = sharedPreferences.getString("token")!;
    print(json);
    var request = http.MultipartRequest("POST", Uri.parse(addCategoriesLink));
    request.headers['api-token'] = 'yama-vets';
    request.fields['name_ar'] = name_er.text;
    request.fields['name_en'] = name_en.text;
    request.headers['Authorization'] = 'Bearer${json}';
    if (choosen_file == null) {
      print("choose file");

      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please select image first!',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,
      );
      return;
    }
    request.files.add(await http.MultipartFile.fromPath(
      'img_path',
      choosen_file!.path,
    ));
    return await request.send().then((response) async {
      if (response.statusCode == 200) {
        print("Uploaded image categories!");
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        print(responseString);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Category added successfully',
          autoCloseDuration: const Duration(seconds: 2),
          showConfirmBtn: false,
        );

        return true;
      } else {
        print("error-----${await response.stream.bytesToString()}");
        return false;
      }
    });
  }

  Future updateCategory() async {
    var request = http.MultipartRequest("POST", Uri.parse(updateOfferLink));
    request.headers['api-token'] = 'yama-vets';
    request.fields['id'] = id.toString();
    request.fields['link'] = 'www//wogod';
    request.files.add(await http.MultipartFile.fromPath(
      'img_path',
      updated_file!.path,
    ));
    return await request.send().then((response) async {
      if (response.statusCode == 200) {
        print("updated !!!!!!!!!!!");
        return true;
      } else {
        print("error-----${await response.stream.bytesToString()}");
        return false;
      }
    });
  }

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
                        : .3 * mediaWidth.sp,
                  ),
                  Center(
                    child: Text(
                      "categories".tr(),
                      style: TextStyle(
                          fontFamily: 'futurBold',
                          color: primary,
                          fontSize: 20.sp),
                    ),
                  ),
                  SizedBox(
                    height: mediaHeight > 900 ? 20.sp : 0,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: mediaHeight > 900 ? 50.w : 30.w,
                    top: 10.h,
                    right: 10.w),
                child: Text(
                  "categories".tr(),
                  style: TextStyle(
                      fontSize: mediaHeight > 900 ? 20.sp : 20.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: mediaWidth > 650 ? 20.h : 10.h,
              ),
              _isLoading!
                  ? Center(
                      child: CircularProgressIndicator(
                        color: primary,
                      ),
                    )
                  : Container(
                      width: 400.w,
                      height: mediaHeight > 900 ? 200.h : 150.h,
                      child: Consumer<CategoriesProvider>(
                          builder: (context, categoriesProvider, child) {
                        return ListView.builder(
                          padding: EdgeInsets.only(left: 10.w),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categoriesProvider.categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        id = categoriesProvider
                                            .categories[index].id;
                                        ddd = categoriesProvider
                                            .categories[index].id;
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Vaccination(
                                                  categoryIndex: index)));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0.sp),
                                      child: CircleAvatar(
                                        radius: 40.sp,
                                        backgroundImage: NetworkImage(
                                            "https://yama-vet.com/${categoriesProvider.categories[index].imgPath}"),
                                      ),
                                    )),
                                Text(
                                  categoriesProvider.categories[index].nameEn!,
                                  style: TextStyle(
                                      fontSize:
                                          mediaWidth > 650 ? 10.sp : 15.sp),
                                ),
                              ],
                            );
                          },
                        );
                      }),
                    ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width:
                        mediaWidth > 650 ? .05 * mediaWidth : .1 * mediaWidth,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            ontap = !ontap;
                          });
                        },
                        child: Container(
                          width: mediaWidth > 650 ? 100.w : 70.w,
                          height: mediaWidth > 650 ? 80.h : 65.h,
                          child: DottedBorder(
                              color: primary,
                              strokeWidth: 2,
                              dashPattern: [10, 5],
                              borderType: BorderType.Circle,
                              child: Center(
                                  child: Image.asset("assets/images/add.png"))),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "addcategory".tr(),
                        style: TextStyle(
                            fontSize: mediaWidth > 650 ? 10.sp : 15.sp,
                            color: primary,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              ontap
                  ? Center(
                      child: Container(
                        width: .8 * mediaWidth,
                        height: mediaHeight > 900
                            ? .35 * mediaHeight
                            : .3 * mediaHeight,
                        decoration: BoxDecoration(
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: primary, width: 2)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              width: mediaWidth > 650 ? 100.w : 70.w,
                              height: mediaWidth > 650 ? 90.h : 65.h,
                              child: DottedBorder(
                                  color: primary,
                                  strokeWidth: 1,
                                  dashPattern: [10, 4],
                                  borderType: BorderType.Circle,
                                  child: Container(
                                    width: 300.w,
                                    child: Center(
                                      child: ImagePickerWidget(
                                        editIcon: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 25.sp,
                                        ),
                                        backgroundColor: Colors.white,
                                        diameter: 50.sp,
                                        fit: BoxFit.none,
                                        initialImage: AssetImage(
                                            "assets/images/upload.png"),
                                        shape: ImagePickerWidgetShape.circle,
                                        isEditable: true,
                                        shouldCrop: true,
                                        imagePickerOptions: ImagePickerOptions(
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
                            ),
                            SizedBox(height: 10.h),
                            EditAndAddContainer(
                              enText: 'Category name',
                              arText: 'اسم الفئة',
                              arController: name_er,
                              enController: name_en,
                            ),
                            CustomAddButton(
                              onPress: () async {
                                print("before");
                                Provider.of<CategoriesProvider>(context,
                                        listen: false)
                                    .create(
                                        context,
                                        AddCategoryRequest(context,
                                            file: choosen_file,
                                            nameAr: name_er.text,
                                            nameEn: name_en.text));
                                print("after");
                              },
                              minwidth: .7 * mediaWidth,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 10.h,
              )
            ]))));
  }
}
