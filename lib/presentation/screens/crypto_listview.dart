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
  // Instance of the ViewModel responsible for managing the state of the view
  final CryptoViewModel viewModel = CryptoViewModel(CryptoRepository(ApiServices()));

  // Constructor for the CryptoListView
  CryptoListView({Key? key}) : super(key: key);

  // Build method to create the UI for the CryptoListView
  @override
  Widget build(BuildContext context) {
    // Fetch cryptocurrency data when the view is built
    viewModel.fetchCryptoData();

    // Scaffold widget representing the overall structure of the screen
    return Scaffold(
      // AppBar at the top of the screen
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            // Header row with title and search/filter options
            buildHeaderRow(),
            const SizedBox(
              height: AppSize.s14,
            ),
            // Search and filter row with sort dialog trigger
            buildSearchAndFilterRow(context:context, onTap: () {
              _showSortDialog(context);
            }),
          ],
        ),
        toolbarHeight: 150.0,
      ),
      // Bottom navigation bar with navigation items
      bottomNavigationBar: buildBottomNavigationBar(context),
      // Body of the screen containing the main content
      body: buildCryptoListViewBody(context),
    );
  }

  // Build the bottom navigation bar
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

  // Build the main content of the CryptoListView
  Widget buildCryptoListViewBody(context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p20, right: AppPadding.p20, top: AppPadding.p12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Row displaying the title of the top cryptocurrencies
            buildTopCryptoTitleRow(),
            // Banner image section
            buildBannerImage(),
            // Row with a "View All" option
            getViewAllRow(),
            // StreamBuilder to handle the dynamic list of cryptocurrencies
            getCryptoList(),
          ],
        ),
      ),
    );
  }

  // StreamBuilder for displaying the list of cryptocurrencies
  StreamBuilder<List<Crypto>> getCryptoList() {
    return StreamBuilder<List<Crypto>>(
      stream: viewModel.cryptoStream,
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // Error state
        else if (snapshot.hasError) {
          return const Center(child: Text(AppStrings.errorFetching));
        }
        // Data available state
        else if (snapshot.hasData) {
          List<Crypto> cryptoList = snapshot.data!;
          // ListView to display each cryptocurrency item
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cryptoList.length,
            itemBuilder: (context, index) {
              Crypto crypto = cryptoList[index];
              String changeSymbol = crypto.quote.usd.percentChange24h >= 0 ? '+' : '';
              // Container representing each cryptocurrency item
              return SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // CircleAvatar with cryptocurrency logo
                      CircleAvatar(child: Image.network("https://s2.coinmarketcap.com/static/img/coins/64x64/825.png"),),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Row(
                          children: [
                            // Column with cryptocurrency symbol and name
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
                            // Image representing percentage change
                            Image.asset(
                              crypto.quote.usd.percentChange24h >= 0
                                  ? ImageAsset.greenGraph
                                  : ImageAsset.redGraph,
                              width: 40,
                            ),
                            const Spacer(),
                            // Column with cryptocurrency price and percentage change
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
        }
        // No data available state
        else {
          return const Center(child: Text(AppStrings.noData));
        }
      },
    );
  }

  // Show a dialog for sorting options
  void _showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            AppStrings.sortBy,
          ),
          contentPadding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
          content: Column(
            children: [
              // ListTile for sorting by market cap
              getListAlertListTile(
                context: context,
                title: AppStrings.marketCap,
                onTap: () {
                  viewModel.sortByMarketCap();
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 10), // Adjust the height as needed
              // ListTile for sorting by price
              getListAlertListTile(
                title: AppStrings.price,
                onTap: () {
                  viewModel.sortByPrice();
                  Navigator.of(context).pop();
                },
                context: context,
              ),
              SizedBox(height: 10), // Adjust the height as needed
              // ListTile for sorting by 24h volume
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
          backgroundColor: Colors.white, // Set your desired background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Set your desired border radius
          ),
        );
      },
    );
  }

  // Build a navigation item with an icon
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
