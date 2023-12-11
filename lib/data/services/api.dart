
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';

import 'package:yama_vet_admin/data/models/clients_model.dart';
import 'package:yama_vet_admin/data/models/doctor_models.dart';
import 'package:yama_vet_admin/data/models/offers_model.dart';
import 'package:http/http.dart' as http;
import 'package:yama_vet_admin/data/models/responses/AppointmentResponse.dart';
import 'package:yama_vet_admin/data/models/vets_model.dart';
import '../models/dtos/Service.dart';

class Api {

  Future<List<OffersModel>> getOffers() async {
    http.Response response = await http.get(Uri.parse(offersLink), headers: {
      "api-token": "yama-vets",
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> offers = data['data'];
    List<OffersModel> offersList = [];
    for (var element in offers) {
      OffersModel offersModel = OffersModel(
          id: element['id'],
          img_path: element['img_path'],
          link: element['link']);
      offersList.add(offersModel);
    }

    if (response.statusCode == 200) {
      print("sucecess response");
      if (data['status'] == true) {
        print("sucess data");
        print(data['data']);
      } else {
        print("fail data");
      }
    } else {
      print(response.statusCode);
    }

    print("==================${offersList}");
    return offersList;
  }


  //*get token function
  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return token;
  }

  //*get vets
  Future getVets() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String json = sharedPreferences.getString("token")!;
    http.Response response = await http.get(
      Uri.parse(getVetsLink),
      headers: {"api-token": "yama-vets", "Authorization": "Bearer$json"},
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> vets = data['data'];
    List<VetsModel> vetsList = [];
    for (var element in vets) {
      VetsModel vetsModel = VetsModel(
          name: element['name'],
          role: element['role'],
          img_path: element['img_path'],
          active: element['active'],
          total_rate: element['total_rate'],
          phone: element['phone'],
          id: element['id']);

      vetsList.add(vetsModel);
    }
    if (response.statusCode == 200) {
      print("sucecess response vets");
      if (data['status'] == true) {
        print("sucess data");
        print(data['data']);
      } else {
        print("fail data");
      }
    } else {
      print(response.statusCode);
    }

    print("==================${vetsList}");
    return vetsList;
  }



  //^ get appointment
  Future getAppoint() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String json = sharedPreferences.getString("token")!;
    http.Response response = await http.get(Uri.parse(appointmentsLink),
        headers: {"api-token": "yama-vets", "Authorization": "Bearer$json"});
    dynamic jsonResponse = jsonDecode(response.body);
    AppointmentsResponse appointmentsResponse = AppointmentsResponse.fromJson(jsonResponse);

    if (response.statusCode == 200) {

      print("sucecess response");
    } else {
      print(response.statusCode);
    }


    return appointmentsResponse.data;
  }


//*get doctors
  Future getDoctor() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String json = sharedPreferences.getString("token")!;
    http.Response response = await http.get(
      Uri.parse(getDoctorsLink),
      headers: {"api-token": "yama-vets", "Authorization": "Bearer$json"},
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> doctors = data['status'];
    List<DoctorModel> doctorList = [];
    for (var element in doctors) {
      DoctorModel doctorModel = DoctorModel(
          id: element['id'],
          img_path: element['img_path'],
          name: element['name']);

      doctorList.add(doctorModel);
    }
    if (response.statusCode == 200) {
      print("sucecess response vets");
      if (data['status'] == true) {
        print("sucess data");
        print(data['data']);
      } else {
        print("fail data");
      }
    } else {
      print(response.statusCode);
    }

    print("==================${doctorList}");
    return doctorList;
  }

  //* get services
  Future getServices() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String json = sharedPreferences.getString("token")!;
    http.Response response = await http.get(
      Uri.parse(getServicesLink),
      headers: {"api-token": "yama-vets", "Authorization": "Bearer$json"},
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> services = data['data'];
    List<Service> servicesList = [];
    for (var element in services) {
      Service service = Service();

      servicesList.add(service);
    }
    if (response.statusCode == 200) {
      print("sucecess response vets");
      if (data['status'] == true) {
        print("sucess data services");
        print(data['data']);
      } else {
        print("fail data");
      }
    } else {
      print(response.statusCode);
    }

    print("==================${servicesList}");
    return servicesList;
  }

//& get cleints
  Future getClients() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String json = sharedPreferences.getString("token")!;
    http.Response response = await http.get(
      Uri.parse(getClientsLink),
      headers: {"api-token": "yama-vets", "Authorization": "Bearer$json"},
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> clients = data['data'];
    List<ClientsModel> clientsList = [];
    for (var element in clients) {
      ClientsModel clientsModel = ClientsModel(
        id: element['id'],
        name: element['name'],
        phone: element['phone'],
        active: element['active'],
      );

      clientsList.add(clientsModel);
    }
    if (response.statusCode == 200) {
      print("sucecess response vets");
      if (data['status'] == true) {
        print("sucess data");
        print(data['data']);
      } else {
        print("fail data");
      }
    } else {
      print(response.statusCode);
    }

    print("==================${clientsList}");
    return clientsList;
  }
  //* get reminder 
  Future getReminder()async{
    // http.Response response = await http.get()
  }
}
