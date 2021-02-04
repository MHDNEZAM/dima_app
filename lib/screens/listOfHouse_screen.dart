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
List<HouseListData> houseList =
    new List<HouseListData>(); //new List<HouseListData>();
List<HouseListData> DefaultHouseList = new List<HouseListData>();
int housesNumber = HouseListData.houseList.length;
int DefaultHouseNumber;

class ListOfHouse extends StatefulWidget {
  static const String id = 'ListOfHouse_screen';

  @override
  _ListOfHouseState createState() => _ListOfHouseState();
}

class _ListOfHouseState extends State<ListOfHouse> {
  //AnimationController animationController;
  final ScrollController _scrollController = ScrollController();
  final houseController = TextEditingController();
  String searchText = '';
  var _controller = TextEditingController();
  //HouseListData houseData = new HouseListData();
  //Widget futureHouseListView = new Widget();

  @override
  void initState() {
    super.initState();
    getHouses();
    //getData();
    // futureHouseListView = HousesStream();
  }

  void getHouses() {
    DefaultHouseList.clear();
    _firestore.collection('houses').get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        var data = documentSnapshot.data();
        DefaultHouseList.add(HouseListData(
          imagesList: data['imagesList'],
          imagePath: data['imagePath'],
          titleTxt: data['titleTxt'],
          subTxt: data['subTxt'],
          dist: data['dist'],
          reviews: data['reviews'],
          rating: data['rating'],
          perNight: data['perNight'],
          ownerId: data['ownerId'],
          houseUid: data['houseUid'],
          haveWifi: data['haveWifi'],
          havePool: data['havePool'],
          haveTennis: data['haveTennis'],
          maxPeople: data['maxPeople'],
          bedNumber: data['bedNumber'],
          bathroomNumber: data['bathroomNumber'],
          imagePathAssets: data['imagePathAssets'],
          imagesListAssets: data['imagesListAssets'],
        ));
      });
      setState(() {
        housesNumber = DefaultHouseList.length;
        houseList = DefaultHouseList;
        DefaultHouseNumber = DefaultHouseList.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            //head bar

            // Search bar
            getSearchFilterBarUI(context),
            // Search and filter bar
            getSearchFilterResultsBarUI(context),
            getHouseViewList(houseList),

            //HousesStream(),
            // futureHouseListView,
          ],
        ),
      ),
    );
  }

  Widget getSearchFilterBarUI(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: TextField(
          controller: _controller,
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300])),
              prefixIcon: IconButton(
                icon: Icon(
                  searchText == '' ? Icons.search : Icons.clear,
                  color: Colors.grey[500],
                ),
                onPressed: () {
                  setState(() {
                    houseList = DefaultHouseList;
                    housesNumber = houseList.length;
                    searchText = '';
                  });
                  _controller.clear();
                },
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                        //todo  List<HouseListData> DefaultHouseList
                        builder: (BuildContext context) => FiltersScreen(),
                        fullscreenDialog: true),
                  );
                },
                icon: Icon(
                  Icons.filter_list,
                  color: kPrimaryColor,
                ),
              ),
              hintText: "your house name",
              focusColor: Colors.green),
          onChanged: (val) {
            searchText = val;
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
      child: Row(children: [
        Text(
          "$housesNumber Results Found",
          style:
              TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 50),
        IconButton(
            icon: DefaultHouseNumber == housesNumber
                ? Icon(Icons.clear, color: Colors.grey[100])
                : Icon(
                    Icons.clear,
                    color: Colors.redAccent[100],
                    size: 30,
                  ),
            onPressed: () {
              setState(() {
                houseList = DefaultHouseList;
                housesNumber = houseList.length;
              });
            }),
      ]),
    );
  }

  Widget getHouseViewList(List<HouseListData> houseList) {
    final List<Widget> houseListViews = <Widget>[];
    return Expanded(
      child: Container(
          child: ListView.builder(
              itemCount: houseList.length,
              itemBuilder: (context, index) {
                return HouseListView(
                  callback: () {},
                  houseData: houseList[index],
                );
              })),
    );
  }
}

/*
*
*

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
       // houseListViews
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
*/
