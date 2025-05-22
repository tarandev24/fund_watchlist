class FundModel {
  final String name;
  final double nav;
  final double navChange;
  final double invested;
  final double currentValue;
  final double gain;
  final double gainPercent;
  final List<ChartPoint> chartData;

  FundModel({
    required this.name,
    required this.nav,
    required this.navChange,
    required this.invested,
    required this.currentValue,
    required this.gain,
    required this.gainPercent,
    required this.chartData,
  });
}

class ChartPoint {
  final String date;
  final double value;

  ChartPoint({required this.date, required this.value});
}