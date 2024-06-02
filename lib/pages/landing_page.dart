import 'dart:async';
import 'package:data_visualization_b5/common/constant.dart';
import 'package:data_visualization_b5/providers/flight_provider.dart';
import 'package:data_visualization_b5/providers/landing_provider.dart';
import 'package:data_visualization_b5/widgets/airline_logo_widget.dart';
import 'package:data_visualization_b5/widgets/chart_harga_tiket_widget.dart';
import 'package:data_visualization_b5/widgets/chart_total_flight_by_month_widget.dart';
import 'package:data_visualization_b5/widgets/chart_total_flight_by_year_widget.dart';
import 'package:data_visualization_b5/widgets/chart_total_penerbangan_by_maskapai_widget.dart';
import 'package:data_visualization_b5/widgets/flight_schedule_widget.dart';
import 'package:data_visualization_b5/widgets/footer_widget.dart';
import 'package:data_visualization_b5/widgets/image_header_widget.dart';
import 'package:data_visualization_b5/widgets/navigation_bar_widget.dart';
import 'package:data_visualization_b5/widgets/page_indicator_widget.dart';
import 'package:data_visualization_b5/widgets/section_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late PageController pageViewHeaderController;
  late PageController pageViewTeamMemberController;
  final airlineScrollController = ScrollController();
  final teamMemberScrollController = ScrollController();
  GlobalKey homeKey = GlobalKey();
  GlobalKey flightKey = GlobalKey();
  GlobalKey airlineKey = GlobalKey();
  GlobalKey dataVisualizationKey = GlobalKey();
  GlobalKey aboutUsKey = GlobalKey();
  Timer? timer;
  late TooltipBehavior tooltipHargaTiket;
  late TooltipBehavior tooltipTotalPenerbangan;
  late TooltipBehavior tooltipTotalPenerbanganPerTahun;
  late TooltipBehavior tooltipTotalPenerbanganPerBulan;
  ScrollController visualisasiScrollController = ScrollController();

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animateToMinMax(
        airlineScrollController.position.maxScrollExtent,
        airlineScrollController.position.minScrollExtent,
        airlineScrollController.position.maxScrollExtent,
        10,
        airlineScrollController,
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // autoScrollTeamMember();
  }

  @override
  void dispose() {
    super.dispose();
    airlineScrollController.dispose();
    teamMemberScrollController.dispose();
    pageViewHeaderController.dispose();
    timer?.cancel();
  }

  autoScrollTeamMember() {
    final landingProvider = Provider.of<LandingProvider>(context);
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (landingProvider.currentPageIndexTeamMember <=
          landingProvider.imageMemberTeam.length) {
        int iterator = 0;
        iterator++;
        landingProvider.setCurrentPageIndexTeamMember(iterator);
      } else {
        landingProvider.setCurrentPageIndexTeamMember(0);
      }

      pageViewTeamMemberController.animateToPage(
        landingProvider.currentPageIndexTeamMember,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  animateToMinMax(
    double max,
    double min,
    double direction,
    int seconds,
    ScrollController controller,
  ) {
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
              leadingWidth: 250,
              leading: Padding(
                padding: const EdgeInsets.only(left: 100),
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Image.asset(
                    "assets/png/Tiket.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: NavigationBarWidget(
                homeKey: homeKey,
                flightKey: flightKey,
                airlineKey: airlineKey,
                dataVisualizationKey: dataVisualizationKey,
                aboutUsKey: aboutUsKey,
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      key: homeKey,
                      height: 400,
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
                      height: 500,
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
                                tooltipTotalPenerbangan: tooltipTotalPenerbangan,
                              ),
                              SizedBox(
                                width: width(context) * 0.1,
                              ),
                              ChartHargaTiketWidget(
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
