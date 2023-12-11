import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:yama_vet_admin/data/models/requests/AddServiceRequest.dart';

import '../data/models/dtos/Client.dart';
import '../data/models/requests/UpdateServiceRequest.dart';
import '../data/models/responses/ClientsResponse.dart';
import '../data/services/ApiService.dart';

class ClientsProvider extends ChangeNotifier {
  List<Client> clients = [];

  void replace(List<Client> newClients) {
    clients = newClients;
    notifyListeners();
  }

  Future<void> get(BuildContext context) async {
    ClientsResponse clientsResponse = ClientsResponse.fromJson(
        await ApiService()
            .get("client/select", context: context, componentName: "Client"));
    clients = clientsResponse.clients!;
    notifyListeners();
  }

  Future<void> toggleActivation(BuildContext context, int clientIndex) async {

    await ApiService().getAction(
        "client/toggle_activation/${clients[clientIndex].id!}",
        context: context,
        componentName: "Client",actionName: "Activated/Deactivated");

    clients[clientIndex].active =
        clients[clientIndex].active == "0" ? "1" : "0";
    notifyListeners();
  }
}
