import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:yama_vet_admin/controllers/AppointmentsProvider.dart';
import 'package:yama_vet_admin/controllers/AuthProvider.dart';
import 'package:yama_vet_admin/controllers/CategoriesProvider.dart';
import 'package:yama_vet_admin/controllers/ClientsProvider.dart';
import 'package:yama_vet_admin/controllers/RemindersProvider.dart';
import 'package:yama_vet_admin/controllers/SliderOffersProvider.dart';
import 'package:yama_vet_admin/controllers/UsersProvider.dart';
import 'controllers/ConfigurationsProvider.dart';
import 'core/utils/routes.dart';
import 'screens/splash.dart';

void main(List<String> args) {
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
        )
      ],
      child: MyApp(),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: Colors.grey.withOpacity(0.8),
      useDefaultLoading: false,
      overlayWidgetBuilder: (_) {
        //ignored progress for the moment
        return const Center(
          child: SpinKitCubeGrid(
            color: Colors.red,
            size: 50.0,
          ),
        );
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => SplashScreen(),
            // 'OnBoarding': (context) => const OnBoardingScreen(),
          },
          initialRoute: '/',
          onGenerateRoute: appRouter.generateRoute),
    );
  }
}
