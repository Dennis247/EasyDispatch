import 'package:dispatch_app_rider/src/lib_export.dart';
import 'package:dispatch_app_rider/ui/widgets/DispatchListWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DispatchList extends StatefulWidget {
  final String dispatchType;
  final List<Dispatch> dispatchList;
  static final String routeName = "dispatch-list";

  const DispatchList({Key key, this.dispatchType, this.dispatchList})
      : super(key: key);
  @override
  _DispatchListState createState() => _DispatchListState();
}

class _DispatchListState extends State<DispatchList> {
  @override
  Widget build(BuildContext context) {
    final appSize = GlobalWidgets.getAppSize(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.dispatchType.toUpperCase(),
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
      body: Container(
        height: appSize.height,
        width: appSize.width,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: widget.dispatchList.length > 0
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.dispatchList.length,
                  itemBuilder: (context, index) {
                    return DispatchListWidget(
                        dispatch: widget.dispatchList[index]);
                  })
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
    );
  }
}
