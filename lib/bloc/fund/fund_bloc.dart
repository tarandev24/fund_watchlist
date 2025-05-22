import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fund_watchlist/models/fund_model.dart';
import 'package:fund_watchlist/repositories/fund_repository.dart';

part 'fund_event.dart';
part 'fund_state.dart';

class FundBloc extends Bloc<FundEvent, FundState> {
  final FundRepository repository;

  FundBloc(this.repository) : super(FundInitial()) {
    on<LoadFundDetails>((event, emit) async {
      emit(FundLoading());
      try {
        final fund = await repository.fetchFundDetails();
        emit(FundLoaded(fund));
      } catch (e) {
        emit(FundError('Failed to load fund details'));
      }
    });
  }
}
