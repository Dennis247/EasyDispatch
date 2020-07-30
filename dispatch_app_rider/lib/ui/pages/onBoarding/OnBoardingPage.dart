import 'package:dispatch_app_rider/src/lib_export.dart';
import 'package:dispatch_app_rider/ui/pages/auth/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  static final String routeName = "onboarding-page";
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    super.initState();
  }

  void _onIntroEnd(context) {
    Navigator.of(context).pushNamed(LoginPage.routeName);
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/$assetName.png'),
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  _buildPageViewModel(PageDecoration pageDecoration, String subTitle,
      String title, String body, String imageName) {
    return PageViewModel(
      titleWidget: Text.rich(
        AppTextWidget.appTextSpan(subTitle, title),
        textAlign: TextAlign.center,
      ),
      bodyWidget: Text(
        body,
        textAlign: TextAlign.center,
        style: AppTextStyles.appTextStyle,
      ),
      image: _buildImage(imageName),
      decoration: pageDecoration,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        pages: [
          _buildPageViewModel(pageDecoration, "sign up", " Easy Dispatch",
              "Sign up as a rider on easy dispatch", "1"),
          _buildPageViewModel(pageDecoration, "get", " Notifications",
              "Get Notifications from customers requesting for pick up", "1b"),
          _buildPageViewModel(
              pageDecoration,
              "pickup",
              "  Location",
              "Go to pick location and pick up customer goods for delivery",
              "2"),
          _buildPageViewModel(
              pageDecoration,
              "deliver",
              " Dispatch",
              "Make Sure dispatch recipeint gets the goods at the desired location",
              "4"),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward_ios),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: const DotsDecorator(
          activeColor: Color(0xff0d1724),
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
