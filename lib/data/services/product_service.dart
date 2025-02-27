import 'dart:convert';

import 'package:http/http.dart' as http;

import '../endpoints.dart';
import '../model/remote/product_response.dart';

class ProductService {
  Future<List<ProductResponse>> fetchProducts() async {
    try {
      Uri url = Uri.parse(Endpoints.products);
      final response = await http.get(url);

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

  Future<ProductResponse> postProduct(ProductResponse product) async {
    try {
      Uri url = Uri.parse(Endpoints.products);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(product.toJson()), 
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ProductResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Məhsul yüklənmədi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Xəta yarandı: $e');
    }
  }
}
