import 'package:flutter/material.dart';
import 'package:yama_vet_admin/core/utils/colors.dart';
import 'package:yama_vet_admin/data/models/appoint_model.dart';
import 'package:yama_vet_admin/data/models/clients_model.dart';
import 'package:yama_vet_admin/data/models/dtos/Appointment.dart';
import 'package:yama_vet_admin/data/services/api.dart';

// ignore: must_be_immutable
// class StatusRow extends StatefulWidget {
//   StatusRow({super.key, required this.status, required this.cash});
//   bool status;
//   final String cash;
//   @override
//   State<StatusRow> createState() => _StatusRowState();
// }
//
// class _StatusRowState extends State<StatusRow> {
//   AppointModel? appointModel;
//   ClientsModel? clientsModel;
//
//   Api api = Api();
//
//   bool _isloading = false;
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//
//
//   String? text;
//   @override
//   Widget build(BuildContext context) {
//     double mediaWidth = MediaQuery.sizeOf(context).width;
//     return _isloading!
//         ? Center(
//             child: CircularProgressIndicator(
//               color: Colors.deepOrange,
//             ),
//           )
//         : Container(
//             width: mediaWidth,
//             height: 50,
//             child: SingleChildScrollView(child: Column(children: [
//               Row(
//                 mainAxisAlignment: mediaWidth > 650
//                     ? MainAxisAlignment.spaceBetween
//                     : MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                       margin: mediaWidth > 650
//                           ? EdgeInsets.symmetric(horizontal: 20)
//                           : EdgeInsets.zero,
//                       width: .36 * mediaWidth,
//                       height: 40,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           border: Border.all(color: primary, width: 1.5)),
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(left: 2),
//                               child: Text(
//                                 "not collected",
//                                 style: TextStyle(
//                                     fontFamily: 'futur',
//                                     fontSize: 17,
//                                     color: Colors.black),
//                               ),
//                             ),
//                             GestureDetector(
//                                 onTap: () {
//                                   showMenu(
//                                     // shadowColor: primary,
//                                       constraints: const BoxConstraints(
//                                           maxWidth: 200, maxHeight: 150),
//                                       color: const Color(0xffefefef),
//                                       // elevation: 5,
//                                       context: context,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                           BorderRadius.circular(5),
//                                           side: BorderSide(color: primary)),
//                                       position: const RelativeRect.fromLTRB(
//                                           1, 425, 1, 4),
//                                       items: [
//                                         PopupMenuItem(
//                                             onTap: () {
//                                               setState(() {
//                                                 text = widget.cash;
//                                               });
//                                             },
//                                             value: 1,
//                                             child: StatefulBuilder(
//                                               builder: (BuildContext context,
//                                                   void Function(
//                                                       void Function())
//                                                   setState) {
//                                                 return Row(
//                                                   children: [
//                                                     Padding(
//                                                       padding:
//                                                       EdgeInsets.only(
//                                                           bottom: 10),
//                                                       child: Text(
//                                                         "not collected",
//                                                         style: TextStyle(
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w600,
//                                                             fontSize: 15),
//                                                       ),
//                                                     ),
//                                                     Transform.scale(
//                                                       scale: 1.1,
//                                                       child: Padding(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .only(
//                                                             bottom: 15),
//                                                         child: Checkbox(
//                                                             fillColor:
//                                                             MaterialStateProperty
//                                                                 .resolveWith(
//                                                                     (states) {
//                                                                   if (!states.contains(
//                                                                       MaterialState
//                                                                           .selected)) {
//                                                                     return Colors
//                                                                         .white;
//                                                                   }
//                                                                   return null;
//                                                                 }),
//                                                             shape: RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                     1)),
//                                                             side: BorderSide(
//                                                               color: primary,
//                                                               width: 1,
//                                                             ),
//                                                             activeColor:
//                                                             widget.status
//                                                                 ? Colors
//                                                                 .white
//                                                                 : primary,
//                                                             checkColor: widget
//                                                                 .status
//                                                                 ? primary
//                                                                 : Colors
//                                                                 .white,
//                                                             value:
//                                                             widget.status,
//                                                             onChanged: (val) {
//                                                               setState(() {
//                                                                 widget.status =
//                                                                 val!;
//                                                               });
//                                                             }),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 );
//                                               },
//                                             )),
//                                         PopupMenuItem(
//                                             onTap: () {
//                                               setState(() {
//                                                 text = widget.cash;
//                                               });
//                                             },
//                                             value: 1,
//                                             child: StatefulBuilder(
//                                               builder: (BuildContext context,
//                                                   void Function(
//                                                       void Function())
//                                                   setState) {
//                                                 return Row(
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       "collected",
//                                                       style: TextStyle(
//                                                           fontWeight:
//                                                           FontWeight.w600,
//                                                           fontSize: 15),
//                                                     ),
//                                                     Transform.scale(
//                                                       scale: 1.1,
//                                                       child: Padding(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .only(
//                                                           bottom: 10,
//                                                         ),
//                                                         child: Checkbox(
//                                                             fillColor:
//                                                             MaterialStateProperty
//                                                                 .resolveWith(
//                                                                     (states) {
//                                                                   if (!states.contains(
//                                                                       MaterialState
//                                                                           .selected)) {
//                                                                     return Colors
//                                                                         .white;
//                                                                   }
//                                                                   return null;
//                                                                 }),
//                                                             shape: RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                     1)),
//                                                             side: BorderSide(
//                                                               color: primary,
//                                                               width: 1,
//                                                             ),
//                                                             activeColor:
//                                                             widget.status
//                                                                 ? Colors
//                                                                 .white
//                                                                 : primary,
//                                                             checkColor: widget
//                                                                 .status
//                                                                 ? primary
//                                                                 : Colors
//                                                                 .white,
//                                                             value:
//                                                             widget.status,
//                                                             onChanged: (val) {
//                                                               setState(() {
//                                                                 widget.status =
//                                                                 val!;
//                                                               });
//                                                             }),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 );
//                                               },
//                                             ))
//                                       ]);
//                                 },
//                                 child: const Icon(
//                                     Icons.keyboard_arrow_down_sharp)),
//                           ])),
//                   const Text(
//                     "DD/MM/YY\t To\t DD/MM/YY",
//                     style: TextStyle(
//                         color: Colors.grey, fontWeight: FontWeight.bold),
//                   ),
//                   Container(
//                     margin: mediaWidth > 650
//                         ? EdgeInsets.only(right: 30)
//                         : EdgeInsets.zero,
//                     width: 30,
//                     height: 30,
//                     decoration: BoxDecoration(
//                         color: primary,
//                         borderRadius: BorderRadius.circular(5)),
//                     child: const Icon(
//                       Icons.calendar_month_outlined,
//                       color: Colors.white,
//                     ),
//                   )
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: mediaWidth > 650
//                     ? MainAxisAlignment.spaceBetween
//                     : MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                       margin: mediaWidth > 650
//                           ? EdgeInsets.symmetric(horizontal: 20)
//                           : EdgeInsets.zero,
//                       width: .36 * mediaWidth,
//                       height: 40,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           border: Border.all(color: primary, width: 1.5)),
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(left: 2),
//                               child: Text(
//                                 appointList[index].cash!,
//                                 style: TextStyle(
//                                     fontFamily: 'futur',
//                                     fontSize: 17,
//                                     color: Colors.black),
//                               ),
//                             ),
//                             GestureDetector(
//                                 onTap: () {
//                                   showMenu(
//                                     // shadowColor: primary,
//                                       constraints: const BoxConstraints(
//                                           maxWidth: 200, maxHeight: 150),
//                                       color: const Color(0xffefefef),
//                                       // elevation: 5,
//                                       context: context,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                           BorderRadius.circular(5),
//                                           side: BorderSide(color: primary)),
//                                       position: const RelativeRect.fromLTRB(
//                                           1, 425, 1, 4),
//                                       items: [
//                                         PopupMenuItem(
//                                             onTap: () {
//                                               setState(() {
//                                                 text = widget.cash;
//                                               });
//                                             },
//                                             value: 1,
//                                             child: StatefulBuilder(
//                                               builder: (BuildContext context,
//                                                   void Function(
//                                                       void Function())
//                                                   setState) {
//                                                 return Row(
//                                                   children: [
//                                                     Padding(
//                                                       padding:
//                                                       EdgeInsets.only(
//                                                           bottom: 10),
//                                                       child: Text(
//                                                         appointList[index]
//                                                             .cash!,
//                                                         style: TextStyle(
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w600,
//                                                             fontSize: 15),
//                                                       ),
//                                                     ),
//                                                     Transform.scale(
//                                                       scale: 1.1,
//                                                       child: Padding(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .only(
//                                                             bottom: 15),
//                                                         child: Checkbox(
//                                                             fillColor:
//                                                             MaterialStateProperty
//                                                                 .resolveWith(
//                                                                     (states) {
//                                                                   if (!states.contains(
//                                                                       MaterialState
//                                                                           .selected)) {
//                                                                     return Colors
//                                                                         .white;
//                                                                   }
//                                                                   return null;
//                                                                 }),
//                                                             shape: RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                     1)),
//                                                             side: BorderSide(
//                                                               color: primary,
//                                                               width: 1,
//                                                             ),
//                                                             activeColor:
//                                                             widget.status
//                                                                 ? Colors
//                                                                 .white
//                                                                 : primary,
//                                                             checkColor: widget
//                                                                 .status
//                                                                 ? primary
//                                                                 : Colors
//                                                                 .white,
//                                                             value:
//                                                             widget.status,
//                                                             onChanged: (val) {
//                                                               setState(() {
//                                                                 widget.status =
//                                                                 val!;
//                                                               });
//                                                             }),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 );
//                                               },
//                                             )),
//                                         PopupMenuItem(
//                                             onTap: () {
//                                               setState(() {
//                                                 text = widget.cash;
//                                               });
//                                             },
//                                             value: 1,
//                                             child: StatefulBuilder(
//                                               builder: (BuildContext context,
//                                                   void Function(
//                                                       void Function())
//                                                   setState) {
//                                                 return Row(
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       appointList[index]
//                                                           .cash!,
//                                                       style: TextStyle(
//                                                           fontWeight:
//                                                           FontWeight.w600,
//                                                           fontSize: 15),
//                                                     ),
//                                                     Transform.scale(
//                                                       scale: 1.1,
//                                                       child: Padding(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .only(
//                                                           bottom: 10,
//                                                         ),
//                                                         child: Checkbox(
//                                                             fillColor:
//                                                             MaterialStateProperty
//                                                                 .resolveWith(
//                                                                     (states) {
//                                                                   if (!states.contains(
//                                                                       MaterialState
//                                                                           .selected)) {
//                                                                     return Colors
//                                                                         .white;
//                                                                   }
//                                                                   return null;
//                                                                 }),
//                                                             shape: RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                     1)),
//                                                             side: BorderSide(
//                                                               color: primary,
//                                                               width: 1,
//                                                             ),
//                                                             activeColor:
//                                                             widget.status
//                                                                 ? Colors
//                                                                 .white
//                                                                 : primary,
//                                                             checkColor: widget
//                                                                 .status
//                                                                 ? primary
//                                                                 : Colors
//                                                                 .white,
//                                                             value:
//                                                             widget.status,
//                                                             onChanged: (val) {
//                                                               setState(() {
//                                                                 widget.status =
//                                                                 val!;
//                                                               });
//                                                             }),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 );
//                                               },
//                                             ))
//                                       ]);
//                                 },
//                                 child: const Icon(
//                                     Icons.keyboard_arrow_down_sharp)),
//                           ])),
//                   const Text(
//                     "DD/MM/YY\t To\t DD/MM/YY",
//                     style: TextStyle(
//                         color: Colors.grey, fontWeight: FontWeight.bold),
//                   ),
//                   Container(
//                     margin: mediaWidth > 650
//                         ? EdgeInsets.only(right: 30)
//                         : EdgeInsets.zero,
//                     width: 30,
//                     height: 30,
//                     decoration: BoxDecoration(
//                         color: primary,
//                         borderRadius: BorderRadius.circular(5)),
//                     child: const Icon(
//                       Icons.calendar_month_outlined,
//                       color: Colors.white,
//                     ),
//                   )
//                 ],
//               )
//             ],),)
//           );
//   }
// }
