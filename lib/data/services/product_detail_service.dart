import 'dart:convert';
import 'dart:developer';
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
        throw Exception(
            'Məhsul inqrediyenti yüklənmədi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Xəta yarandı: $e');
    }
  }

  Future<bool> postProductDetail({
    required String code,
    required int ware,
    required double count,
    required double weight,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        "code": code,
        "ware": ware,
        "count": count,
        "weight": weight,
      };

      log("Request Body: ${json.encode(requestBody)}");

      Uri url = Uri.parse(Endpoints.submitProducts);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Məlumat göndərilmədi: ${response.body}');
      }
    } catch (e) {
      throw Exception('Xəta yarandı: $e');
    }
  }
}
