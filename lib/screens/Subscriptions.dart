// import 'package:flutter/material.dart';
// import 'dart:convert';
//
// import 'MyFatoorahScreen.dart';
//
// class Subscriptions extends StatefulWidget {
//   @override
//   _SubscriptionsState createState() => _SubscriptionsState();
// }
//
// class _SubscriptionsState extends State<Subscriptions> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   int? selectedId;
//   String subscriptionStatus = "";
//   bool isSubscriped = false;
//   int subscriptionType = 0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     checkSubscription();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           iconTheme: new IconThemeData(color: Colors.white),
//           title: Text("الاشتراكات"),
//           centerTitle: true,
//           elevation: 0.4,
//         ),
//         body: ListView(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(
//                   top: 10, right: 10, left: 10, bottom: 10),
//               child: Container(
//                 width: double.infinity,
//                 margin: EdgeInsets.only(left: 10, right: 10),
//                 padding: EdgeInsets.all(20),
//                 decoration: new BoxDecoration(
//                   color: Theme.of(context).accentColor,
//                   borderRadius: new BorderRadius.only(
//                     bottomRight: const Radius.circular(15.0),
//                     topLeft: const Radius.circular(15.0),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       "الاشتراك في حراج",
//                       style: TextStyle(fontSize: 22, color: Colors.white),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         "تعد تكلفة الاشتراك السنوي في حراج تقنيه بما يساوي كما يلي:",
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             subscriptionStatus != ""
//                 ? Padding(
//                 padding: const EdgeInsets.only(
//                     top: 10, right: 10, left: 10, bottom: 10),
//                 child: Container(
//                     width: double.infinity,
//                     margin: EdgeInsets.only(left: 10, right: 10),
//                     padding: EdgeInsets.all(20),
//                     decoration: new BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: new BorderRadius.only(
//                         bottomRight: const Radius.circular(15.0),
//                         topLeft: const Radius.circular(15.0),
//                       ),
//                     ),
//                     child: Text(subscriptionStatus,
//                         style:
//                         TextStyle(fontSize: 22, color: Colors.white))))
//                 : Container(),
//             Column(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     selection(
//                         id: 1,
//                         title: "اشتراك سنوي",
//                         description: "تكلفة الاشتراك السنوي: 300 ريال"),
//                     selection(
//                         id: 2,
//                         title: "اشتراك شهري",
//                         description: "تكلفة الاشتراك الشهري: 50 ريال"),
//                     selection(
//                         id: 3,
//                         title: "رسوم الاعلان",
//                         description: "تكلفة الاعلان: 20 ريال"),
//                     selection(
//                         id: 4,
//                         title: "عمولة النسبة المئويه",
//                         description: "عائد النسبه المئوبه للمالك: 5%")
//                   ],
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 30,
//             ),
//           ],
//         ),
//         bottomNavigationBar: InkWell(
//             onTap: () {
//               _handleSubscription();
//             },
//             child: Row(children: [
//               Spacer(),
//               Container(
//                 padding: EdgeInsets.only(bottom: 15),
//                 child: Text(
//                   " اشترك الان ",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Icon(
//                     Icons.arrow_back_ios,
//                     textDirection: TextDirection.ltr,
//                   ))
//             ])));
//   }
//
//
//   Widget selection({var id, var title = "", var description = ""}) {
//     return InkWell(
//         onTap: () {
//           setState(() {
//             selectedId = id;
//           });
//         },
//         child: Container(
//             padding: EdgeInsets.all(10),
//             margin: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//                 color: id == selectedId || subscriptionType == id
//                     ? Colors.blueAccent
//                     : null,
//                 border: id == selectedId
//                     ? Border.all(color: Colors.blueAccent)
//                     : null),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(right: 20, left: 20),
//                     padding:
//                     EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5),
//                     decoration: new BoxDecoration(
//                       color: Theme.of(context).primaryColor,
//                       borderRadius: new BorderRadius.only(
//                         bottomRight: const Radius.circular(15.0),
//                         topLeft: const Radius.circular(15.0),
//                       ),
//                     ),
//                     child: Text(
//                       title,
//                       style: TextStyle(fontSize: 20, color: Colors.white),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(right: 10, left: 10),
//                     child: Container(
//                       width: double.infinity,
//                       margin: EdgeInsets.all(10),
//                       padding: EdgeInsets.all(20),
//                       decoration: new BoxDecoration(
//                         borderRadius: new BorderRadius.only(
//                           bottomRight: const Radius.circular(15.0),
//                           topLeft: const Radius.circular(15.0),
//                         ),
//                         border: Border.all(
//                           color: Colors.red,
//                           width: 1,
//                         ),
//                       ),
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [Text(description)]),
//                     ),
//                   )
//                 ])));
//   }
//
//   _handleSubscription() async {
//     if (subscriptionType != 4 && subscriptionType != 0) {
//       print(selectedId);
//       _scaffoldKey.currentState.showSnackBar(
//         SnackBar(
//           content: new Text(
//             "انت بالفعل مشترك",
//             style: TextStyle(fontSize: 20, fontFamily: 'Cocan'),
//           ),
//           duration: new Duration(seconds: 3),
//           backgroundColor: Theme.of(context).accentColor,
//         ),
//       );
//       return;
//     }
//     if (selectedId == 0) {
//       _scaffoldKey.currentState.showSnackBar(
//         SnackBar(
//           content: new Text(
//             "قم باختيار نوع الاشتراك اولا",
//             style: TextStyle(fontSize: 20, fontFamily: 'Cocan'),
//           ),
//           duration: new Duration(seconds: 3),
//           backgroundColor: Theme.of(context).accentColor,
//         ),
//       );
//       return;
//     }
//
//     if (selectedId == 4) {
//       // no MyFatoorah or anything else
//       var data = {
//         'subscription_type': selectedId,
//       };
//       var res = await CallApiAuth().postData(data, 'post_subscription');
//       final int statusCode = res.statusCode;
//       print(statusCode);
//       print(res.body);
//       if (statusCode < 200 || statusCode > 400 || json == null) {
//         _scaffoldKey.currentState.showSnackBar(
//           SnackBar(
//             content: new Text(
//               "هناك خطأ ما جاري أصلاحة",
//               style: TextStyle(fontSize: 20, fontFamily: 'Cocan'),
//             ),
//             duration: new Duration(seconds: 3),
//             backgroundColor: Theme.of(context).accentColor,
//           ),
//         );
//       }
//
//       var body = json.decode(res.body);
//       if (body['status'] == false) {
//         _scaffoldKey.currentState.showSnackBar(
//           SnackBar(
//             content: new Text(
//               body['msg'],
//               style: TextStyle(fontSize: 20, fontFamily: 'Cocan'),
//             ),
//             duration: new Duration(seconds: 3),
//             backgroundColor: Theme.of(context).accentColor,
//           ),
//         );
//       } else {
//         _scaffoldKey.currentState.showSnackBar(
//           SnackBar(
//             content: new Text(
//               body['msg'].toString(),
//               style: TextStyle(fontSize: 20, fontFamily: 'Cocan'),
//             ),
//             duration: new Duration(seconds: 3),
//             backgroundColor: Theme.of(context).accentColor,
//           ),
//         );
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HomeScreen(),
//             ));
//       }
//     }
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => MyFatoorahScreen(
//               subscriptionValue: selectedId == 1
//                   ? 300.0
//                   : selectedId == 2
//                   ? 50.0
//                   : 20.0,
//               subscriptionType: selectedId),
//         ));
//   }
// }
