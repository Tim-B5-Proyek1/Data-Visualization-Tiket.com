import 'package:data_visualization_b5/common/constant.dart';
import 'package:data_visualization_b5/providers/flight_provider.dart';
import 'package:data_visualization_b5/providers/landing_provider.dart';
import 'package:data_visualization_b5/widgets/airline_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FlightListTileWidget extends StatelessWidget {
  const FlightListTileWidget({
    super.key,
    required this.landingProvider,
    required this.flightProvider,
  });

  final LandingProvider landingProvider;
  final FlightProvider flightProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * 0.8,
      child: flightProvider.filteredFlights.isNotEmpty
          ? ListView.separated(
              shrinkWrap: true,
              itemCount: flightProvider.filteredFlights.length,
              itemBuilder: (context, index) {
                final flight = flightProvider.filteredFlights;

                return Container(
                  width: width(context) * 0.8,
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    boxShadow: [
                      primaryShadow,
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: white,
                                shape: BoxShape.circle,
                              ),
                              child: AirlineLogoWidget(
                                  logo: landingProvider.pathAirlineSVG),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              flight[index].maskapai.toString(),
                              style: secondaryTextStyle,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset("assets/png/briefcase.png"),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset("assets/png/fork-spoon.png"),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    flight[index].jamBerangkat.toString(),
                                    style: secondaryTextStyle.copyWith(
                                      fontWeight: bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    flight[index].asalPenerbangan.toString(),
                                    style: secondaryTextStyle.copyWith(
                                      fontWeight: regular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: defaultPadding,
                            ),
                            SizedBox(
                              child: Column(
                                children: [
                                  Text(
                                    "${flightProvider.departureTime[index]} menit",
                                    style: secondaryTextStyle.copyWith(
                                      fontWeight: regular,
                                    ),
                                  ),
                                  SvgPicture.asset("assets/svg/margin.svg"),
                                  Text(
                                    flight[index].transit.toString(),
                                    style: secondaryTextStyle.copyWith(
                                      fontWeight: regular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: defaultPadding,
                            ),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    flight[index].jamSampai.toString(),
                                    style: secondaryTextStyle.copyWith(
                                      fontWeight: bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    flight[index].tujuan.toString(),
                                    style: secondaryTextStyle.copyWith(
                                      fontWeight: regular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width(context) * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Rp${formatCurrency(flight[index].hargaTiket)}",
                              style: secondaryTextStyle.copyWith(
                                fontWeight: bold,
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              "/orang",
                              style: secondaryTextStyle.copyWith(
                                fontWeight: regular,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
            )
          : Padding(
              padding: EdgeInsets.only(top: height(context) * 0.2),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.archive_rounded,
                      color: primaryColor,
                      size: height(context) * 0.1,
                    ),
                    Text(
                      "Data Penerbangan Kosong",
                      style: secondaryTextStyle,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
