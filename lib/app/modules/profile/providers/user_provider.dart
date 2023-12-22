import 'package:get/get.dart';
import 'package:trans/app/modules/profile/user_model.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Pengguna.fromJson(map);
      if (map is List)
        return map.map((item) => Pengguna.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Pengguna?> getUser(int id) async {
    final response = await get('user/$id');
    return response.body;
  }

  Future<Response<Pengguna>> postUser(Pengguna user) async =>
      await post('user', user);
  Future<Response> deleteUser(int id) async => await delete('user/$id');
}
