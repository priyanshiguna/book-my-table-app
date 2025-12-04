import 'package:book_my_table_app/data/model/common/enum_model.dart';
import 'package:book_my_table_app/view/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../exports.dart';

enum BottombarTab {
  mainline,
  sme,
  history,
  news;

  static Map<BottombarTab, DropdownEnumData> data = {
    BottombarTab.mainline: DropdownEnumData(id: 1, slug: 'home', label: () => "Home", selectedImage: AppAssets.homeSelectedIcon, unselectImage: AppAssets.homeIcon),
    BottombarTab.sme: DropdownEnumData(id: 2, slug: 'discover', label: () => "Discover", selectedImage: AppAssets.discoverSelectedIcon, unselectImage: AppAssets.discoverIcon),
    BottombarTab.history: DropdownEnumData(id: 3, slug: 'wishlist', label: () => "Wishlist", selectedImage: AppAssets.wishlistSelectedIcon, unselectImage: AppAssets.wishlistIcon),
    BottombarTab.news: DropdownEnumData(id: 4, slug: 'profile', label: () => "Profile", selectedImage: AppAssets.profileSelectedIcon, unselectImage: AppAssets.profileBottomBarIcon),
  };

  int get id => data[this]!.id;

  String get label => data[this]!.label();

  String get slug => data[this]!.slug;

  String get selectedImage => data[this]!.selectedImage;

  String get unselectImage => data[this]!.unselectImage;

  static BottombarTab fromId(int id) => BottombarTab.values.firstWhere((e) => e.id == id);

  static Widget getBodyWidget(BottombarTab bottombarTab) => SizedBox(
    key: ValueKey<BottombarTab>(bottombarTab),
    child: switch (bottombarTab) {
      BottombarTab.mainline => HomeScreen(),
      BottombarTab.sme => HomeScreen(),
      BottombarTab.history => HomeScreen(),
      BottombarTab.news => HomeScreen(),
    },
  );
}
