    import 'dart:async';
    import 'package:gweiland_task/data/models/crypto_detail_model.dart';
    import 'package:gweiland_task/data/models/crypto_model.dart';
    import 'package:gweiland_task/services/repository/crypto_repository.dart';

    class CryptoViewModel {
      final CryptoRepository _repository;

      final _cryptoController = StreamController<List<Crypto>>.broadcast();
      final _cryptoLogoController = StreamController<List<CryptoDetailModel>>.broadcast();
      Stream<List<Crypto>> get cryptoStream => _cryptoController.stream;
      Stream<List<CryptoDetailModel>> get logoStream => _cryptoLogoController.stream;

      List<Crypto> _cryptoList = [];
      List<CryptoDetailModel> _cryptoLogoList = [];

      CryptoViewModel(this._repository);

      void fetchCryptoData() async {
        try {
          List<Crypto> cryptoData = await _repository.getCryptoData();
          _cryptoList = cryptoData;
          _cryptoController.add(_cryptoList);
        } catch (error) {
          print('Error fetching crypto data: $error');
          _cryptoController.addError('Error fetching crypto data');
        }
      }


      void fetchCryptoLogo(int id)async{
        print(id);

        try{
          List<CryptoDetailModel>cryptoLogos = await _repository.getCryptoLogo(id);
          _cryptoLogoList =cryptoLogos;
          _cryptoLogoController.add(_cryptoLogoList);
          print(_cryptoLogoController);

        }catch(error){
          print('Error fetching crypto data: $error');
          _cryptoController.addError('Error fetching crypto data');

        }
      }




      void sortByMarketCap() {
        _cryptoList.sort((a, b) => a.quote.usd.marketCap.compareTo(b.quote.usd.marketCap));
        _cryptoController.add(_cryptoList);
      }

      void sortByPrice() {
        _cryptoList.sort((a, b) => a.quote.usd.price.compareTo(b.quote.usd.price));
        _cryptoController.add(_cryptoList);
      }

      void sortByVolume24h() {
        _cryptoList.sort((a, b) => a.quote.usd.volume24h.compareTo(b.quote.usd.volume24h));
        _cryptoController.add(_cryptoList);
      }

      void dispose() {
        _cryptoController.close();
      }
    }
