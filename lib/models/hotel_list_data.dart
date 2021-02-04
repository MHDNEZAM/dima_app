import 'package:flutter/cupertino.dart';

class HouseListData {
  HouseListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = 180,
    this.ownerId = '',
    this.houseUid = '',
    this.haveWifi = true,
    this.havePool = true,
    this.haveTennis = true,
    this.maxPeople = 1,
    this.bedNumber = 1,
    this.bathroomNumber = 1,
    this.imagesList,
    this.imagePathAssets = '',
    this.imagesListAssets,
  });

  String houseUid;
  String ownerId;

  String imagePath;
  String imagePathAssets;
  String titleTxt;
  String subTxt;
  dynamic dist;
  dynamic rating;
  dynamic reviews;
  dynamic perNight;

  List<dynamic> imagesList;
  List<dynamic> imagesListAssets;
  bool haveWifi;
  bool havePool;
  bool haveTennis;
  dynamic maxPeople;
  dynamic bedNumber;
  dynamic bathroomNumber;

  static List<HouseListData> houseList = <HouseListData>[];
}
