class Pengguna {
  String? id;
  String? profilePicture;
  String? username;
  String? nama;
  String? alamat;
  String? email;
  String? nope;
  String? role;
  int? status;
  String? createdAt;
  String? updateAt;
  String? lastLogin;
  String? deleteAt;

  Pengguna(
      {this.id,
      this.profilePicture,
      this.username,
      this.nama,
      this.alamat,
      this.email,
      this.nope,
      this.role,
      this.status,
      this.createdAt,
      this.updateAt,
      this.lastLogin,
      this.deleteAt});

  factory Pengguna.fromJson(Map<String, dynamic> json) => Pengguna(
        id: json['id'],
        profilePicture: json['profilePicture'] ?? '',
        username: json['username'],
        nama: json['nama'],
        alamat: json['alamat'],
        email: json['email'],
        nope: json['nope'],
        role: json['role'],
        status: json['status'],
        createdAt: json['createdAt'],
        updateAt: json['updateAt'],
        lastLogin: json['last_login'],
        deleteAt: json['deleteAt'],
      );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['profilePicture'] = profilePicture;
    data['username'] = username;
    data['nama'] = nama;
    data['alamat'] = alamat;
    data['email'] = email;
    data['nope'] = nope;
    data['role'] = role;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updateAt'] = updateAt;
    data['last_login'] = lastLogin;
    data['deleteAt'] = deleteAt;
    return data;
  }
}
