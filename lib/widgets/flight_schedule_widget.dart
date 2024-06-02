import 'package:data_visualization_b5/common/constant.dart';
import 'package:data_visualization_b5/pages/flight_page.dart';
import 'package:data_visualization_b5/providers/flight_provider.dart';
import 'package:data_visualization_b5/providers/landing_provider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class FlightScheduleWidget extends StatelessWidget {
  const FlightScheduleWidget({
    super.key,
    required this.landingProvider,
    required this.flightProvider,
  });

  final LandingProvider landingProvider;
  final FlightProvider flightProvider;

  @override
  Widget build(BuildContext context) {
    navigate() {
      Navigator.of(context).push(
        PageTransition(
          child: const FlightPage(),
          type: PageTransitionType.rightToLeft,
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: SizedBox(
            key: UniqueKey(),
            height: 400,
            width: width(context) * 0.8,
            child: Image.asset(
              landingProvider.pathPlaneImage.isEmpty
                  ? "assets/png/airplane.png"
                  : landingProvider.pathPlaneImage,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 400,
          width: width(context) * 0.8,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                black.withOpacity(0.8),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 350,
          width: width(context) * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bandingkan harga tiket\ndi B5.com",
                style: primaryTextStyle.copyWith(
                  fontWeight: bold,
                  fontSize: 50,
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: defaultPadding,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectDate(context, landingProvider);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: 235,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pilih Tanggal",
                                  style: secondaryTextStyle.copyWith(
                                    color: grey400,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  landingProvider.selectedDateFormatted != null
                                      ? landingProvider.selectedDateFormatted
                                          .toString()
                                      : landingProvider.currentDateFormatted
                                          .toString(),
                                  style: secondaryTextStyle.copyWith(
                                    fontWeight: bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: defaultPadding,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: 235,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Maskapai",
                                style: secondaryTextStyle.copyWith(
                                  color: grey400,
                                  fontSize: 12,
                                ),
                              ),
                              DropdownButtonFormField(
                                hint: Text(
                                  "Pilih maskapai",
                                  style: secondaryTextStyle.copyWith(
                                      fontWeight: bold),
                                ),
                                icon: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      primaryShadow,
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: black,
                                  ),
                                ),
                                items: [
                                  "Batik Air Indonesia",
                                  "Citilink",
                                  "Lion Air",
                                  "Garuda Indonesia",
                                  "Pelita Air",
                                  "Nam Air",
                                  "Super Air Jet"
                                ]
                                    .map(
                                      (object) => DropdownMenuItem<String>(
                                        value: object,
                                        child: Text(
                                          object,
                                          style: secondaryTextStyle.copyWith(
                                              fontWeight: bold),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    landingProvider.setPathPlaneImage(
                                      value.toString(),
                                    );
                                    landingProvider.setSelectedAirline(value);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    child: SizedBox(
                      height: 40,
                      width: 235,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: primaryColor,
                        ),
                        onPressed: () async {
                          if (landingProvider.selectedAirline != null) {
                            if (landingProvider.selectedDateFormatted != null) {
                              if (await flightProvider.filterFlights(
                                  landingProvider.selectedDateFormatted
                                      .toString(),
                                  landingProvider.selectedAirline.toString())) {
                                landingProvider.setAvatarAirlines();
                                navigate();
                              }
                            } else {
                              if (await flightProvider.filterFlights(
                                  landingProvider.currentDateFormatted
                                      .toString(),
                                  landingProvider.selectedAirline.toString())) {
                                landingProvider.setAvatarAirlines();
                                navigate();
                              }
                            }
                          } else {
                            showSnackBar(
                              context,
                              "Pilih maskapai terlebih dahulu",
                              Colors.red,
                            );
                          }
                        },
                        child: flightProvider.isLoading
                            ? Center(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: white,
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : Text(
                                "Lihat Semua",
                                style: primaryTextStyle,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
