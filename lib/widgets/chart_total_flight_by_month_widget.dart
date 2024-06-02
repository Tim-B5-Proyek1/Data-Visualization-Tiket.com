import 'package:data_visualization_b5/common/constant.dart';
import 'package:data_visualization_b5/models/total_flight_month_chart_model.dart';
import 'package:data_visualization_b5/providers/flight_provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartTotalFlightByMonthWidget extends StatelessWidget {
  const ChartTotalFlightByMonthWidget({
    super.key,
    required this.flightProvider,
    required this.tooltipTotalPenerbanganPerBulan,
  });

  final FlightProvider flightProvider;
  final TooltipBehavior tooltipTotalPenerbanganPerBulan;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.2,
      child: SfCartesianChart(
        tooltipBehavior: tooltipTotalPenerbanganPerBulan,
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
          ColumnSeries<TotalFlightMonthChartModel, String>(
            dataSource: flightProvider.chartTotalFlightMonth,
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
              borderWidth: 0.5,
              color: Colors.yellow,
            ),
            // borderWidth: 5,
            enableTooltip: true,
            // borderColor: primaryColor,
            isVisible: true,
            color: secondaryColor,
          ),
        ],
      ),
    );
  }
}
