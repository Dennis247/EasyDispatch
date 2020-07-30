import 'package:dispatch_app_client/src/lib_export.dart';
import 'package:dispatch_app_client/ui/pages/auth/loginPage.dart';
import 'package:dispatch_app_client/ui/pages/auth/signUpPage.dart';
import 'package:dispatch_app_client/ui/pages/dispatch/confirmDispatch.dart';
import 'package:dispatch_app_client/ui/pages/dispatch/recipientPage.dart';
import 'package:dispatch_app_client/ui/pages/home/homePage.dart';
import 'package:dispatch_app_client/ui/pages/notification/notificationPage.dart';
import 'package:dispatch_app_client/ui/pages/settings/creditCardPage.dart';
import 'package:provider/provider.dart';
import 'package:dispatch_app_client/ui/pages/support/supportPage.dart';
import 'package:dispatch_app_client/ui/pages/settings/settingsPage.dart';
import 'package:dispatch_app_client/ui/pages/settings/addCreditCardPage.dart';
import 'ui/pages/dispatch/dispatchHistoryPage.dart';
import 'ui/pages/onBoarding/OnBoardingPage.dart';
import 'ui/pages/settings/appSettings.dart';
import 'ui/pages/settings/myProfilePage.dart';
import 'ui/pages/settings/updatePasswordPage.dart';

void setupLocator() {
  locator.registerSingleton<SettingsServices>(SettingsServices());
  locator.registerSingleton<GoogleMapServices>(GoogleMapServices());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: GoogleMapProvider()),
          ChangeNotifierProvider.value(value: DispatchProvider()),
          ChangeNotifierProvider.value(value: AUthProvider()),
          ChangeNotifierProvider.value(value: NotificationProvider()),
          ChangeNotifierProvider.value(value: PaymentProvider())
        ],
        child: Consumer<AUthProvider>(
          builder: (context, authData, _) {
            return MaterialApp(
              title: 'Easy Dispatch',
              theme: ThemeData(
                  primaryColor: Constants.primaryColorDark,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  pageTransitionsTheme: PageTransitionsTheme(builders: {
                    TargetPlatform.iOS: CustomPageTransitionBuilder(),
                    TargetPlatform.android: CustomPageTransitionBuilder(),
                  })),
              home: authData.isLoggedIn
                  ? HompePage()
                  : FutureBuilder(
                      future: authData.tryAutoLogin(),
                      builder: (context, authDataResultSnapSHot) =>
                          authDataResultSnapSHot.connectionState ==
                                  ConnectionState.waiting
                              ? Center(
                                  child: SplashWidget(),
                                )
                              : authData.hasOnboarded
                                  ? LoginPage()
                                  : OnBoardingPage(),
                    ),
              routes: {
                LoginPage.routeName: (context) => LoginPage(),
                SignUpPage.routeName: (context) => SignUpPage(),
                HompePage.routeName: (context) => HompePage(),
                RecipientPage.routeName: (context) => RecipientPage(),
                ConfirmDispatch.routeName: (context) => ConfirmDispatch(),
                DispatchHistoryPage.routeName: (context) =>
                    DispatchHistoryPage(),
                SupportPage.routeName: (context) => SupportPage(),
                SettingsPage.routeName: (context) => SettingsPage(),
                CreditCardPage.routeName: (context) => CreditCardPage(),
                AddCreditCardPage.routeName: (context) => AddCreditCardPage(),
                MyProfilePage.routeName: (context) => MyProfilePage(),
                UpdatePassowrd.routeName: (context) => UpdatePassowrd(),
                OnBoardingPage.routeName: (context) => OnBoardingPage(),
                NotificationPage.routeName: (context) => NotificationPage(),
                AppSettings.routeName: (context) => AppSettings()
              },
            );
          },
        ));
  }
}
