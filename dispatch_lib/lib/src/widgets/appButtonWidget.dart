import 'package:dispatch_lib/src/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'globalWidgets.dart';

class AppButtonWudget extends StatelessWidget {
  final String buttonText;
  final Function function;
  final Color color;

  const AppButtonWudget({Key key, this.buttonText, this.function, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appSzie = GlobalWidgets.getAppSize(context);
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Constants.primaryColorLight,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        width: appSzie.width * 0.8,
        height: 48.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45.0),
          color: color == null ? Constants.primaryColorDark : color,
        ),
      ),
    );
  }
}

class AppSmallButtonWudget extends StatelessWidget {
  final String buttonText;
  final Function function;
  final double width;
  final Color color;

  const AppSmallButtonWudget(
      {Key key, this.buttonText, this.function, this.color, this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appSzie = GlobalWidgets.getAppSize(context);
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            buttonText,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Constants.primaryColorLight,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        width: width == null ? appSzie.width * 0.5 : width,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45.0),
          color: color == null ? Constants.primaryColorDark : color,
        ),
      ),
    );
  }
}

class AppRectButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function function;
  final Color color;
  final double width;

  const AppRectButtonWidget(
      {Key key, this.buttonText, this.function, this.color, this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appSzie = GlobalWidgets.getAppSize(context);
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Constants.primaryColorLight,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        width: width == null ? appSzie.width * 0.5 : width,
        height: 48.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: color == null ? Constants.primaryColorDark : color,
        ),
      ),
    );
  }
}

class AppRectButtonLightWidget extends StatelessWidget {
  final String buttonText;
  final Function function;
  final Color color;
  final double width;

  const AppRectButtonLightWidget(
      {Key key, this.buttonText, this.function, this.color, this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appSzie = GlobalWidgets.getAppSize(context);
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Constants.primaryColorDark,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        width: width == null ? appSzie.width * 0.5 : width,
        height: 48.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: color == null ? Constants.primaryColorDark : color,
            border: Border.all(color: Constants.primaryColorDark)),
      ),
    );
  }
}
