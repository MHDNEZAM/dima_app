import 'dart:convert';

import 'package:dima_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:dima_app/screens/detailOfHouse_screen.dart';
import 'filters_screen.dart';
import 'package:dima_app/models/hotel_list_data.dart';

import 'house_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final _firestore = FirebaseFirestore.instance;

class ListOfHouse extends StatefulWidget {
  static const String id = 'ListOfHouse_screen';

  @override
  _ListOfHouseState createState() => _ListOfHouseState();
}

class _ListOfHouseState extends State<ListOfHouse> {
  //AnimationController animationController;
  final ScrollController _scrollController = ScrollController();
  final houseController = TextEditingController();

  List<HouseListData> houseList =
      HouseListData.houseList; //new List<HouseListData>();
  List<HouseListData> DefaultHouseList = HouseListData.houseList;
  int housesNumber = HouseListData.houseList.length;
  //HouseListData houseData = new HouseListData();
  //Widget futureHouseListView = new Widget();

  @override
  void initState() {
    super.initState();
    // futureHouseListView = HousesStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          //head bar
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      // houseList2 = houseList;
                    });
                  },
                ),
                CircleAvatar(
                  child: ClipRRect(
                    child: Image.asset(
                      "assets/user.jpg",
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          // Search bar
          getSearchFilterBarUI(context),
          // Search and filter bar
          getSearchFilterResultsBarUI(context),
          getHouseViewList(houseList),
          //HousesStream(),
          // futureHouseListView,
        ],
      ),
    );
  }

  Widget getSearchFilterBarUI(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: TextField(
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300])),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey[500],
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => FiltersScreen(),
                        fullscreenDialog: true),
                  );
                },
                icon: Icon(
                  Icons.filter_list,
                  color: kPrimaryColor,
                ),
              ),
              hintText: "Karachi, Pakistan",
              focusColor: Colors.green),
          onChanged: (val) {
            if (val == "") {
              setState(() {
                houseList = DefaultHouseList;
                housesNumber = houseList.length;
              });
            } else {
              List<HouseListData> houseList2 = new List<HouseListData>();
              for (var i = 0; i < DefaultHouseList.length; i++) {
                if (DefaultHouseList[i]
                        .titleTxt
                        .toLowerCase()
                        .contains(val.toLowerCase()) ||
                    DefaultHouseList[i]
                        .subTxt
                        .toLowerCase()
                        .contains(val.toLowerCase()))
                  houseList2.add(DefaultHouseList[i]);
                setState(() {
                  houseList = houseList2;
                  housesNumber = houseList.length;
                });
              }
            }
          }),
    );
  }

  //Widget getTimeDateUI(BuildContext context) {}
  Widget getSearchFilterResultsBarUI(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
      color: Colors.grey[100],
      child: Text(
        "$housesNumber Results Found",
        style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget getHouseViewList(List<HouseListData> houseList) {
    final List<Widget> houseListViews = <Widget>[];

    for (int i = 0; i < houseList.length; i++) {
      houseListViews.add(HouseListView(
        callback: () {},
        houseData: houseList[i],
      ));
    }
    return Expanded(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: houseListViews,
          ),
        ),
      ),
    );
  }
}

class HousesStream extends StatelessWidget {
  final List<Widget> houseListViews = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('houses').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final houses = snapshot.data.docs;
        print(houses.length);
        for (var singleHouse in houses) {
          HouseListData houseData = new HouseListData();
          houseData.imagePath = singleHouse.data()['imagePath'];

          houseData.titleTxt = singleHouse.data()['titleTxt'];
          houseData.subTxt = singleHouse.data()['subTxt'];
          houseData.dist = singleHouse.data()['dist'];
          houseData.rating = singleHouse.data()['rating'];
          houseData.reviews = singleHouse.data()['reviews'];
          houseData.perNight = singleHouse.data()['perNight'];
          houseListViews.add(HouseListView(
            callback: () {},
            houseData: houseData,
            //animation: animation,
            // animationController: animationController,
          ));
        }

        return Expanded(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: houseListViews,
              ),
            ),
          ),
        );
      },
    );
  }
}
