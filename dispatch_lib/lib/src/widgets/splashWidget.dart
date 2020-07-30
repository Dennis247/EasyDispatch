import 'package:dispatch_lib/src/widgets/globalWidgets.dart';
import 'package:flutter/material.dart';

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: GlobalWidgets.circularInidcator(),
        ),
      ),
    );
  }
}
