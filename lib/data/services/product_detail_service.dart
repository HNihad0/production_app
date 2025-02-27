import 'dart:convert';
import 'package:http/http.dart' as http;

import '../endpoints.dart';
import '../model/remote/product_detail_response.dart';

class ProductDetailService {
  Future<List<ProductDetailResponse>> fetchProductsDetail() async {
    try {
      Uri url = Uri.parse(Endpoints.productDetail);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data
            .map((productJson) => ProductDetailResponse.fromJson(productJson))
            .toList();
      } else {
        throw Exception('Məhsul inqrediyenti yüklənmədi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Xəta yarandı: $e');
    }
  }
}
