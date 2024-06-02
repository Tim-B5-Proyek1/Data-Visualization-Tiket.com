import 'package:data_visualization_b5/common/constant.dart';
import 'package:data_visualization_b5/providers/flight_provider.dart';
import 'package:data_visualization_b5/providers/landing_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          color: Colors.white,
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
                    AppBar(
                      automaticallyImplyLeading: false,
                      toolbarHeight: 80,
                      flexibleSpace: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding),
                              height: 50,
                              width: width(context) * 0.8,
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius:
                                    BorderRadius.circular(defaultBorderRadius),
                                boxShadow: [
                                  primaryShadow,
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color: black,
                                          ),
                                          SizedBox(
                                            width: defaultPadding,
                                          ),
                                          Text(
                                            "Jakarta, CGK",
                                            style: secondaryTextStyle,
                                          ),
                                          SizedBox(
                                            width: defaultPadding,
                                          ),
                                          Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              color: white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                primaryShadow,
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.arrow_right_alt_rounded,
                                              color: black,
                                            ),
                                          ),
                                          SizedBox(
                                            width: defaultPadding,
                                          ),
                                          Text(
                                            "Surabaya, SUB",
                                            style: secondaryTextStyle,
                                          ),
                                          const VerticalDivider(),
                                          SizedBox(
                                            width: width(context) * 0.3,
                                            child: DropdownButtonFormField(
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
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
                                                    (object) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                      value: object,
                                                      child: Text(
                                                        object,
                                                        style:
                                                            secondaryTextStyle,
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (value) {
                                                if (value != null) {
                                                  landingProvider
                                                      .setPathPlaneImage(
                                                    value.toString(),
                                                  );
                                                  landingProvider
                                                      .setSelectedAirline(
                                                          value);
                                                }
                                              },
                                            ),
                                          ),
                                          const VerticalDivider(),
                                          GestureDetector(
                                            onTap: () {
                                              selectDate(
                                                  context, landingProvider);
                                            },
                                            child: Text(
                                              landingProvider
                                                          .selectedDateFormatted !=
                                                      null
                                                  ? landingProvider
                                                      .selectedDateFormatted
                                                      .toString()
                                                  : landingProvider
                                                      .currentDateFormatted
                                                      .toString(),
                                              style: secondaryTextStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              defaultBorderRadius),
                                        ),
                                        backgroundColor:
                                            const Color(0xffE7F2FF),
                                      ),
                                      onPressed: () async {
                                        if (landingProvider
                                                .selectedDateFormatted !=
                                            null) {
                                          if (await flightProvider
                                              .filterFlights(
                                                  landingProvider
                                                      .selectedDateFormatted
                                                      .toString(),
                                                  landingProvider
                                                      .selectedAirline
                                                      .toString())) {}
                                        } else {
                                          if (await flightProvider
                                              .filterFlights(
                                                  landingProvider
                                                      .currentDateFormatted
                                                      .toString(),
                                                  landingProvider
                                                      .selectedAirline
                                                      .toString())) {}
                                        }
                                      },
                                      child: flightProvider.isLoading
                                          ? Center(
                                              child: SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
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
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    SizedBox(
                        width: width(context) * 0.8,
                        child: flightProvider.filteredFlights.isNotEmpty
                            ? ListView.separated(
                                // controller: flightScrollController,
                                shrinkWrap: true,
                                itemCount:
                                    flightProvider.filteredFlights.length,
                                itemBuilder: (context, index) {
                                  final flight = flightProvider.filteredFlights;

                                  return Container(
                                    width: width(context) * 0.8,
                                    padding: EdgeInsets.all(defaultPadding),
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(
                                          defaultBorderRadius),
                                      boxShadow: [
                                        primaryShadow,
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  color: white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/svg/batik-air.svg",
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                flight[index]
                                                    .maskapai
                                                    .toString(),
                                                style: secondaryTextStyle,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Image.asset(
                                                  "assets/png/briefcase.png"),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Image.asset(
                                                  "assets/png/fork-spoon.png"),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      flight[index]
                                                          .jamBerangkat
                                                          .toString(),
                                                      style: secondaryTextStyle
                                                          .copyWith(
                                                        fontWeight: bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      flight[index]
                                                          .asalPenerbangan
                                                          .toString(),
                                                      style: secondaryTextStyle
                                                          .copyWith(
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
                                                      style: secondaryTextStyle
                                                          .copyWith(
                                                        fontWeight: regular,
                                                      ),
                                                    ),
                                                    SvgPicture.asset(
                                                        "assets/svg/margin.svg"),
                                                    Text(
                                                      flight[index]
                                                          .transit
                                                          .toString(),
                                                      style: secondaryTextStyle
                                                          .copyWith(
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      flight[index]
                                                          .jamSampai
                                                          .toString(),
                                                      style: secondaryTextStyle
                                                          .copyWith(
                                                        fontWeight: bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      flight[index]
                                                          .tujuan
                                                          .toString(),
                                                      style: secondaryTextStyle
                                                          .copyWith(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Rp${formatCurrency(flight[index].hargaTiket)}",
                                                style:
                                                    secondaryTextStyle.copyWith(
                                                  fontWeight: bold,
                                                  fontSize: 16,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Text(
                                                "/orang",
                                                style:
                                                    secondaryTextStyle.copyWith(
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
                                padding:
                                    EdgeInsets.only(top: height(context) * 0.2),
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
                              )),
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
