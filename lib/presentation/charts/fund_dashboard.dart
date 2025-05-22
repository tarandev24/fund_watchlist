import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fund_watchlist/bloc/fund/fund_bloc.dart';
import 'package:fund_watchlist/presentation/charts/components/line_chart.dart';
import 'package:fund_watchlist/repositories/fund_repository.dart';

class FundDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FundBloc(FundRepository())..add(LoadFundDetails()),
      child:  SafeArea(
          child: BlocBuilder<FundBloc, FundState>(
            builder: (context, state) {
              if (state is FundLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is FundLoaded) {
                final fund = state.fund;
                return SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fund.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text('₹ ${fund.nav}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          SizedBox(width: 8),
                          Text('${fund.navChange}',
                              style: TextStyle(
                                  color: fund.navChange < 0
                                      ? Colors.red
                                      : Colors.green))
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _infoCard('Invested', fund.invested),
                          _infoCard('Current Value', fund.currentValue),
                          _infoCard('Total Gain', fund.gain,
                              isGain: true, gainPercent: fund.gainPercent)
                        ],
                      ),
                      SizedBox(height: 24),
                      Container(
                        height: 200,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: LineChartWidget(data: fund.chartData),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('Sell'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('Invest More'),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              } else if (state is FundError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ),
      
    );
  }

  Widget _infoCard(String title, double value,
      {bool isGain = false, double? gainPercent}) {
    Color valueColor = isGain
        ? (value < 0 ? Colors.red : Colors.green)
        : Colors.white;
    return Column(
      children: [
        Text(title, style: TextStyle(color: Colors.grey)),
        SizedBox(height: 4),
        Text('₹ ${value.toStringAsFixed(2)}', style: TextStyle(color: valueColor)),
        if (isGain && gainPercent != null)
          Text('${gainPercent.toStringAsFixed(1)}%',
              style: TextStyle(color: valueColor))
      ],
    );
  }
}
