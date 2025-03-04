import 'dart:convert';
import 'dart:developer';

import 'package:amoris_new/data/model/remote/ready_product_response.dart';
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

  Future<List<ReadyProductResponse>> fetchReadyProduct() async {
    try {
      Uri url = Uri.parse(Endpoints.readyProduct);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data
            .map((productJson) => ReadyProductResponse.fromJson(productJson))
            .toList();
      } else {
        throw Exception('Məhsullar yüklənmədi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Xəta yarandı: $e');
    }
  }

  Future<void> updateProductStatus(String senNo, int stat) async {
  try {
    Uri url = Uri.parse(Endpoints.updateProductStatus); 
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'senNo': senNo,
        'stat': stat,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Stat uğurla yeniləndi.');
    } else {
      throw Exception('Stat yenilənmədi: ${response.statusCode}:${response.body}');
    }
  } catch (e) {
    throw Exception('Xəta yarandı: $e');
  }
}

Future<void> deleteProduct(String senNo) async {
  try {
    Uri url = Uri.parse(Endpoints.deleteProduct); 
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'senNo': senNo,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('Məhsul silindi.');
    } else {
      throw Exception('Məhsul silinmədi: ${response.statusCode}:${response.body}');
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
