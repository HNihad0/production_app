import 'dart:convert';
import 'package:http/http.dart' as http;

import '../endpoints.dart';
import '../model/remote/product_response.dart';

class ProductService {
  Future<List<ProductResponse>> fetchProducts() async {
    try {
      Uri productUrl = Uri.parse(Endpoints.products);
      final response = await http.get(productUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data
            .map((productJson) => ProductResponse.fromJson(productJson))
            .toList();
      } else {
        throw Exception('Məhsullar yüklənmədi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Xəta yarandı: $e');
    }
  }
}
