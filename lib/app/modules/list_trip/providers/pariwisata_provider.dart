import 'package:get/get.dart';

import '../pariwisata_model.dart';

class PariwisataProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Pariwisata.fromJson(map);
      if (map is List)
        return map.map((item) => Pariwisata.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Pariwisata?> getPariwisata(int id) async {
    final response = await get('pariwisata/$id');
    return response.body;
  }

  Future<Response<Pariwisata>> postPariwisata(Pariwisata pariwisata) async =>
      await post('pariwisata', pariwisata);
  Future<Response> deletePariwisata(int id) async =>
      await delete('pariwisata/$id');
}
