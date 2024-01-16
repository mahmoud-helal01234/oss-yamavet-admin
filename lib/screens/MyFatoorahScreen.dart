// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:yama_vet_admin/controllers/MyFatoorahController.dart';
// /*
// TODO: The following data are using for testing only, so that when you go live
//       don't forget to replace the following test credentials with the live
//       credentials provided by MyFatoorah Company.
// */
//
// // Base Url
// final String baseUrl = "https://apitest.myfatoorah.com";
//
// // You can get the API Key for regular payment or direct payment and recurring from here:
// // https://myfatoorah.readme.io/docs/demo-information
// final String mAPIKey =
//     "bearer rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";
//
// class MyFatoorahScreen extends StatefulWidget {
//   MyFatoorahScreen(
//       {Key? key})
//       : super(key: key);
//
//   @override
//   _MyFatoorahScreenState createState() => _MyFatoorahScreenState();
// }
//
// class _MyFatoorahScreenState extends State<MyFatoorahScreen> {
//   String _response = '';
//   String _loading = "Loading...";
//   var paymentMethods;
//   @override
//   void initState() {
//     //
//     super.initState();
//
//     if (mAPIKey.isEmpty) {
//       setState(() {
//         _response =
//         "Missing API Key.. You can get it from here: https://myfatoorah.readme.io/docs/demo-information";
//       });
//       return;
//     }
//
//     // TODO, don't forget to init the MyFatoorah Plugin with the following line
//     MFSDK.init(baseUrl,"KSA", mAPIKey);
//
//     // (Optional) un comment the following lines if you want to set up properties of AppBar.
//
//     /*MFSDK.setUpAppBar(
//       title: " ",
//       titleColor: Colors.white, // Color(0xFFFFFFFF)
//       backgroundColor: Colors.white, // Color(0xFF000000)
//       isShowAppBar: true,
//     );*/ // For Android platform only
//     initiatePayment();
//     MyFatoorahController().initiatePayment();
//
//   }
//
//   /*
//     Initiate Payment
//    */
//   // void initiatePayment() {
//   //   var request =
//   //   new MFInitiatePaymentRequest(100, MFCurrencyISO.SAUDI_ARABIA_SAR);
//   //
//   //   MFSDK.initiatePayment(
//   //       request,
//   //       MFAPILanguage.EN,
//   //
//   //           (MFResult<MFInitiatePaymentResponse> result) => {
//   //         if (result.isSuccess())
//   //           {
//   //             setState(() {
//   //               debugPrint(result.response.toJson().toString());
//   //               _response = result.response.toJson().toString();
//   //
//   //               paymentMethods =
//   //               result.response.toJson()['PaymentMethods'] as List;
//   //             })
//   //           }
//   //         else
//   //           {
//   //             setState(() {
//   //               print(result.error.toJson());
//   //               _response = result.error.message;
//   //             })
//   //           }
//   //       });
//   //
//   //   setState(() {
//   //     _response = _loading;
//   //   });
//   // }
//
//   /*
//     Execute Regular Payment
//    */
//   void executeRegularPayment({id = 2}) async {
//
//     print(widget.subscriptionType.toString());
//     // The value 1 is the paymentMethodId of KNET payment method.
//     // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
//     int paymentMethod = id;
//     var request =
//     new MFExecutePaymentRequest(paymentMethod, widget.subscriptionValue);
//     request.displayCurrencyIso = MFCurrencyISO.SAUDI_ARABIA_SAR;
// /*
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var uId = prefs.get('id');
//     request.callBackUrl = apiUrl() + 'ensure_payment?id=' + uId;
//     request.sourceInfo = widget.subscriptionType.toString();
//     */
//
//     // payment start
//
//     MFSDK.executePayment(context, request, MFAPILanguage.EN,
//             (String invoiceId, MFResult<MFPaymentStatusResponse> result) async {
//
//           if (result.isSuccess()) {
//             setState(() {
//
//               _response = result.response.toJson().toString();
//             });
//             if (result.response.toJson()['InvoiceStatus'] == "Paid") {
//               print(result.response.toJson()['InvoiceStatus'] +
//                   " " +
//                   invoiceId +
//                   " " +
//                   result.response.toJson()['InvoiceValue'].toString());
//
//
//
//
//
//
//
//               var data = {
//                 'subscription_type': widget.subscriptionType,
//                 'subscription_invoice_id': invoiceId,
//                 'subscription_amount': result.response.toJson()['InvoiceValue']
//               };
//
//               var res = await CallApiAuth().postData(data, 'post_subscription');
//
//               final int statusCode = res.statusCode;
//               if (statusCode < 200 || statusCode > 400 || json == null) {
//                 print(res.statusCode.toString() + " " + res.body);
//                 return;
//               }
//
//               var body = json.decode(res.body);
//
//               if (body['status'] == false) {
//                 print("status is false" + res.body);
//               } else {
//                 print("status is true" + res.body);
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(
//                     builder: (context) => Subscriptions(),
//                   ),
//                 );
//               }
//             }
//           } else {
//             setState(() {
//               print("here: " + result.error.toJson().toString());
//               _response = result.error.message;
//             });
//           }
//         });
//
//     setState(() {
//       _response = _loading;
//     });
//   }
//
//   void getPaymentStatus({String invoiceId = "615382"}) {
//     var request = MFPaymentStatusRequest(invoiceId: invoiceId);
//
//     MFSDK.getPaymentStatus(
//         MFAPILanguage.EN,
//         request,
//             (MFResult<MFPaymentStatusResponse> result) => {
//           if (result.isSuccess())
//             {
//               setState(() {
//                 print(result.response.toJson()['InvoiceStatus'] == 'Paid');
//                 _response = result.response.toJson().toString();
//               })
//             }
//           else
//             {
//               setState(() {
//                 print(result.response.toJson()['InvoiceStatus'] == 'paid');
//                 print(result.error.toJson());
//                 _response = result.error.message;
//               })
//             }
//         });
//
//     setState(() {
//       _response = _loading;
//     });
//   }
//
//   String content = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: new IconThemeData(color: Colors.white),
//           title: Text("اختر وسيلة الدفع"),
//           centerTitle: true,
//           elevation: 0.4,
//         ),
//         body: Container(
//           height: MediaQuery.of(context).size.height * 0.95,
//           width: MediaQuery.of(context).size.width * 0.99,
//           padding: EdgeInsets.only(left: 10, right: 10),
//           child: paymentMethods == null
//               ? Container()
//               : ListView.builder(
//             padding: EdgeInsets.only(top: 30),
//             physics: AlwaysScrollableScrollPhysics(),
//             itemCount: paymentMethods.length,
//             scrollDirection: Axis.vertical,
//             itemBuilder: (BuildContext context, index) {
//               if (paymentMethods[index]['IsDirectPayment'])
//                 return Container();
//               return Container(
//                 margin: EdgeInsets.all(20),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       InkWell(
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                               backgroundColor: Colors.grey,
//                               backgroundImage: NetworkImage(
//                                 paymentMethods[index]['ImageUrl'],
//                               ),
//                               maxRadius: 25,
//                               minRadius: 25,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment:
//                               CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   paymentMethods[index]
//                                   ['PaymentMethodAr'] !=
//                                       null
//                                       ? paymentMethods[index]
//                                   ['PaymentMethodAr']
//                                       : ' ',
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     height: 1.5,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   paymentMethods[index]['city'] != null
//                                       ? paymentMethods[index]['city']
//                                   ['city_name']
//                                       .toString()
//                                       : ' ',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     height: 1.5,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         onTap: () {
//                           executeRegularPayment(
//                               id: paymentMethods[index]
//                               ['PaymentMethodId']);
//                         },
//                       ),
//                     ]),
//               );
//             },
//           ),
//         ));
//   }
// }
