import 'package:flutter/material.dart';
import 'package:gweiland_task/data/models/crypto_detail_model.dart';
import 'package:gweiland_task/data/models/crypto_model.dart';
import 'package:gweiland_task/presentation/screens/widgets/crypto_list_widgets.dart';
import 'package:gweiland_task/presentation/view_models/crypto_view_model.dart';
import 'package:gweiland_task/resources/assets_manager.dart';
import 'package:gweiland_task/resources/color_manager.dart';
import 'package:gweiland_task/resources/strings_manager.dart';
import 'package:gweiland_task/resources/styles_manager.dart';
import 'package:gweiland_task/resources/values_manager.dart';
import 'package:provider/provider.dart';
import '../../services/api_services/api_services.dart';
import '../../services/repository/crypto_repository.dart';

class CryptoListView extends StatelessWidget {
  final CryptoViewModel viewModel =
      CryptoViewModel(CryptoRepository(ApiServices()));

  CryptoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    viewModel.fetchCryptoData();


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            buildHeaderRow(),
            const SizedBox(
              height: AppSize.s14,
            ),
            buildSearchAndFilterRow(context:context,onTap: () {
              _showSortDialog(context);
            }),
          ],
        ),
        toolbarHeight: 150.0,
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
      body: buildCryptoListViewBody(context),
    );
  }

  //Bottom navigation
  Widget buildBottomNavigationBar(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildNavItem(context, 0, IconImage.eShopIcon),
            buildNavItem(context, 1, IconImage.exchangeIcon),
            buildNavItem(context, 2, IconImage.globIcon, iconSize: 80.0),
            buildNavItem(context, 3, IconImage.launchIcon),
            buildNavItem(context, 4, IconImage.wallet),
          ],
        ),
      ),
    );
  }

  //crypto list UI
  Widget buildCryptoListViewBody(context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p20, right: AppPadding.p20, top: AppPadding.p12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildTopCryptoTitleRow(),
            buildBannerImage(),
            getViewAllRow(),
            getCryptoList(),
          ],
        ),
      ),
    );
  }

  StreamBuilder<List<Crypto>> getCryptoList() {
    return StreamBuilder<List<Crypto>>(
      stream: viewModel.cryptoStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text(AppStrings.errorFetching));
        } else if (snapshot.hasData) {
          List<Crypto> cryptoList = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cryptoList.length,
            itemBuilder: (context, index) {
              Crypto crypto = cryptoList[index];
              // viewModel.fetchCryptoLogo(crypto.id);
              String changeSymbol =
                  crypto.quote.usd.percentChange24h >= 0 ? '+' : '';
              return SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(crypto.symbol,
                                    style: getSemiBoldStyle(
                                        color: ColorManager.black)),
                                Text(crypto.name,
                                    style: getRegularStyle(
                                        color: ColorManager.grey))
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Image.asset(
                              crypto.quote.usd.percentChange24h >= 0
                                  ? ImageAsset.greenGraph
                                  : ImageAsset.redGraph,
                              width: 40,
                            ),
                            const Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(crypto.quote.usd.price.toStringAsFixed(2)),
                                Text(
                                  '$changeSymbol${crypto.quote.usd.percentChange24h.toStringAsFixed(2)}%',
                                  style: TextStyle(
                                    color:
                                        crypto.quote.usd.percentChange24h >= 0
                                            ? Colors.green
                                            : Colors.red,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text(AppStrings.noData));
        }
      },
    );
  }

  void _showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(AppStrings.sortBy),
          content: Column(
            children: [
              getListAlertListTile(
                context: context,
                title:AppStrings.marketCap,
                onTap: () {
                  viewModel.sortByMarketCap();
                  Navigator.of(context).pop();
                },
              ),
              getListAlertListTile(
                title:AppStrings.price,
                onTap: () {
                  viewModel.sortByPrice();
                  Navigator.of(context).pop();
                }, context: context,
              ),
              getListAlertListTile(
                context: context,
                title: AppStrings.volume24,
                onTap: () {
                  viewModel.sortByVolume24h();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }



  Widget buildNavItem(BuildContext context, int index, String icon,
      {double iconSize = 30.0}) {
    return InkWell(
      child: Image.asset(icon,
          fit: BoxFit.cover, height: iconSize, width: iconSize),
      onTap: () {
        Provider.of<MyProvider>(context, listen: false).updateIndex(index);
      },
    );
  }
}

class MyProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
