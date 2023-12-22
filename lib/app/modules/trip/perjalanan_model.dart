class Perjalanan {
  bool? status;
  String? idTripUtama;
  String? idDriver;
  String? idCoDriver;
  String? gambarOdometerAwal;
  String? odometerAwal;
  String? gambarOdometerAkhir;
  String? odometerAkhir;
  String? createdAt;
  String? updatedAt;

  Perjalanan(
      {this.status,
      this.idTripUtama,
      this.idDriver,
      this.idCoDriver,
      this.gambarOdometerAwal,
      this.odometerAwal,
      this.gambarOdometerAkhir,
      this.odometerAkhir,
      this.createdAt,
      this.updatedAt});

  factory Perjalanan.fromJson(Map<String, dynamic> json) => Perjalanan(
        status: json['status'],
        idTripUtama: json['idTripUtama'],
        idDriver: json['idDriver'],
        idCoDriver: json['idCoDriver'],
        gambarOdometerAwal: json['gambarOdometerAwal'],
        odometerAwal: json['odometerAwal'],
        gambarOdometerAkhir: json['gambarOdometerAkhir'],
        odometerAkhir: json['odometerAkhir'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['idTripUtama'] = idTripUtama;
    data['idDriver'] = idDriver;
    data['idCoDriver'] = idCoDriver;
    data['gambarOdometerAwal'] = gambarOdometerAwal;
    data['odometerAwal'] = odometerAwal;
    data['gambarOdometerAkhir'] = gambarOdometerAkhir;
    data['odometerAkhir'] = odometerAkhir;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
