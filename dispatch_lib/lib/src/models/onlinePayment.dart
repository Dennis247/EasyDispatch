import 'package:flutter/cupertino.dart';

class OnlinePayment {
  final String id;
  final double amount;
  final String email;
  final String fullname;
  final String transactionRef;
  final String orderRef;
  final DateTime date;
  final String userId;
  final String riderId;
  final String dispatchId;
  final String narration;

  OnlinePayment(
      {@required this.id,
      @required this.amount,
      @required this.email,
      @required this.fullname,
      @required this.transactionRef,
      @required this.orderRef,
      @required this.date,
      @required this.userId,
      @required this.riderId,
      @required this.dispatchId,
      @required this.narration});
}
