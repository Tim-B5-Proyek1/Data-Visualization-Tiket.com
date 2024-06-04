import 'dart:convert';
import 'package:data_visualization_b5/common/constant.dart';
import 'package:data_visualization_b5/models/flight_model.dart';
import 'package:http/http.dart';

class FlightService {
  Future<List<FlightModel>> getFlight() async {
    String apiURL = baseAPIURL();

    try {
      var response = await get(
        Uri.parse(apiURL),
        headers: header(false),
      );

      if (response.statusCode == 200) {
        final flight = jsonDecode(response.body) as List;
        final flights = flight.map((object) {
          return FlightModel(
            id: object['id'],
            maskapai: object['maskapai'],
            asalPenerbangan: object['asal_penerbangan'],
            tujuan: object['tujuan'],
            transit: object['transit'],
            jamBerangkat: object['jam_berangkat'],
            jamSampai: object['jam_sampai'],
            tanggalTerbang: object['tgl_terbang'],
            hargaTiket: object['harga_tiket'],
          );
        }).toList();

        return flights;
      } else {
        return [];
      }
    } catch (e) {
      // print(e);
      throw Exception("Get penerbangan gagal.\nError: $e");
    }
  }
}
