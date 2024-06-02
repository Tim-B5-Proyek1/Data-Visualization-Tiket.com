import 'package:data_visualization_b5/common/constant.dart';
import 'package:data_visualization_b5/models/total_flight_year_chart_model.dart';
import 'package:data_visualization_b5/providers/flight_provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartTotalFlightByYearWidget extends StatelessWidget {
  const ChartTotalFlightByYearWidget({
    super.key,
    required this.flightProvider,
    required this.tooltipTotalPenerbanganPerTahun,
  });

  final FlightProvider flightProvider;
  final TooltipBehavior tooltipTotalPenerbanganPerTahun;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      tooltipBehavior: tooltipTotalPenerbanganPerTahun,
      margin: EdgeInsets.zero,
      // palette: [
      //   primaryColor,
      //   secondaryColor,
      //   Colors.red,
      // ],
      legend: Legend(
        toggleSeriesVisibility: true,
        position: LegendPosition.bottom,
        isVisible: true,
        textStyle: secondaryTextStyle,
        overflowMode: LegendItemOverflowMode.wrap,
        isResponsive: true,
        orientation: LegendItemOrientation.vertical,
      ),
      primaryXAxis: CategoryAxis(
        minorTickLines: const MinorTickLines(size: 0),
        labelPlacement: LabelPlacement.onTicks,
        labelStyle: primaryTextStyle,
        rangePadding: ChartRangePadding.round,
      ),
      primaryYAxis: NumericAxis(
        isVisible: false,
      ),
      series: <CartesianSeries>[
        ColumnSeries<TotalFlightYearChartModel, String>(
          dataSource: flightProvider.chartTotalFlightYear,
          xValueMapper: (data, _) => data.maskapai,
          yValueMapper: (data, _) => data.totalPenerbangan,
          dataLabelMapper: (data, _) => data.maskapai,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: secondaryTextStyle,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              white,
            ],
          ),
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            borderColor: white,
            color: Colors.yellow,
          ),
          borderWidth: 5,
          enableTooltip: true,
          borderColor: primaryColor,
          isVisible: true,
          color: secondaryColor,
        ),
      ],
    );
  }
}
