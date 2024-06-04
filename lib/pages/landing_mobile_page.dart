import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:data_visualization_b5/common/constant.dart';
import 'package:data_visualization_b5/pages/flight_mobile_page.dart';
import 'package:data_visualization_b5/pages/flight_page.dart';
import 'package:data_visualization_b5/providers/flight_provider.dart';
import 'package:data_visualization_b5/providers/landing_provider.dart';
import 'package:data_visualization_b5/widgets/airline_logo_widget.dart';
import 'package:data_visualization_b5/widgets/chart_harga_tiket_mobile_widget.dart';
import 'package:data_visualization_b5/widgets/chart_total_flight_by_month_widget.dart';
import 'package:data_visualization_b5/widgets/chart_total_flight_by_year_widget.dart';
import 'package:data_visualization_b5/widgets/chart_total_penerbangan_by_maskapai_widget.dart';
import 'package:data_visualization_b5/widgets/drawer_item_widget.dart';
import 'package:data_visualization_b5/widgets/flight_schedule_widget.dart';
import 'package:data_visualization_b5/widgets/footer_widget.dart';
import 'package:data_visualization_b5/widgets/image_header_widget.dart';
import 'package:data_visualization_b5/widgets/page_indicator_widget.dart';
import 'package:data_visualization_b5/widgets/responsive_layout_widget.dart';
import 'package:data_visualization_b5/widgets/section_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LandingMobilePage extends StatefulWidget {
  const LandingMobilePage({super.key});

  @override
  State<LandingMobilePage> createState() => _LandingMobilePageState();
}

class _LandingMobilePageState extends State<LandingMobilePage> with AfterLayoutMixin<LandingMobilePage> {
  late PageController pageViewHeaderController;
  late PageController pageViewTeamMemberController;
  final airlineScrollController = ScrollController();
  final teamMemberScrollController = ScrollController();
  ScrollController visualisasiScrollController = ScrollController();
  GlobalKey homeKey = GlobalKey();
  GlobalKey flightKey = GlobalKey();
  GlobalKey airlineKey = GlobalKey();
  GlobalKey dataVisualizationKey = GlobalKey();
  GlobalKey aboutUsKey = GlobalKey();
  late TooltipBehavior tooltipHargaTiket;
  late TooltipBehavior tooltipTotalPenerbangan;
  late TooltipBehavior tooltipTotalPenerbanganPerTahun;
  late TooltipBehavior tooltipTotalPenerbanganPerBulan;
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    tooltipHargaTiket = TooltipBehavior(
      enable: true,
      textStyle: primaryTextStyle.copyWith(
        color: white,
      ),
      header: "Rata-rata Harga Tiket",
    );
    tooltipTotalPenerbangan = TooltipBehavior(
      enable: true,
      textStyle: primaryTextStyle.copyWith(
        color: white,
      ),
      header: "Total Penerbangan",
    );
    tooltipTotalPenerbanganPerTahun = TooltipBehavior(
      enable: true,
      textStyle: primaryTextStyle.copyWith(
        color: white,
      ),
      header: "Total Penerbangan Pertahun",
    );
    tooltipTotalPenerbanganPerBulan = TooltipBehavior(
      enable: true,
      textStyle: primaryTextStyle.copyWith(
        color: white,
      ),
      header: "Total Penerbangan Perbulan",
    );
    pageViewHeaderController = PageController();
    pageViewTeamMemberController = PageController(
      initialPage: 0,
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    animateToMinMax(
      airlineScrollController.position.maxScrollExtent,
      airlineScrollController.position.minScrollExtent,
      airlineScrollController.position.maxScrollExtent,
      10,
      airlineScrollController,
    );
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
    airlineScrollController.dispose();
    teamMemberScrollController.dispose();
    visualisasiScrollController.dispose();
    pageViewHeaderController.dispose();
  }

  animateToMinMax(
    double max,
    double min,
    double direction,
    int seconds,
    ScrollController controller,
  ) {
    if (isDisposed == false) {
      controller
          .animateTo(
        direction,
        duration: Duration(seconds: seconds),
        curve: Curves.linear,
      )
          .then(
        (value) {
          direction = direction == max ? min : max;
          animateToMinMax(
            max,
            min,
            direction,
            seconds,
            controller,
          );
        },
      );
    }
  }

