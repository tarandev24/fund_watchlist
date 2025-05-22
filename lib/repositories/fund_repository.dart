import 'package:fund_watchlist/models/fund_model.dart';

class FundRepository {
  Future<FundModel> fetchFundDetails() async {
    await Future.delayed(Duration(seconds: 1));
    return FundModel(
      name: 'Motilal Oswal Midcap Direct Growth',
      nav: 104.2,
      navChange: -3.7,
      invested: 115000,
      currentValue: 112800,
      gain: -2200.16,
      gainPercent: -1.7,
      chartData: [
        ChartPoint(date: '2022', value: 90),
        ChartPoint(date: '2023', value: 105),
        ChartPoint(date: '2024', value: 120),
        ChartPoint(date: '2025', value: 112.8),
      ],
    );
  }
}