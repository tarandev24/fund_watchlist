import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fund_watchlist/bloc/bloc_providers.dart';
import 'package:fund_watchlist/locator.dart';
import 'package:fund_watchlist/routes.dart';
import 'package:fund_watchlist/services/navigation_service.dart';
import 'package:fund_watchlist/theme/app_theme.dart';
import 'package:fund_watchlist/utils/media_query.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fund_watchlist/utils/route_names.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    CommonMediaQuery.initialize(context);
    return MultiBlocProvider(
      providers: BlocProviders.getProviders(),
      child: MaterialApp(
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        title: 'Fund Watchlist',
        theme: AppTheme.darkTheme,
        initialRoute: RouteNames.splash,
      ),
    );
  }
}
