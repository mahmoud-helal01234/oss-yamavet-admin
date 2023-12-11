import 'package:flutter/material.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/models/clients_model.dart';
import 'package:yama_vet_admin/data/services/api.dart';

class ClientShowMenu extends StatefulWidget {
  ClientShowMenu({super.key, required this.choosen});
  bool choosen;

  @override
  State<ClientShowMenu> createState() => _ClientShowMenuState();
}

class _ClientShowMenuState extends State<ClientShowMenu> {
  ClientsModel? clientsModel;
  List<ClientsModel> clientsList = [];
  Api api = Api();
  bool? _isLoading;
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getAllClients();
    setState(() {});
  }

  Future<void> getAllClients() async {
    clientsList = await api.getClients();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    return _isLoading!
        ? Center(
            child: CircularProgressIndicator(
              color: primary,
            ),
          )
        : Container(
            width: 500,
            height: 370,
            child: ListView.builder(
              itemCount: clientsList.length,
              itemBuilder: (BuildContext context, int index) {
                print("Clinnnnnnnnnnnnnnnnnn$clientsList");
                return Column(
                  children: [
                    Container(
                      width: mediaWidth > 650 ? 500 : 370,
                      height: 50,
                      color: widget.choosen ? primary : Colors.transparent,
                      child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: mediaWidth > 650
                                  ? 1
                                  : .01 * MediaQuery.sizeOf(context).width,
                            ),
                            // Image.network(
                            //   "https://yama-vet.com/${clientsList[index].name}",
                            //   width: 100,
                            // ),
                            SizedBox(
                              width: mediaWidth > 650
                                  ? 5
                                  : .01 * MediaQuery.sizeOf(context).width,
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/icon_doctor.png",
                                        color: widget.choosen
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        clientsList[index].name,
                                        style: TextStyle(
                                            color: widget.choosen
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      SizedBox(
                                        width: mediaWidth > 400
                                            ? .15 *
                                                MediaQuery.sizeOf(context).width
                                            : .05 * mediaWidth,
                                      ),
                                    ],
                                  ),
                                ]),
                            Spacer(),
                            Transform.scale(
                              scale: 1.3,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Checkbox(
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      if (!states
                                          .contains(MaterialState.selected)) {
                                        return Colors.white;
                                      }
                                      return null;
                                    }),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(1)),
                                    side: BorderSide(
                                      color: primary,
                                      width: 1,
                                    ),
                                    activeColor:
                                        widget.choosen ? Colors.white : primary,
                                    checkColor:
                                        widget.choosen ? primary : Colors.white,
                                    value: widget.choosen,
                                    onChanged: (val) {
                                      setState(() {
                                        widget.choosen = val!;
                                      });
                                    }),
                              ),
                            ),
                          ]),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1.5,
                    ),
                  ],
                );
              },
            ),
          );
  }
}
