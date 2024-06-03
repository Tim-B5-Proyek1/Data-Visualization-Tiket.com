import 'package:data_visualization_b5/common/constant.dart';
import 'package:data_visualization_b5/providers/flight_provider.dart';
import 'package:data_visualization_b5/providers/landing_provider.dart';
import 'package:flutter/material.dart';

class SearchBarFlightMobileWidget extends StatelessWidget {
  const SearchBarFlightMobileWidget({
    super.key,
    required this.landingProvider,
    required this.flightProvider,
  });

  final LandingProvider landingProvider;
  final FlightProvider flightProvider;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 250,
      flexibleSpace: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: defaultPadding,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            height: 50,
            width: width(context) * 0.8,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              boxShadow: [
                primaryShadow,
              ],
            ),
            child: Row(
              children: [
                Text(
                  "Jakarta, CGK",
                  style: secondaryTextStyle,
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      primaryShadow,
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_right_alt_rounded,
                    color: black,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Surabaya, SUB",
                  style: secondaryTextStyle,
                ),
              ],
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            height: 50,
            width: width(context) * 0.8,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              boxShadow: [
                primaryShadow,
              ],
            ),
            child: Center(
              child: DropdownButtonFormField(
                hint: Text(
                  "Pilih maskapai",
                  style: secondaryTextStyle,
                ),
                icon: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
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
                          style: secondaryTextStyle,
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
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              height: 50,
              width: width(context) * 0.8,
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
                    child: GestureDetector(
                      onTap: () {
                        selectDate(context, landingProvider);
                      },
                      child: Text(
                        landingProvider.selectedDateFormatted != null
                            ? landingProvider.selectedDateFormatted.toString()
                            : landingProvider.currentDateFormatted.toString(),
                        style: secondaryTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        ),
                        backgroundColor: const Color(0xffE7F2FF),
                      ),
                      onPressed: () async {
                        if (landingProvider.selectedAirline != null) {
                          if (landingProvider.selectedDateFormatted != null) {
                            if (await flightProvider.filterFlights(
                                landingProvider.selectedDateFormatted
                                    .toString(),
                                landingProvider.selectedAirline.toString())) {
                              landingProvider.setAvatarAirlines();
                            }
                          } else {
                            if (await flightProvider.filterFlights(
                                landingProvider.currentDateFormatted.toString(),
                                landingProvider.selectedAirline.toString())) {
                              landingProvider.setAvatarAirlines();
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
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                  color: white,
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : Text(
                              "Cari",
                              style: primaryTextStyle.copyWith(
                                color: primaryColor,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
