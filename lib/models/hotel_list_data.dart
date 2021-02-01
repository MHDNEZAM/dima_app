import 'package:flutter/cupertino.dart';

class HotelListData {
  HotelListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = 180,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int perNight;

  static List<HotelListData> hotelList = <HotelListData>[
    HotelListData(
      imagePath: 'assets/hotel/hotel_1.png',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perNight: 180,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_2.png',
      titleTxt: 'Queen Hotel',
      subTxt: 'Wembley, London',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      perNight: 200,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_3.png',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: 60,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_4.png',
      titleTxt: 'Queen Hotel',
      subTxt: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_5.png',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      perNight: 200,
    ),
  ];
}

class HouseListData {
  HouseListData({
    this.imagesList = '',
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = 180,
    this.ownerId = '',
    this.houseUid = '',
  });

  String houseUid;
  String ownerId;
  String imagesList;
  String imagePath;
  String titleTxt;
  String subTxt;
  dynamic dist;
  dynamic rating;
  dynamic reviews;
  dynamic perNight;

  static List<HouseListData> houseList = <HouseListData>[
    HouseListData(
        imagesList:
            'assets/hotel/hotel_1.png assets/hotel/hotel_1.png assets/hotel/hotel_1.png',
        imagePath: 'assets/hotel/hotel_1.png',
        titleTxt: 'Grand Royal Hotel',
        subTxt: 'Wembley, London',
        dist: 2.0,
        reviews: 80,
        rating: 4.4,
        perNight: 180,
        ownerId: 'ZE2oKBB1xceePBTNAYM6RcO2sRM2',
        houseUid: '4FLeph63noHnY646f7HO'),
    HouseListData(
        imagesList:
            'assets/hotel/hotel_2.png assets/hotel/hotel_2.png assets/hotel/hotel_2.png',
        imagePath: 'assets/hotel/hotel_2.png',
        titleTxt: 'Queen Hotel',
        subTxt: 'Wembley, London',
        dist: 4.0,
        reviews: 74,
        rating: 4.5,
        perNight: 200,
        ownerId: 'ZE2oKBB1xceePBTNAYM6RcO2sRM2',
        houseUid: '4FLeph63noHnY646f7HO'),
    HouseListData(
      imagesList:
          'assets/hotel/hotel_3.png assets/hotel/hotel_3.png assets/hotel/hotel_3.png',
      imagePath: 'assets/hotel/hotel_3.png',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: 60,
      ownerId: 'ZE2oKBB1xceePBTNAYM6RcO2sRM2',
    ),
    HouseListData(
      imagesList:
          'assets/hotel/hotel_4.png assets/hotel/hotel_4.png assets/hotel/hotel_4.png',
      imagePath: 'assets/hotel/hotel_4.png',
      titleTxt: 'Queen Hotel',
      subTxt: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
      ownerId: 'ZE2oKBB1xceePBTNAYM6RcO2sRM2',
    ),
    HouseListData(
      imagesList:
          'assets/hotel/hotel_5.png assets/hotel/hotel_5.png assets/hotel/hotel_5.png',
      imagePath: 'assets/hotel/hotel_5.png',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      perNight: 200,
      ownerId: 'ZE2oKBB1xceePBTNAYM6RcO2sRM2',
    ),
  ];
}
