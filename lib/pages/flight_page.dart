import 'package:data_visualization_b5/common/constant.dart';
import 'package:data_visualization_b5/providers/flight_provider.dart';
import 'package:data_visualization_b5/providers/landing_provider.dart';
import 'package:data_visualization_b5/widgets/flight_list_tile_widget.dart';
import 'package:data_visualization_b5/widgets/search_bar_flight_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlightPage extends StatefulWidget {
  const FlightPage({super.key});

  @override
  State<FlightPage> createState() => _FlightPageState();
}

class _FlightPageState extends State<FlightPage> {
  ScrollController flightScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<FlightProvider, LandingProvider>(
      builder: (context, flightProvider, landingProvider, child) {
        return Title(
          color: white,
          title: "BFive | Jadwal Penerbangan",
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              // toolbarHeight: 500,
              title: SizedBox(
                height: 100,
                width: 200,
                child: Image.asset(
                  "assets/png/Tiket.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Divider(
                      thickness: 1,
                      color: Colors.grey[350],
                    ),
                    SearchBarFlightWidget(
                      landingProvider: landingProvider,
                      flightProvider: flightProvider,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    FlightListTileWidget(
                      landingProvider: landingProvider,
                      flightProvider: flightProvider,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
