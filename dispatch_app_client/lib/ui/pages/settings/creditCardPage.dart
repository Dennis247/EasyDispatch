import 'package:dispatch_app_client/src/lib_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:dispatch_app_client/ui/pages/settings/addCreditCardPage.dart';

class CreditCardPage extends StatelessWidget {
  static final String routeName = "credit-card";
  @override
  Widget build(BuildContext context) {
    final appSize = GlobalWidgets.getAppSize(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "CREDIT CARD",
            style: AppTextStyles.appLightHeaderTextStyle,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AddCreditCardPage.routeName);
                })
          ],
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Container(
          width: appSize.width,
          height: appSize.height,
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) => CreditCardWidget(
              cardNumber: '5399 4354 6767 909',
              expiryDate: '06/20',
              cardHolderName: 'Dennis Osagiede',
              cvvCode: '',
              showBackView: false,
              height: appSize.height * 0.25,
              cardBgColor: Constants.primaryColorDark,
              textStyle: AppTextStyles.appLightTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
