import 'package:dispatch_app_client/src/lib_export.dart';
import 'package:dispatch_app_client/ui/widgets/dispatchHistoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DispatchHistoryPage extends StatefulWidget {
  static final String routeName = "dispatch-history";
  @override
  _DispatchHistoryPageState createState() => _DispatchHistoryPageState();
}

class _DispatchHistoryPageState extends State<DispatchHistoryPage> {
  bool _isLoading = false;
  List<Dispatch> _currentDispatchList = [];
  @override
  void initState() {
    getDispatchList();
    super.initState();
  }

  void _startLoading(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  void getDispatchList() async {
    _startLoading(true);
    final ResponseModel responseModel =
        await Provider.of<DispatchProvider>(context, listen: false)
            .getDispatchList();

    if (responseModel.isSUcessfull) {
      _currentDispatchList = dispatchList;
    } else {
      GlobalWidgets.showFialureDialogue(responseModel.responseMessage, context);
    }
    _startLoading(false);
  }

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  String getDispatchStatus(int page) {
    final dispatchProvider =
        Provider.of<DispatchProvider>(context, listen: false);
    if (page == 0) {
      _currentDispatchList = dispatchProvider.getDispatchLIst(
          Constants.dispatchActiveStatus, dispatchList);
      return Constants.dispatchActiveStatus.toUpperCase();
    }
    if (page == 1) {
      _currentDispatchList = dispatchProvider.getDispatchLIst(
          Constants.dispatchPendingStatus, dispatchList);
      return Constants.dispatchPendingStatus.toUpperCase();
    }
    if (page == 2) {
      _currentDispatchList = dispatchProvider.getDispatchLIst(
          Constants.dispatchCompletedStatus, dispatchList);
      return Constants.dispatchCompletedStatus.toUpperCase();
    }
    if (page == 3) {
      _currentDispatchList = dispatchProvider.getDispatchLIst(
          Constants.dispatchCancelledStatus, dispatchList);
      return Constants.dispatchCancelledStatus.toUpperCase();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final appSize = GlobalWidgets.getAppSize(context);
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      appBar: AppBar(
        title: Text(
          getDispatchStatus(_page),
          style: AppTextStyles.appLightHeaderTextStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: _isLoading
          ? Center(child: GlobalWidgets.circularInidcator())
          : Container(
              height: appSize.height,
              width: appSize.width,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: _currentDispatchList.length > 0
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: _currentDispatchList.length,
                        itemBuilder: (context, index) => DispatchHistoryWidget(
                              dispatch: _currentDispatchList[index],
                            ))
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.opencart,
                              size: 100,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "dispatch list is empty",
                              style: AppTextStyles.appTextStyle,
                            )
                          ],
                        ),
                      ),
              ),
            ),
      bottomNavigationBar: _isLoading
          ? Text("")
          : CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: 0,
              height: 50.0,
              items: <Widget>[
                Icon(
                  Icons.desktop_mac,
                  size: 25,
                  color: Constants.primaryColorLight,
                ),
                Icon(
                  Icons.list,
                  size: 25,
                  color: Constants.primaryColorLight,
                ),
                Icon(
                  Icons.account_balance,
                  size: 25,
                  color: Constants.primaryColorLight,
                ),
                Icon(
                  Icons.delete,
                  size: 25,
                  color: Constants.primaryColorLight,
                ),
              ],
              color: Constants.primaryColorDark,
              buttonBackgroundColor: Constants.primaryColorDark,
              backgroundColor: Constants.backGroundColor,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 600),
              onTap: (index) async {
                setState(() {
                  _page = index;
                });
              },
            ),
    );
  }
}
