class FlightModel {
  String? id,
      maskapai,
      asalPenerbangan,
      tujuan,
      transit,
      jamBerangkat,
      jamSampai,
      tanggalTerbang;
  int? hargaTiket;

  FlightModel({
    required this.id,
    required this.maskapai,
    required this.asalPenerbangan,
    required this.tujuan,
    required this.transit,
    required this.jamBerangkat,
    required this.jamSampai,
    required this.tanggalTerbang,
    required this.hargaTiket,
  });

  factory FlightModel.fromJson(Map<String, dynamic> object) {
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
  }
}