  Widget buildDrawerMenuItem(BuildContext context) => Column(
        children: [
          DrawerItemWidget(
            text: "Beranda",
            onTap: () {
              Scrollable.ensureVisible(
                homeKey.currentContext!,
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
              );
              Navigator.of(context).pop();
            },
          ),
          DrawerItemWidget(
            text: "Data Penerbangan",
            onTap: () {
              Scrollable.ensureVisible(
                flightKey.currentContext!,
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
              );
              Navigator.of(context).pop();
            },
          ),
          DrawerItemWidget(
            text: "Maskapai",
            onTap: () {
              Scrollable.ensureVisible(
                airlineKey.currentContext!,
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
              );
              Navigator.of(context).pop();
            },
          ),
          DrawerItemWidget(
            text: "Visualisasi Data",
            onTap: () {
              Scrollable.ensureVisible(
                dataVisualizationKey.currentContext!,
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
              );
              Navigator.of(context).pop();
            },
          ),
          DrawerItemWidget(
            text: "Tentang Kami",
            onTap: () {
              Scrollable.ensureVisible(
                aboutUsKey.currentContext!,
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FlightProvider>(
        context,
        listen: false,
      ).getFlight();

      Provider.of<LandingProvider>(
        context,
        listen: false,
      ).setCurrentDate();
    });

    return Consumer2<LandingProvider, FlightProvider>(
      builder: (context, landingProvider, flightProvider, child) {
        return Title(
          title: "BFive | Visualisasi Data",
          color: white,
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              title: Image.asset(
                "assets/png/Tiket.png",
                height: 100,
                width: 150,
                fit: BoxFit.contain,
              ),
            ),
            drawer: Drawer(
              backgroundColor: backgroundColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildDrawerMenuItem(context),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      key: homeKey,
                      height: height(context) * 0.3,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                        ),
                        child: ImageHeaderWidget(
                          landingProvider: landingProvider,
                          pageViewHeaderController: pageViewHeaderController,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    SectionTitleWidget(
                      key: flightKey,
                      title: "Data Penerbangan",
                      subtitle: "Lihat Data Penerbangan di Sini",
                      paddingLeft: 70,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    SizedBox(
                      height: 400,
                      width: width(context) * 0.8,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                        child: FlightScheduleWidget(
                          landingProvider: landingProvider,
                          flightProvider: flightProvider,
                          page: const ResponsiveLayoutWidget(
                            mobileBody: FlightMobilePage(),
                            desktopBody: FlightPage(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    SectionTitleWidget(
                      key: airlineKey,
                      title: "Maskapai",
                      subtitle: "Daftar Maskapai yang Kami Scrape",
                      paddingLeft: 100,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 300,
                          width: double.maxFinite,
                          color: white,
                        ),
                        SizedBox(
                          height: 200,
                          width: width(context) * 0.8,
                          child: SingleChildScrollView(
                            controller: airlineScrollController,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: const Row(
                              children: [
                                AirlineLogoWidget(logo: "citilink"),
                                AirlineLogoWidget(logo: "nam-air"),
                                AirlineLogoWidget(logo: "garuda-indonesia"),
                                AirlineLogoWidget(logo: "lion-air"),
                                AirlineLogoWidget(logo: "pelita-air"),
                                AirlineLogoWidget(logo: "super-air-jet"),
                                AirlineLogoWidget(logo: "batik-air"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    SectionTitleWidget(
                      key: dataVisualizationKey,
                      title: "Visualisasi Data",
                      subtitle: "Data yang divisualisasikan oleh B5",
                      paddingLeft: 80,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Container(
                      height: 450,
                      padding: EdgeInsets.all(defaultPadding),
                      width: width(context) * 0.8,
                      child: Scrollbar(
                        controller: visualisasiScrollController,
                        child: SingleChildScrollView(
                          controller: visualisasiScrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ChartTotalFlightByMaskapaiWidget(
                                flightProvider: flightProvider,
                                tooltipTotalPenerbangan:
                                    tooltipTotalPenerbangan,
                              ),
                              SizedBox(
                                width: width(context) * 0.1,
                              ),
                              ChartHargaTiketMobileWidget(
                                flightProvider: flightProvider,
                                tooltipHargaTiket: tooltipHargaTiket,
                              ),
                              SizedBox(
                                width: width(context) * 0.1,
                              ),
                              ChartTotalFlightByYearWidget(
                                flightProvider: flightProvider,
                                tooltipTotalPenerbanganPerTahun:
                                    tooltipTotalPenerbanganPerTahun,
                              ),
                              SizedBox(
                                width: width(context) * 0.1,
                              ),
                              ChartTotalFlightByMonthWidget(
                                flightProvider: flightProvider,
                                tooltipTotalPenerbanganPerBulan:
                                    tooltipTotalPenerbanganPerBulan,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    SectionTitleWidget(
                      key: aboutUsKey,
                      title: "Tentang Kami",
                      subtitle: "Anggota tim B5",
                      paddingLeft: 90,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    SizedBox(
                      height: 300,
                      width: width(context) * 0.8,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView(
                            controller: pageViewTeamMemberController,
                            children: landingProvider.imageMemberTeam,
                            onPageChanged: (value) {
                              landingProvider
                                  .setCurrentPageIndexTeamMember(value);
                            },
                          ),
                          Positioned(
                            bottom: -30,
                            child: PageIndicatorWidget(
                              length: landingProvider.imageMemberTeam.length,
                              currentPage:
                                  landingProvider.currentPageIndexTeamMember,
                              duration: 1000,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height(context) * 0.2,
                    ),
                    const FooterWidget(),
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
