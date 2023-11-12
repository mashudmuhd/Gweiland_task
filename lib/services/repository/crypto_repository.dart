
import 'package:gweiland_task/data/models/crypto_detail_model.dart';
import 'package:gweiland_task/data/models/crypto_model.dart';
import '../api_services/api_services.dart';

/// Repository class responsible for handling data operations related to cryptocurrencies.
class CryptoRepository {
  /// Instance of [ApiServices] to interact with external APIs.
  final ApiServices apiServices;

  /// Constructor to initialize the repository with an instance of [ApiServices].
  CryptoRepository(this.apiServices);

  /// Fetches a list of general cryptocurrency data.
  ///
  /// Returns a Future containing a List of [Crypto] objects.
  Future<List<Crypto>> getCryptoData() async {
    // Calls the fetchCryptoData method from ApiServices and awaits the result
    return await apiServices.fetchCryptoData();
  }

  /// Fetches a list of detailed cryptocurrency data including logos based on cryptoId.
  ///
  /// Returns a Future containing a List of [CryptoDetailModel] objects.
  Future<List<CryptoDetailModel>> getCryptoLogo(int cryptoId) async {
    // Calls the fetchCryptoLogo method from ApiServices and awaits the result
    return await apiServices.fetchCryptoLogo(cryptoId);
  }
}
