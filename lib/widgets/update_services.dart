import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/controllers/CategoriesProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:yama_vet_admin/core/utils/strings.dart';
import 'package:yama_vet_admin/data/models/responses/CategoriesResponse.dart';
import 'package:yama_vet_admin/data/services/api.dart';

import '../data/models/requests/UpdateServiceRequest.dart';

class UpdateService extends StatefulWidget {
  UpdateService({super.key});
  @override
  State<UpdateService> createState() => _UpdateServicesState();
}

class _UpdateServicesState extends State<UpdateService> {

  TextEditingController name_en = TextEditingController();
  TextEditingController name_ar = TextEditingController();
  TextEditingController price = TextEditingController();
  bool? _isLoading = false;

  @override
  void initState() {

    super.initState();
    name_en.text = Provider.of<CategoriesProvider>(context,listen: false).serviceToUpdate!.nameEn!;
    name_ar.text = Provider.of<CategoriesProvider>(context,listen: false).serviceToUpdate!.nameAr!;
    price.text = Provider.of<CategoriesProvider>(context,listen: false).serviceToUpdate!.price.toString();
  }

  Future updateServices(UpdateServiceRequest updateServiceRequest) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String json = await sharedPreferences.getString("token")!;

    http.Response response =
        await http.post(Uri.parse(updateServicesLink), headers: {
      'api-token': 'yama-vets',
      'Authorization': 'Bearer$json'
    }, body: {

    });
    if (response.statusCode == 200) {
      print(" services updated successfully!");

      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.sizeOf(context).height;
    double mediaWidth = MediaQuery.sizeOf(context).width;
    return _isLoading!
        ? Center(
            child: CircularProgressIndicator(
              color: primary,
            ),
          )
        : Center(
            child: Container(
              width: .9 * mediaWidth,
              height: .2 * mediaHeight,
              decoration:
                  BoxDecoration(border: Border.all(color: primary, width: 2)),
              child: Consumer<CategoriesProvider>(
                  builder: (context, categoriesProvider, child) {
                    return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: mediaWidth > 650 ? 400 : 235,
                                    height: mediaWidth > 650 ? 40 : 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.grey)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 5,
                                          top: 2,
                                          bottom: mediaWidth > 650 ? 5 : 0),
                                      child: TextField(
                                        controller: name_en,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500),
                                            hintText:
                                                'Canine Parainfluenza vaccination'),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: mediaWidth > 650 ? 100 : 80,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.grey)),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: TextField(
                                        controller: price,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500),
                                            hintText: '35\t\t\t\t\t\t\t\t \$'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: mediaWidth > 650 ? 400 : 235,
                                  height: mediaWidth > 650 ? 40 : 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.grey)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 5, top: mediaWidth > 650 ? 15 : 10),
                                    child: TextField(
                                      controller: name_ar,
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(

                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500),
                                          hintText: 'تطعيم الكلاب ضد الانفلونزا',
                                          hintTextDirection: TextDirection.rtl),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: mediaWidth > 650 ? 10 : 0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  minWidth: .57 * mediaWidth,
                                  height: mediaWidth > 650 ? 35 : 30,
                                  color: primary,
                                  onPressed: () async {

                                    Provider.of<CategoriesProvider>(context, listen: false)
                                        .updateService(context, UpdateServiceRequest(context,
                                        id: Provider.of<CategoriesProvider>(context,listen: false).serviceToUpdate!.id,
                                        categoryId: Provider.of<CategoriesProvider>(context,listen: false).serviceToUpdate!.categoryId,
                                        nameAr: name_ar.text,
                                        nameEn: name_en.text,
                                        price: double.tryParse(price.text)));

                                  },
                                  child: Text(
                                    "Update ",
                                    style: TextStyle(
                                        fontFamily: 'futur',
                                        color: Colors.white,
                                        fontSize: 17),
                                  ),
                                ),
                                MaterialButton(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  minWidth: mediaWidth > 650
                                      ? .2 * mediaWidth
                                      : .08 * mediaWidth,
                                  height: 30,
                                  color: Colors.red,
                                  onPressed: () {
                                    Provider.of<CategoriesProvider>(context, listen: false)
                                        .deleteService(context,Provider.of<CategoriesProvider>(context,listen: false).serviceToUpdate!.id!);
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        fontFamily: 'futur',
                                        color: Colors.white,
                                        fontSize: 17),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              ),
            ),
          );
  }
}
