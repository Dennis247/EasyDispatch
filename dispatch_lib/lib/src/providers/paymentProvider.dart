import 'package:dispatch_lib/dispatch_lib.dart';
import 'package:dispatch_lib/src/models/onlinePayment.dart';
import 'package:dispatch_lib/src/models/response.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rave_flutter/rave_flutter.dart';

final onlinePaymentRef =
    FirebaseDatabase.instance.reference().child('onlinePayment');

class PaymentResponseModel {
  final ResponseModel responseModel;
  final RaveStatus raveStatus;

  PaymentResponseModel(
      {@required this.responseModel, @required this.raveStatus});
}

class PaymentProvider with ChangeNotifier {
  Future<PaymentResponseModel> startPayment(
      {@required OnlinePayment onlinePayment,
      @required BuildContext context}) async {
    try {
      var initializer = RavePayInitializer(
          amount: onlinePayment.amount,
          publicKey: Constants.flutterPublicKey,
          encryptionKey: Constants.flutterEncryptionKey,
          subAccounts: null)
        ..country = "NG"
        ..currency = "NGN"
        ..email = loggedInUser.email
        ..fName = loggedInUser.fullName
        ..lName = ""
        ..narration = onlinePayment.narration
        ..txRef = onlinePayment.transactionRef
        ..orderRef = onlinePayment.orderRef
        ..acceptMpesaPayments = false
        ..acceptAccountPayments = true
        ..acceptCardPayments = true
        ..acceptAchPayments = true
        ..acceptGHMobileMoneyPayments = true
        ..acceptUgMobileMoneyPayments = true
        ..acceptMobileMoneyFrancophoneAfricaPayments = true
        ..displayEmail = true
        ..displayAmount = true
        ..staging = false
        ..isPreAuth = false
        ..displayFee = true;
      RaveResult response = await RavePayManager()
          .prompt(context: context, initializer: initializer);
      // if payment status is sucessfull add to database
      if (response.status == RaveStatus.success) {
        onlinePaymentRef.child(onlinePayment.id).set({
          "id": onlinePayment.id,
          "amount": onlinePayment.amount,
          "date": onlinePayment.date.toString(),
          "dispatchId": onlinePayment.dispatchId,
          "email": onlinePayment.email,
          "fullname": onlinePayment.fullname,
          "riderId": onlinePayment.riderId,
          "userId": onlinePayment.userId,
          "transactionRef": onlinePayment.transactionRef,
          "orderRef": onlinePayment.orderRef,
          "narration": onlinePayment.narration
        });
      }
      return PaymentResponseModel(
          responseModel: ResponseModel(true, response.message),
          raveStatus: response.status);
    } catch (e) {
      return PaymentResponseModel(
          responseModel: ResponseModel(true, e.toString()),
          raveStatus: RaveStatus.error);
    }
  }
}
