import 'dart:convert';
import 'package:gweiland_task/data/models/crypto_detail_model.dart';
import 'package:gweiland_task/data/models/crypto_model.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class ApiServices {
  Future<List<Crypto>> fetchCryptoData() async {
    final response = await http.get(
      Uri.parse(AppConstants.api),
      headers: {"X-CMC_PRO_API_KEY": AppConstants.apiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      List<Crypto> cryptos = [];

      for (var item in data) {
        cryptos.add(Crypto.fromJson(item));
      }

      return cryptos;
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<List<CryptoDetailModel>> fetchCryptoLogo(int cryptoId) async {
    final url = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/info?id=$cryptoId";

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'X-CMC_PRO_API_KEY': AppConstants.apiKey,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final cryptoData = data['data'][cryptoId.toString()];
        return cryptoData['logo'];
      } else {
        throw Exception('Failed to load logo');
      }
    } catch (e) {
      throw Exception('Failed to load logo');
    }
  }




}
