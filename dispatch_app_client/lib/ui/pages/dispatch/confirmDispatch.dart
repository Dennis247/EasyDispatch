import 'package:dispatch_app_client/src/lib_export.dart';
import 'package:dispatch_app_client/ui/pages/payments/paymentOptionsPage.dart';

class ConfirmDispatch extends StatelessWidget {
  static final String routeName = "confirm-dispatch";

  _buildConfrimRowItem(String title, String subTitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: AppTextStyles.smallgreyTextStyle,
        ),
        Text(
          subTitle,
          style: AppTextStyles.appTextStyle,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appSzie = GlobalWidgets.getAppSize(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DISPATCH DETAILS",
          style: AppTextStyles.appLightHeaderTextStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        height: appSzie.height,
        width: appSzie.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildConfrimRowItem("Pick Up", currentDispatch.pickUpLocation),
                Divider(),
                _buildConfrimRowItem(
                    "Delivery Location", currentDispatch.dispatchDestination),
                Divider(),
                _buildConfrimRowItem("Dispatch Description",
                    currentDispatch.dispatchDescription),
                Divider(),
                _buildConfrimRowItem(
                    "Dispatch Type", currentDispatch.dispatchType),
                Divider(),
                _buildConfrimRowItem(
                    "Total Distance", currentDispatch.estimatedDistance),
                Divider(),
                _buildConfrimRowItem("Estimated Time",
                    currentDispatch.estimatedDIspatchDuration),
                Divider(),
                _buildConfrimRowItem("Base Delivery Fee", "N 1000"),
                Divider(),
                _buildConfrimRowItem("Total Delivery Fee", "N 5000"),
                Divider(),
                _buildConfrimRowItem(
                    "Reciever Name", currentDispatch.dispatchReciever),
                Divider(),
                _buildConfrimRowItem("Reciever PhoneNumber",
                    currentDispatch.dispatchRecieverPhone),
                SizedBox(
                  height: appSzie.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: AppRectButtonWidget(
            width: appSzie.width,
            buttonText: "CONFIRM DISPATCH",
            function: () async {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return PaymentOptions();
              }));
              // setState(() {
              //   _isloading = true;
              // });
              // final ResponseModel responseModel =
              //     await dispatchProvider.addDispatch(currentDispatch);
              // if (responseModel.isSUcessfull) {
              //   //show custom sucess dialogue before navigating
              //   notificationProvider.displayNotification(
              //       "Dispatch Sucessfull",
              //       "Dispatch Rider on the way for pick up!");
              //   //send pending notification

              //   Navigator.of(context).pushReplacement(MaterialPageRoute(
              //       builder: (context) => DispatchStatus(
              //             imageUrl: "assets/images/express.png",
              //             dispatchMessage:
              //                 Constants.processDispatchMessage,
              //             isDispatchProcessing: true,
              //           )));

              //   //show dispatch notification
              // } else {
              //   setState(() {
              //     _isloading = false;
              //   });
              //   GlobalWidgets.showFialureDialogue(
              //       responseModel.responseMessage, context);
              // }
            },
          ),
        ),
      ),
    );
  }
}
