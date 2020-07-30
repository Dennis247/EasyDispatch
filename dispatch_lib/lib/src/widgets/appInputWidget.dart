import 'package:dispatch_lib/src/models/constants.dart';
import 'package:dispatch_lib/src/utils/appStyles.dart';
import 'package:flutter/material.dart';

class AppTextInputWIdget extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final Function validator;
  final TextInputType keyboardType;

  const AppTextInputWIdget(
      {Key key,
      this.labelText,
      this.prefixIcon,
      this.obscureText,
      this.controller,
      this.validator,
      this.keyboardType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.appTextStyle,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: AppTextStyles.labelTextStyle,
          prefixIcon: Icon(
            prefixIcon,
            color: Constants.primaryColorDark,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Constants.primaryColorDark))),
      obscureText: obscureText,
    );
  }
}

class AppTextInputMultilineWIdget extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final Function validator;

  const AppTextInputMultilineWIdget(
      {Key key,
      this.labelText,
      this.prefixIcon,
      this.obscureText,
      this.controller,
      this.validator})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: AppTextStyles.appTextStyle,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: AppTextStyles.labelTextStyle,
          prefixIcon: Icon(
            prefixIcon,
            color: Constants.primaryColorDark,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Constants.primaryColorDark))),
      obscureText: obscureText,
    );
  }
}

class AppTextSmallInputWIdget extends StatelessWidget {
  final String labelText;
  final Widget prefixIcon;
  final bool obscureText;
  final Color prefixColor;
  final TextStyle labelTextSTyle;

  const AppTextSmallInputWIdget(
      {Key key,
      this.labelText,
      this.prefixIcon,
      this.obscureText,
      this.prefixColor,
      this.labelTextSTyle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.appTextStyle,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelTextSTyle,
          prefixIcon: prefixIcon,
          suffix: Icon(
            Icons.close,
            color: Constants.primaryColorDark,
            size: 15,
          ),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      obscureText: obscureText,
    );
  }
}
