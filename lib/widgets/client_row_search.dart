import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/controllers/AppointmentsProvider.dart';
import 'package:yama_vet_admin/controllers/ClientsProvider.dart';
import 'package:yama_vet_admin/controllers/RemindersProvider.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';

class ClientSearch extends StatefulWidget {

  ClientSearch({super.key, required this.clientIndex});

  int clientIndex;

  @override
  State<ClientSearch> createState() => _ClientSearchState();
}

class _ClientSearchState extends State<ClientSearch> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Provider.of<RemindersProvider>(context, listen: false).changeSelectedClient(context,widget.clientIndex);
      },
      child: Container(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              Container(
                width: 50.w,
                height: 55.h,
                decoration: BoxDecoration(
                    color: primary, borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Image.asset("assets/images/female_one.png"),
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                Provider.of<ClientsProvider>(context, listen: true).
                clients[widget.clientIndex].name!,
                style: TextStyle(),
              )
            ],
          ),
          const Divider(
            color: Colors.white,
            thickness: 2,
          )
        ],
      ),
    ),);
  }
}
