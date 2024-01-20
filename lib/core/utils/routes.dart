import 'package:flutter/material.dart';
import 'package:yama_vet_admin/core/utils/strings.dart';
import 'package:yama_vet_admin/screens/appointments/appointments.dart';
import 'package:yama_vet_admin/screens/categories/categories.dart';
import 'package:yama_vet_admin/screens/client_profile.dart';
import 'package:yama_vet_admin/screens/clients.dart';
import 'package:yama_vet_admin/screens/dash_board.dart';
import 'package:yama_vet_admin/screens/Auth/login.dart';
import 'package:yama_vet_admin/screens/offers.dart';
import 'package:yama_vet_admin/screens/reminder.dart';
import 'package:yama_vet_admin/screens/appointments/select_services.dart';
import 'package:yama_vet_admin/screens/splash.dart';
import 'package:yama_vet_admin/screens/Auth/verify.dart';
import 'package:yama_vet_admin/screens/vet_profiles.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case dash:
        return MaterialPageRoute(builder: (_) => DashBoard());
      case offers:
        return MaterialPageRoute(builder: (_) => OfferScreen());
      case categories:
        return MaterialPageRoute(builder: (_) => const CategoryChoose());
      // case vaccication:
      //   return MaterialPageRoute(builder: (_) => Vaccination());
      case appointments:
        return MaterialPageRoute(builder: (_) => AppointmentScreen());
      // case orderOverView:
      //   return MaterialPageRoute(builder: (_) => OrderReview());
      // case selectServices:
      //   return MaterialPageRoute(builder: (_) => SelectServices());
      case vetProfiles:
        return MaterialPageRoute(builder: (_) => VetProfiles());
      // case profiles:
      //   return MaterialPageRoute(builder: (_) => Profile());
      case clients:
        return MaterialPageRoute(builder: (_) => Clients());
      // case clientProfile:
      //   return MaterialPageRoute(builder: (_) => ClientProfile());
      case reminder:
        return MaterialPageRoute(builder: (_) => ReminderScreen());
    }
    return null;
  }
}
