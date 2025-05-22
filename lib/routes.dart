import 'package:flutter/material.dart';
import 'package:fund_watchlist/presentation/auth/login_screen.dart';
import 'package:fund_watchlist/presentation/auth/registration_screen.dart';
import 'package:fund_watchlist/presentation/dashboard/dashboard_screen.dart';
import 'package:fund_watchlist/presentation/splash/splash_screen.dart';
import 'package:fund_watchlist/utils/route_names.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.splash:
      return MaterialPageRoute(builder: (_) => SplashScreen());
    
    case RouteNames.login:
      return MaterialPageRoute(builder: (_) => LoginScreen());
    
    case RouteNames.signUp:
      return MaterialPageRoute(builder: (_) => RegistrationScreen());
    
    case RouteNames.home:
      return MaterialPageRoute(builder: (_) => DashboardScreen());
    
    // case RouteNames.login:
    //   return MaterialPageRoute(builder: (_) => LoginScreen());

    // case RouteNames.detail:
    //   final args = settings.arguments as Map<String, dynamic>;
    //   final String title = args['title'];
    //   final int id = args['id'];
    //   return MaterialPageRoute(
    //     builder: (_) => DetailScreen(title: title, id: id),
    //   );

    default:
      return MaterialPageRoute(builder: (_) => SplashScreen());
  }
}
