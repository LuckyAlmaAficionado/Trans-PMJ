class Pariwisata {
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? id;
  String? idTripUtama;
  int? idBus;
  String? idDriver;
  String? idCoDriver;
  String? tripNomor;
  String? tanggalBerangkat;
  String? waktuBerangkat;
  String? tanggalKembali;
  String? waktuKembali;
  String? tujuanWisata;
  String? namaBus;
  String? platBus;
  String? nilaiKontrak;

  Pariwisata(
      {this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.id,
      this.idTripUtama,
      this.idBus,
      this.idDriver,
      this.idCoDriver,
      this.tripNomor,
      this.tanggalBerangkat,
      this.waktuBerangkat,
      this.tanggalKembali,
      this.waktuKembali,
      this.tujuanWisata,
      this.namaBus,
      this.platBus,
      this.nilaiKontrak});

  factory Pariwisata.fromJson(Map<String, dynamic> json) => Pariwisata(
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        deletedAt: json['deletedAt'],
        id: json['id'],
        idTripUtama: json['idTripUtama'],
        idBus: json['idBus'],
        idDriver: json['idDriver'],
        idCoDriver: json['idCoDriver'],
        tripNomor: json['tripNomor'],
        tanggalBerangkat: json['tanggalBerangkat'],
        waktuBerangkat: json['waktuBerangkat'],
        tanggalKembali: json['tanggalKembali'],
        waktuKembali: json['waktuKembali'],
        tujuanWisata: json['tujuanWisata'],
        namaBus: json['namaBus'],
        platBus: json['platBus'],
        nilaiKontrak: json['nilaiKontrak'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['id'] = id;
    data['idTripUtama'] = idTripUtama;
    data['idBus'] = idBus;
    data['idDriver'] = idDriver;
    data['idCoDriver'] = idCoDriver;
    data['tripNomor'] = tripNomor;
    data['tanggalBerangkat'] = tanggalBerangkat;
    data['waktuBerangkat'] = waktuBerangkat;
    data['tanggalKembali'] = tanggalKembali;
    data['waktuKembali'] = waktuKembali;
    data['tujuanWisata'] = tujuanWisata;
    data['namaBus'] = namaBus;
    data['nilaiKontrak'] = nilaiKontrak;
    return data;
  }
}
