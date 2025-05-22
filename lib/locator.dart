import 'package:fund_watchlist/bloc/login/auth_bloc.dart';
import 'package:fund_watchlist/repositories/auth_repository.dart';
import 'package:fund_watchlist/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  //supabase
   final supabase = Supabase.instance.client;
  
  //services
  locator.registerLazySingleton(() => NavigationService());

  //repositories
  locator.registerLazySingleton(() => AuthRepository(supabase));

  //bloc
   locator.registerLazySingleton<AuthBloc>(
      () => AuthBloc(locator<AuthRepository>()));
}
