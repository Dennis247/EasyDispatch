import 'package:dispatch_app_client/src/lib_export.dart';
import 'package:dispatch_app_client/ui/pages/dispatch/dispatchStausPage.dart';
import 'package:uuid/uuid.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({Key key}) : super(key: key);

  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  bool _isloading = false;

  _setLoadingSstate(bool state) {
    setState(() {
      _isloading = state;
    });
  }

  _payOnDelivery(DispatchProvider dispatchProvider,
      NotificationProvider notificationProvider) async {
    _setLoadingSstate(true);
    currentDispatch = Dispatch(
        id: currentDispatch.id,
        userId: currentDispatch.userId,
        trackingNo: currentDispatch.trackingNo,
        dispatchRiderId: currentDispatch.dispatchRiderId,
        dispatchDate: currentDispatch.dispatchDate,
        pickUpLocation: currentDispatch.pickUpLocation,
        dispatchDestination: currentDispatch.dispatchDestination,
        dispatchBaseFare: currentDispatch.dispatchBaseFare,
        dispatchTotalFare: currentDispatch.dispatchTotalFare,
        dispatchType: currentDispatch.dispatchType,
        dispatchStatus: currentDispatch.dispatchStatus,
        currentLocation: currentDispatch.currentLocation,
        estimatedDIspatchDuration: currentDispatch.estimatedDIspatchDuration,
        estimatedDistance: currentDispatch.estimatedDistance,
        dispatchReciever: currentDispatch.dispatchReciever,
        dispatchRecieverPhone: currentDispatch.dispatchRecieverPhone,
        dispatchDescription: currentDispatch.dispatchDescription,
        destinationLatitude: currentDispatch.destinationLatitude,
        destinationLongitude: currentDispatch.destinationLongitude,
        paymentOption: Constants.payOnDelivery);
    final ResponseModel responseModel =
        await dispatchProvider.addDispatch(currentDispatch);
    if (responseModel.isSUcessfull) {
      //show custom sucess dialogue before navigating
      notificationProvider.displayNotification(
          "Dispatch Sucessfull", "Dispatch Rider on the way for pick up!");
      //send pending notification

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => DispatchStatus(
                imageUrl: "assets/images/express.png",
                dispatchMessage: Constants.processDispatchMessage,
                isDispatchProcessing: true,
              )));

      //show dispatch notification
    } else {
      _setLoadingSstate(false);
      GlobalWidgets.showFialureDialogue(responseModel.responseMessage, context);
    }
  }

  _onlinePaymet() async {
    OnlinePayment onlinePayment = new OnlinePayment(
        id: Uuid().v4(),
        amount: currentDispatch.dispatchTotalFare,
        email: loggedInUser.email,
        fullname: loggedInUser.fullName,
        transactionRef:
            "EASY-DISP-${DateTime.now()}--${currentDispatch.trackingNo}",
        orderRef: currentDispatch.trackingNo,
        date: DateTime.now(),
        userId: loggedInUser.id,
        riderId: "empty",
        dispatchId: currentDispatch.id,
        narration: currentDispatch.dispatchDescription);
    var paymentResponse =
        await Provider.of<PaymentProvider>(context, listen: false)
            .startPayment(onlinePayment: onlinePayment, context: context);
    if (!paymentResponse.responseModel.isSUcessfull) {
      GlobalWidgets.showFialureDialogue(
          paymentResponse.responseModel.responseMessage, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appSzie = GlobalWidgets.getAppSize(context);
    final dispatchProvider =
        Provider.of<DispatchProvider>(context, listen: false);
    final notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "PAYMENT OPTIONS",
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
            width: appSzie.width,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/payment.png',
                  ),
                  SizedBox(
                    height: appSzie.height * 0.06,
                  ),
                  Container(
                      height: appSzie.height * 0.07,
                      child: AppRectButtonLightWidget(
                        buttonText: "ONLINE PAYMENT",
                        color: Constants.primaryColorLight,
                        width: appSzie.width * 0.8,
                        function: () {
                          //TODO update rider Id for this payment
                          _onlinePaymet();
                        },
                      )),
                  SizedBox(
                    height: appSzie.height * 0.02,
                  ),
                  _isloading
                      ? GlobalWidgets.circularInidcator()
                      : AppRectButtonWidget(
                          width: appSzie.width * 0.8,
                          buttonText: "PAY ON DELIVERY",
                          function: () async {
                            await _payOnDelivery(
                                dispatchProvider, notificationProvider);
                          },
                        ),
                ],
              ),
            )),
      ),
    );
  }
}
