import 'package:data_visualization_b5/common/constant.dart';
import 'package:data_visualization_b5/models/chart_model.dart';
import 'package:data_visualization_b5/providers/flight_provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartHargaTiketMobileWidget extends StatelessWidget {
  const ChartHargaTiketMobileWidget({
    super.key,
    required this.flightProvider,
    required this.tooltipHargaTiket,
  });

  final FlightProvider flightProvider;
  final TooltipBehavior tooltipHargaTiket;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "Rata-rata Harga Tiket Berdasarkan Maskapai",
            style: secondaryTextStyle.copyWith(
              fontWeight: bold,
            ),
          ),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        SizedBox(
          width: width(context) * 0.4,
          child: SfCircularChart(
            tooltipBehavior: tooltipHargaTiket,
            margin: EdgeInsets.zero,
            legend: Legend(
              alignment: ChartAlignment.center,
              toggleSeriesVisibility: true,
              position: LegendPosition.bottom,
              isVisible: true,
              textStyle: secondaryTextStyle,
              overflowMode: LegendItemOverflowMode.wrap,
              isResponsive: true,
              orientation: LegendItemOrientation.vertical,
            ),
            series: <CircularSeries>[
              DoughnutSeries<AverageTicketPriceChartModel, String>(
                dataSource: flightProvider.chartHargaTiket,
                xValueMapper: (data, _) => data.maskapai,
                yValueMapper: (data, _) => data.harga,
                dataLabelMapper: (data, _) => "Rp${formatCurrency(data.harga)}",
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: secondaryTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
