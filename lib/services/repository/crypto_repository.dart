import 'package:gweiland_task/data/models/crypto_detail_model.dart';
import 'package:gweiland_task/data/models/crypto_model.dart';
import '../api_services/api_services.dart';

class CryptoRepository{
  final ApiServices apiServices;
  CryptoRepository(this.apiServices);

  Future<List<Crypto>>getCryptoData() async{
    return await apiServices.fetchCryptoData();
  }

  Future<List<CryptoDetailModel>> getCryptoLogo(int cryptoId) async {
    return await apiServices.fetchCryptoLogo(cryptoId);
  }
}