part of 'fund_bloc.dart';


abstract class FundState {}

class FundInitial extends FundState {}

class FundLoading extends FundState {}

class FundLoaded extends FundState {
  final FundModel fund;
  FundLoaded(this.fund);
}

class FundError extends FundState {
  final String message;
  FundError(this.message);
}