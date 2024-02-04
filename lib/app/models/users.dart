class UserModel {
  String? docId;
  String? createdAt;
  String? updateAt;
  String? deleteAt;
  String? username;
  String? nama;
  String? alamat;
  String? nope;
  String? email;
  int? status;
  String? lastLogin;
  String? role;

  UserModel({
    this.createdAt,
    this.updateAt,
    this.deleteAt,
    this.docId,
    this.username,
    this.nama,
    this.alamat,
    this.nope,
    this.email,
    this.status,
    this.lastLogin,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        createdAt: json["createdAt"] ?? "",
        updateAt: json["updateAt"] ?? "",
        deleteAt: json["deleteAt"] ?? "",
        docId: json["docId"] ?? "",
        username: json["username"] ?? "",
        nama: json["nama"] ?? "",
        alamat: json["alamat"] ?? "",
        nope: json["nope"] ?? "",
        email: json["email"] ?? "",
        status: json["status"] ?? 0,
        lastLogin: json["last_login"] ?? "",
        role: json["role"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "updateAt": updateAt,
        "deleteAt": deleteAt,
        "docId": docId,
        "username": username,
        "nama": nama,
        "alamat": alamat,
        "nope": nope,
        "email": email,
        "status": status,
        "last_login": lastLogin,
        "role": role,
      };
}
