import 'dart:developer' as dartDev;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:yama_vet_admin/data/models/requests/AddCategoryRequest.dart';
import 'package:yama_vet_admin/data/models/requests/AddServiceRequest.dart';

import '../data/models/dtos/Service.dart';
import '../data/models/requests/UpdateCategoryRequest.dart';
import '../data/models/requests/UpdateServiceRequest.dart';
import '../data/models/responses/CategoriesResponse.dart';
import '../data/services/ApiService.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Category> categories = [];

  CategoryService? serviceToUpdate;
  bool addServiceOpened = false;
  bool editCategoryOpened = false;

  CategoryService? getServiceByServiceId(int serviceId){
    if(categories.isEmpty){
      get();
    }

    for( Category category in categories ){
        for(CategoryService service in category!.services!){
          if(serviceId == service.id) {
            return service;
          }
        }
    }
    return null;

  }

  void toggleEditCategoryOpened() {
    editCategoryOpened = !editCategoryOpened;
    notifyListeners();
  }

  void toggleAddServiceOpened() {
    addServiceOpened = !addServiceOpened;
    notifyListeners();
  }

  double getTotalPriceForServiceIds(List<Service> serviceIds) {
    double totalPrice = 0;
    for (int index = 0; index < categories.length; index++) {
      for (int serviceIndex = 0;
          serviceIndex < categories[index].services!.length;
          serviceIndex++) {
        if (serviceIds.contains(categories[index].services![serviceIndex].id)) {
          totalPrice += categories[index].services![serviceIndex].price!;
        }
      }
    }
    return totalPrice;
  }

  void replace(List<Category> newCategories) {
    categories = newCategories;
    notifyListeners();
  }

  Future<void> get({BuildContext? context}) async {
    CategoriesResponse categoriesResponse = CategoriesResponse.fromJson(
        await ApiService().get("category", context: context));
    categories = categoriesResponse.categories!;
    notifyListeners();
  }

  Future<void> create(
      BuildContext context, AddCategoryRequest addCategoryRequest) async {
    Map<String, String> fields = <String, String>{};
    fields['name_ar'] = addCategoryRequest.nameAr!;
    fields['name_en'] = addCategoryRequest.nameEn!;

    if (addCategoryRequest.file == null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please select image first!',
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,
      );
      return;
    }
    Map<String, File> files = <String, File>{};

    files['img_path'] = addCategoryRequest!.file!;

    await ApiService().postWithFiles("category", fields, files,
        context: context, componentName: "Category");

    get();
  }

  Future<void> update(
      BuildContext context, UpdateCategoryRequest updateCategoryRequest) async {
    Map<String, String> fields = updateCategoryRequest.toJson();

    Map<String, File> files = <String, File>{};
    if (updateCategoryRequest.file != null) {
      files['img_path'] = updateCategoryRequest!.file!;
    }
    await ApiService().postWithFiles("category/update", fields, files,
        context: context, componentName: "Category",operationName: "Updated");

    get();
    toggleEditCategoryOpened();
  }

  Future<void> delete(BuildContext context, int categoryIndex) async {
    await ApiService().delete("category", categories[categoryIndex].id!,
        context: context, componentName: "Category");
    Navigator.pop(context);

    get();

    notifyListeners();
  }

  Future<void> deleteService(BuildContext context, int id) async {
    await ApiService()
        .delete("service", id, context: context, componentName: "Service");
    get();
  }

  Future<void> createService(
      BuildContext context, AddServiceRequest addServiceRequest) async {
    await ApiService().post("service", addServiceRequest.toJson(),
        context: context, componentName: "Service");
    addServiceOpened = false;
    notifyListeners();
    get();
  }

  Future updateService(
      BuildContext context, UpdateServiceRequest updateServiceRequest) async {
    Map<String, dynamic> requestItems = <String, dynamic>{};

    requestItems['category_id'] = updateServiceRequest.categoryId;
    requestItems['name_ar'] = updateServiceRequest.nameAr;
    requestItems['name_en'] = updateServiceRequest.nameEn;
    requestItems['price'] = updateServiceRequest.price;
    requestItems['id'] = updateServiceRequest.id;
    await ApiService().post("service/update", requestItems,
        context: context, componentName: "Service", operationName: "Updated");
    serviceToUpdate = null;
    notifyListeners();
    get();
  }
}
