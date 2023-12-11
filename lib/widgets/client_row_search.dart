import 'package:flutter/material.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';

class ClientSearch extends StatefulWidget {
  const ClientSearch({super.key});

  @override
  State<ClientSearch> createState() => _ClientSearchState();
}

class _ClientSearchState extends State<ClientSearch> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          width: 50,
          height: 55,
          decoration: BoxDecoration(
              color: primary, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Image.asset("assets/images/female_one.png"),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          "Rachel Green \n\n",
          style: TextStyle(),
        ),
        Spacer(),
        Checkbox(
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (!states.contains(MaterialState.selected)) {
                return Colors.white;
              }
              return null;
            }),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            side: BorderSide(
              color: primary,
              width: 1,
            ),
            activeColor: primary,
            checkColor: Colors.white,
            value: selected,
            onChanged: (val) {
              setState(() {
                selected = val!;
              });
            }),
      ],
    );
  }
}
