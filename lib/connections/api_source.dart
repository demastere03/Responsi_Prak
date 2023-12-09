import 'package:responsi_prak/connections/base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadMenu() {
    return BaseNetwork.get("categories.php");
  }

  Future <Map<String, dynamic>> getMeals(String param) {
    return BaseNetwork.get('filter.php?c=$param');
  }

  Future <Map<String, dynamic>> getDetails(String id) {
    return BaseNetwork.get('lookup.php?i=$id');
  }
}