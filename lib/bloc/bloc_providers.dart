import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fund_watchlist/bloc/login/auth_bloc.dart';
import 'package:fund_watchlist/locator.dart';

class BlocProviders {
  static List<BlocProvider> getProviders() {
    return [
      BlocProvider<AuthBloc>(
        create: (_) => locator<AuthBloc>(),
      ),
    ];
  }
}
