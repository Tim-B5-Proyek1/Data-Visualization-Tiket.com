import 'package:data_visualization_b5/models/chart_model.dart';
import 'package:data_visualization_b5/models/flight_model.dart';
import 'package:data_visualization_b5/models/total_flight_chart_model.dart';
import 'package:data_visualization_b5/models/total_flight_month_chart_model.dart';
import 'package:data_visualization_b5/models/total_flight_year_chart_model.dart';
import 'package:data_visualization_b5/services/flight_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlightProvider with ChangeNotifier {
  final _flightService = FlightService();
  List<FlightModel> _flight = [];
  List<FlightModel> get flight => _flight;
  List<AverageTicketPriceChartModel> _chartHargaTiket = [];
  List<AverageTicketPriceChartModel> get chartHargaTiket => _chartHargaTiket;
  List<TotalFlightChartModel> _chartTingkatPenerbanganByMaskapai = [];
  List<TotalFlightChartModel> get chartTingkatPenerbanganByMaskapai =>
      _chartTingkatPenerbanganByMaskapai;
  List<TotalFlightYearChartModel> _chartTotalFlightYear = [];
  List<TotalFlightYearChartModel> get chartTotalFlightYear =>
      _chartTotalFlightYear;
  List<TotalFlightMonthChartModel> _chartTotalFlightMonth = [];
  List<TotalFlightMonthChartModel> get chartTotalFlightMonth =>
      _chartTotalFlightMonth;
  List<FlightModel> _filteredFlights = [];
  List<FlightModel> get filteredFlights => _filteredFlights;
  num _pointIndex = 0;
  num get pointIndex => _pointIndex;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final List<String> _departureTime = [];
  List<String> get departureTime => _departureTime;

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  updatePointIndex(num index) {
    _pointIndex = index;
    notifyListeners();
  }

  Future<bool> getFlight() async {
    checkLoading(true);

    try {
      final data = await _flightService.getFlight();
      _flight = data;
      _chartHargaTiket = mapDataHargaTiket();
      _chartTingkatPenerbanganByMaskapai =
          mapDataTingkatPenerbanganByMaskapai();
      _chartTotalFlightYear = mapDataFlightByYear();
      _chartTotalFlightMonth = mapDataFlightByMonth();
      checkLoading(false);

      return true;
    } catch (e) {
      checkLoading(false);

      return false;
    }
  }

  List<AverageTicketPriceChartModel> mapDataHargaTiket() {
    Map<String, double> totalHargaMap = {};
    Map<String, int> countMap = {};

    for (var flight in _flight) {
      if (flight.maskapai != null && flight.hargaTiket != null) {
        if (totalHargaMap.containsKey(flight.maskapai)) {
          totalHargaMap[flight.maskapai!] =
              totalHargaMap[flight.maskapai]! + flight.hargaTiket!;
          countMap[flight.maskapai!] = countMap[flight.maskapai!]! + 1;
        } else {
          totalHargaMap[flight.maskapai!] = flight.hargaTiket!.toDouble();
          countMap[flight.maskapai!] = 1;
        }
      }
    }

    return totalHargaMap.entries.map((entry) {
      String maskapai = entry.key;
      double totalHarga = entry.value;
      int count = countMap[maskapai]!;
      double rataRataHarga = totalHarga / count;

      return AverageTicketPriceChartModel(
        maskapai,
        rataRataHarga.roundToDouble(),
      );
    }).toList();
  }

  List<TotalFlightChartModel> mapDataTingkatPenerbanganByMaskapai() {
    Map<String, Set<String>> uniqueFlightsMap = {};

    for (var flight in _flight) {
      if (flight.maskapai != null && flight.id != null) {
        if (uniqueFlightsMap.containsKey(flight.maskapai)) {
          uniqueFlightsMap[flight.maskapai]!.add(flight.id!);
        } else {
          uniqueFlightsMap[flight.maskapai!] = {flight.id!};
        }
      }
    }

    List<TotalFlightChartModel> chartModels =
        uniqueFlightsMap.entries.map((entry) {
      String maskapai = entry.key;
      int totalPenerbangan = entry.value.length;
      return TotalFlightChartModel(
        maskapai,
        totalPenerbangan,
      );
    }).toList();

    return chartModels;
  }

  List<TotalFlightYearChartModel> mapDataFlightByYear() {
    Map<String, int> flightsPerYear = {};

    for (var flight in _flight) {
      if (flight.tanggalTerbang != null) {
        String year = flight.tanggalTerbang!.substring(0, 4);
        if (flightsPerYear.containsKey(year)) {
          flightsPerYear[year] = flightsPerYear[year]! + 1;
        } else {
          flightsPerYear[year] = 1;
        }
      }
    }

    return flightsPerYear.entries.map((entry) {
      return TotalFlightYearChartModel(
        entry.key,
        entry.value,
      );
    }).toList();
  }

  List<TotalFlightMonthChartModel> mapDataFlightByMonth() {
    Map<String, int> flightsPerMonth = {};

    for (var flight in _flight) {
      if (flight.tanggalTerbang != null) {
        String month = flight.tanggalTerbang!.substring(0, 7); // YYYY-MM
        if (flightsPerMonth.containsKey(month)) {
          flightsPerMonth[month] = flightsPerMonth[month]! + 1;
        } else {
          flightsPerMonth[month] = 1;
        }
      }
    }

    return flightsPerMonth.entries.map((entry) {
      return TotalFlightMonthChartModel(
        entry.key,
        entry.value,
      );
    }).toList();
  }

  Future<bool> filterFlights(String date, String airline) async {
    checkLoading(true);
    try {
      _departureTime.clear();
      if (_flight.isNotEmpty) {
        _filteredFlights = _flight.where((flight) {
          final matchesDate = date.isEmpty || flight.tanggalTerbang == date;
          final matchesAirline = airline.isEmpty || flight.maskapai == airline;
          return matchesDate && matchesAirline;
        }).toList();
      }
      setDepartureTime();
      checkLoading(false);

      return true;
    } catch (e) {
      checkLoading(false);
      // print("Error: $e");

      return false;
    }
  }

  setDepartureTime() {
    for (var flight in _filteredFlights) {
      final format = DateFormat('HH:mm');
      final jamBerangkat = format.parse(flight.jamBerangkat.toString());
      final jamSampai = format.parse(flight.jamSampai.toString());
      _departureTime.add(jamSampai.difference(jamBerangkat).inMinutes.toString());
    }
  }
}
