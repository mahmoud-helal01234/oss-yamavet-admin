import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:loader_overlay/loader_overlay.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yama_vet_admin/controllers/AppointmentsProvider.dart';
import 'package:yama_vet_admin/controllers/AuthProvider.dart';
import 'package:yama_vet_admin/controllers/CategoriesProvider.dart';
import 'package:yama_vet_admin/controllers/ClientsProvider.dart';
import 'package:yama_vet_admin/controllers/RemindersProvider.dart';
import 'package:yama_vet_admin/controllers/SettingsProvider.dart';
import 'package:yama_vet_admin/controllers/SliderOffersProvider.dart';
import 'package:yama_vet_admin/controllers/UsersProvider.dart';

import 'controllers/ConfigurationsProvider.dart';
import 'core/utils/routes.dart';
import 'screens/splash.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("a21feae4-9172-46a6-aef5-7f6d26e1125b");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
    log("setNotificationWillShowInForegroundHandler");
  });

  OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    event.complete(event.notification);
    log("setNotificationWillShowInForegroundHandler");
  });



  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    // Will be called whenever the permission changes
    // (ie. user taps Allow on the permission prompt in iOS)
    log("setSubscriptionObserver");
  });

  OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    // Will be called whenever the subscription changes
    // (ie. user gets registered with OneSignal and gets a user ID)
    String? onesignalUserId = changes.to.userId;
    //log("setSubscriptionObserver");
    SharedPreferences.getInstance().then((value){
      log("Shared Prefs");
      value.setString("device_token",onesignalUserId!);
      value.setString("first_time","First Time ");
      if(value.containsKey("device_token")) log("Et5zn");
      log("PREFS " + value.getString("device_token")!);
      log("Stored");
      log("Token " + onesignalUserId);
    });
  });

  OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    //_MyAppState.handleClickNotification(result);
    log("Opened");
  });
  OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
    // Will be called whenever then user's email subscription changes
    // (ie. OneSignal.setEmail(email) is called and the user gets registered
  });
  OneSignal.shared.getDeviceState().then((deviceState) {
    print("DeviceState: ${deviceState?.jsonRepresentation()}");
    SharedPreferences.getInstance().then((value){
      value.setString("device_token",deviceState!.userId!);
      log("Token " + deviceState.userId!);
    });
    //log(deviceState!.pushToken!);
  });


  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppointmentsProvider()),
        ChangeNotifierProvider(create: (context) => CategoriesProvider()),
        ChangeNotifierProvider(create: (context) => ConfigurationsProvider()),
        ChangeNotifierProvider(
          create: (context) => SliderOffersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoriesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UsersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RemindersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ClientsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(),
        )
      ],
      child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/translation',
          fallbackLocale: const Locale('en'),
          child: GlobalLoaderOverlay(
              overlayColor: Colors.grey.withOpacity(0.8),
              useDefaultLoading: false,
              overlayWidgetBuilder: (_) {
                //ignored progress for the moment
                return const Center(
                  child:
                      SpinKitSquareCircle(color: Color(0xff792d75), size: 50.0),
                );
              },
              child: MyApp())),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppRouter appRouter = AppRouter();
  static final navKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // handle when notification opened

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print("Notification opened: ${result.notification.body}");

      // Navigate to NotificationScreen
      // navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (_) => const NotificationScreen()));
    });

    // handle when notification received
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      OSNotificationDisplayType.notification;
      log("background:" + event.notification.title.toString());

      // change new notification status to true
      // setState(() {
      //   notificationChanged = true;
      // });

      // Provider.of<NotificationsProvider>(context, listen: false)
      //     .setNewNotificationStatus(true);
    });
  }

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: Size(390, 800), // Change depending on the XD
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          routes: {
            '/': (context) => const SplashScreen(),
            // 'OnBoarding': (context) => const OnBoardingScreen(),
          },
          initialRoute: '/',
          onGenerateRoute: appRouter.generateRoute,
          navigatorKey: navKey,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          //
          // // locale: _locale,
          // localeResolutionCallback: (locale, supportedLocales) {
          //   for (var supportedLocaleLanguage in supportedLocales) {
          //     if (supportedLocaleLanguage.languageCode ==
          //             locale!.languageCode &&
          //         supportedLocaleLanguage.countryCode == locale.countryCode) {
          //       return supportedLocaleLanguage;
          //     }
          //   }
          // },
          // OR Locale('ar', 'AE') OR Other RTL locales,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: TextTheme(button: TextStyle(fontSize: 18.sp)),
              appBarTheme:
                  AppBarTheme(iconTheme: IconThemeData(color: Colors.black))),
          builder: (context, widget) {
            // ScreenUtil.setContext(context);
            return MediaQuery(
              //Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },

          // home:  MyAppPPP(),
          //  home: SplashScreen(),
          // home: ChangeNotifierProvider<UnitsPurchaseProvider>.value(
          //   value: sl<UnitsPurchaseProvider>(),
          //   child: UnitsPurchaseScreen(),
          // )
        );
      },
    );
  }

}