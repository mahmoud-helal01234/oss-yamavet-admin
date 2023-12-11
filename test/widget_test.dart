/*
class CategoryServices {
  Future<List<Category>> getCategoriesNames() async {
    String url = categoriesLink;

    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> categories = data['data'];
    List<Category> categoriesList = [];
    for (var element in categories) {
      Category categoriesModel = Category(
          categoriesId: element['categories_id'],
          categoriesName: element['categories_name'],
          categoriesImage: element['categories_image'],
          categoriesDatatime: element['categories_datatime'],
          categoriesdescription: element['categories_description']);
      categoriesList.add(categoriesModel);
      // categoriesList.sort((a, b) => a.categoriesId.compareTo(b.categoriesId));
    }
    if (response.statusCode == 200) {
      print("sucecess response");
      if (data['status'] == 'success') {
        print("sucess data");
        print(data['data']);
      } else {
        print("fail data");
      }
    } else {
      print(response.statusCode);
    }

    print("==================${categoriesList[0].categoriesName}");
    return categoriesList;
  }
}
*/