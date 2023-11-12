
import 'dart:convert';
import 'package:gweiland_task/data/models/crypto_detail_model.dart';
import 'package:gweiland_task/data/models/crypto_model.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

/// Service class for making API requests related to cryptocurrencies.
class ApiServices {
  /// Fetches a list of general cryptocurrency data from the API.
  ///
  /// Returns a Future containing a List of [Crypto] objects.
  Future<List<Crypto>> fetchCryptoData() async {
    // Construct the API URL for fetching cryptocurrency data
    String api = "${AppConstants.baseURL}${AppConstants.currencyListEndpoint}";

    // Make an HTTP GET request to the API
    final response = await http.get(
      Uri.parse(api),
      headers: {"X-CMC_PRO_API_KEY": AppConstants.apiKey},
    );


    if (response.statusCode == 200) {
      // Parse the JSON response and extract the 'data' field
      final data = json.decode(response.body)['data'];

      // Create a list to store Crypto objects
      List<Crypto> cryptos = [];

      // Iterate over the data and convert each item to a Crypto object
      for (var item in data) {
        cryptos.add(Crypto.fromJson(item));
      }

      // Return the list of Crypto objects
      return cryptos;
    } else {
      // If the response status code is not 200, throw an exception
      throw Exception("Failed to load data");
    }
  }

  /// Fetches detailed cryptocurrency data including the logo based on cryptoId.
  ///
  /// Returns a Future containing a List of [CryptoDetailModel] objects.
  Future<List<CryptoDetailModel>> fetchCryptoLogo(int cryptoId) async {
    // Construct the URL for fetching detailed cryptocurrency data
    final url = "https://pro-api.coinmarketcap.com/v2/cryptocurrency/info?id=$cryptoId";

    try {
      // Make an HTTP GET request to the URL
      final response = await http.get(Uri.parse(url), headers: {
        'X-CMC_PRO_API_KEY': AppConstants.apiKey,
      });

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // Parse the JSON response and extract the logo information
        final Map<String, dynamic> data = json.decode(response.body);
        final cryptoData = data['data'][cryptoId.toString()];
        return cryptoData['logo'];
      } else {
        // If the response status code is not 200, throw an exception
        throw Exception('Failed to load logo');
      }
    } catch (e) {
      // Catch any exceptions that may occur during the request and throw a custom exception
      throw Exception('Failed to load logo');
    }
  }
}
