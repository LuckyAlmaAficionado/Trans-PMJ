import 'package:get/get.dart';

import '../../trip/perjalanan_model.dart';

class PerjalananProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Perjalanan.fromJson(map);
      if (map is List)
        return map.map((item) => Perjalanan.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Perjalanan?> getPerjalanan(int id) async {
    final response = await get('perjalanan/$id');
    return response.body;
  }

  Future<Response<Perjalanan>> postPerjalanan(Perjalanan perjalanan) async =>
      await post('perjalanan', perjalanan);
  Future<Response> deletePerjalanan(int id) async =>
      await delete('perjalanan/$id');
}
