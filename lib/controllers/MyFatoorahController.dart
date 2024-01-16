import 'package:flutter/cupertino.dart';
import 'package:myfatoorah_flutter/MFModels.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

class MyFatoorahController{
  var paymentMethods;

  initiatePayment() async {
    MFSDK.init("rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
        MFCountry.SAUDIARABIA, MFEnvironment.TEST);
    MFInitiatePaymentRequest request = MFInitiatePaymentRequest(
        invoiceAmount: 10, currencyIso: MFCurrencyISO.SAUDIARABIA_SAR);
    await MFSDK
        .initiatePayment(request, MFLanguage.ENGLISH)
        .then((value) {
      debugPrint("res"+value.toString());
      // paymentMethods =
      // value.toJson()['PaymentMethods'] as List;
    })
        .catchError((error) => {debugPrint("fail_res"+error.message)}
    );
  }

  executePayment() async {

    MFExecutePaymentRequest request = MFExecutePaymentRequest(invoiceValue: 10);
    request.paymentMethodId = 1;

    await MFSDK
        .executePayment(request, MFLanguage.ENGLISH, (invoiceId) {
      debugPrint(invoiceId);
    })
        .then((value) => debugPrint(value.toString()))
        .catchError((error) => {debugPrint(error.message)});
  }

  sendPayment() async {

    MFSendPaymentRequest request = MFSendPaymentRequest();
    request.customerName = "TEESST";
    request.invoiceValue = 10;
    request.notificationOption = MFNotificationOption.EMAIL;

    await MFSDK
        .sendPayment(request, MFLanguage.ENGLISH)
        .then((value) => debugPrint(value.toString()))
        .catchError((error) => {debugPrint(error.message)});
  }

  getPaymentStatus() async {
    MFGetPaymentStatusRequest request = MFGetPaymentStatusRequest(
        key: '2593740', keyType: MFKeyType.INVOICEID);
    await MFSDK
        .getPaymentStatus(request, MFLanguage.ENGLISH)
        .then((value) => debugPrint(value.toString()))
        .catchError((error) => {debugPrint(error.message)});
  }


  initiateSession() async {
    MFInitiateSessionRequest initiateSessionRequest =
    MFInitiateSessionRequest();
    await MFSDK
        .initiateSession(initiateSessionRequest, (bin) {
      debugPrint(bin);
    })
        .then((value) => {
      debugPrint(value.toString()),
    })
        .catchError((error) => {debugPrint(error.message)});
  }





}