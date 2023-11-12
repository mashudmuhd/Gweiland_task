import 'package:flutter/material.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';
Widget getListAlertListTile(
    {required BuildContext context, required title, required onTap}) {
  return ListTile(
      title: Text(title),
      onTap: onTap
  );
}

Widget getViewAllRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Top Cryptocurrencies",
        style: getSemiBoldStyle(color: ColorManager.black),
      ),
      Text(
        "View all",
        style: getRegularStyle(color: ColorManager.grey),
      ),
    ],
  );
}


Widget buildHeaderRow() {
  return Row(
    children: [
      Text(AppStrings.mainScreenTitle,
          style:
          getBoldStyle(color: ColorManager.black, fontSize: AppSize.s20)),
      const Spacer(),
      buildNotificationAndSettingsIcons(),
    ],
  );
}

Widget buildNotificationAndSettingsIcons() {
  return Row(
    children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -1,
            top: -10,
            child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.yellow),
                height: 15,
                width: 10),
          ),
          Icon(
            Icons.notifications_outlined,
            size: AppSize.s20,
            color: ColorManager.black,
          ),
        ],
      ),
      const SizedBox(
        width: AppSize.s8,
      ),
      Icon(Icons.settings_outlined,
          size: AppSize.s20, color: ColorManager.black),
    ],
  );
}
Widget buildSearchTextField() {
  return SizedBox(
    width: 220,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.grey[200],
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: AppStrings.searchCrypto,
            hintStyle: TextStyle(color: Colors.grey),
            icon: Icon(Icons.search, color: Colors.grey),
          ),
        ),
      ),
    ),
  );
}

Widget buildFilterContainer({required context,required onTap}) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(width: AppSize.s1, color: Colors.grey),
        borderRadius: BorderRadius.circular(30)),
    child: Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p24, vertical: AppPadding.p2),
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.sort,
                color: ColorManager.black,
              ),
              onPressed:onTap
          ),
          Text(
            "Filter",
            style: getRegularStyle(color: ColorManager.black),
          ),
        ],
      ),
    ),
  );
}


Widget buildSearchAndFilterRow({required context,required onTap}) {
  return Row(
    children: [
      Expanded(
        child: buildSearchTextField(),
      ),
      const SizedBox(width: AppSize.s8),
      buildFilterContainer(context:context,onTap:  onTap,),
    ],
  );
}



Widget buildBannerImage() {
  return Column(
    children: [
      const SizedBox(height: AppSize.s20),
      Image.asset(ImageAsset.bannerImage,
          width: double.maxFinite, fit: BoxFit.cover),
      const SizedBox(height: AppSize.s18),
    ],
  );
}


Widget buildTopCryptoTitleRow() {
  return Row(
    children: [
      Text(AppStrings.cryptoCurrency,
          style:
          getBoldStyle(color: ColorManager.black, fontSize: AppSize.s20)),
      const SizedBox(width: AppSize.s20),
      Text(AppStrings.nft,
          style:
          getBoldStyle(color: ColorManager.grey, fontSize: AppSize.s20)),
    ],
  );
}


