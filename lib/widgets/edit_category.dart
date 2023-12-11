import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_widget/image_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/controllers/CategoriesProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';
import 'package:yama_vet_admin/data/services/api.dart';
import 'package:yama_vet_admin/widgets/custom_containers.dart';
import 'package:http/http.dart' as http;

import '../data/models/responses/CategoriesResponse.dart';

class EditCategory extends StatefulWidget {
  EditCategory({super.key});

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

  Future updateCategories() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String json = sharedPreferences.getString("token")!;
    print(json);
    var request = http.MultipartRequest("POST", Uri.parse(updateCategoryLink));
    request.headers['api-token'] = 'yama-vets';
    request.fields['id'] = id.toString();
    request.fields['name_ar'] = name_er.text;
    request.fields['name_en'] = name_en.text;
    request.headers['Authorization'] = 'Bearer${json}';
    request.files.add(await http.MultipartFile.fromPath(
      'img_path',
      updated_file!.path,
    ));
    return await request.send().then((response) async {
      if (response.statusCode == 200) {
        print("updated categories ********* !!!!!!!!!!!");
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
    double mediaWidth = MediaQuery.sizeOf(context).height;
    return Center(
      child: Container(
        margin: EdgeInsets.only(right: 30),
        width: .42 * mediaWidth,
        height: .3 * mediaHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: primary, width: 2)),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: DottedBorder(
                      color: primary,
                      strokeWidth: 2,
                      dashPattern: [5, 5],
                      borderType: BorderType.Circle,
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.transparent,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Color(0xff0aaeac),
                          child: Image.asset(
                            "assets/images/vaci.png",
                            width: 100,
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
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(20)),
                        child: ImagePickerWidget(
                          editIcon: Center(
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 17,
                            ),
                          ),
                          backgroundColor: primary,
                          diameter: 50,
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
                height: 10,
              ),
              EditAndAddContainer(
                enText: 'Vaccination',
                arText: 'تلقيح',
                arController: name_er,
                enController: name_en,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    elevation: 10,
                    minWidth: 140,
                    height: 25,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Color(0xffba94b9),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel",
                        style: TextStyle(
                            fontFamily: 'futur',
                            color: Colors.white,
                            fontSize: 15)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Consumer<CategoriesProvider>(
                      builder: (context, categoriesProvider, child) {
                        return MaterialButton(
                        elevation: 10,
                        minWidth: 140,
                        height: 25,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: primary,
                        onPressed: () async {
                          setState(() {
                            id = categoriesProvider.categories[index].id;
                          });
                          await updateCategories();
                        },
                        child: Text("Update",
                            style: TextStyle(
                                fontFamily: 'futur',
                                color: Colors.white,
                                fontSize: 15)),
                      );
                    }
                  ),
                ],
              ),
            ]);
          },
        ),
      ),
    );
  }
}
