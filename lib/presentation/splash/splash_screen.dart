import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fund_watchlist/bloc/login/auth_bloc.dart';
import 'package:fund_watchlist/locator.dart';
import 'package:fund_watchlist/services/navigation_service.dart';
import 'package:fund_watchlist/utils/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            locator<NavigationService>().navigateTo(RouteNames.home);
          } else if (state is Unauthenticated) {
            locator<NavigationService>().replaceTo(RouteNames.login);
          }
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
