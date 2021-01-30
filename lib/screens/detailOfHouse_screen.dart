import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dima_app/utilities/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/hotel_list_data.dart';

class DetailOfHouse extends StatefulWidget {
  static const String id = 'DetailOfHouse_screen';
  final HouseListData houseObject; //imag index
  DetailOfHouse(this.houseObject);

  @override
  _DetailOfHouseState createState() => _DetailOfHouseState(houseObject);
}

class _DetailOfHouseState extends State<DetailOfHouse> {
  final List<Widget> houseListImages = <Widget>[];
  HouseListData houseObject;
  _DetailOfHouseState(this.houseObject); //constructor
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 330,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: 330,
                  child:
                      imageSliderUI(), /*Image.asset(
                        //Todo change image link
                        "${houseObject.imagePath}", //${index + 1}
                        fit: BoxFit.cover,
                      ),*/
                ),
                Positioned(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: kPrimaryColor),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  top: 32,
                  left: 32,
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                //column for whole container
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 32, top: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: media.size.width - 64 - 48,
                              child: Text(
                                //Todo change text description
                                "Abc Tower, 3 Bed Rooms, Luxury Apartement",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            //todo change text
                            Text("Karachi, Bahria Town, A123-4",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                                overflow: TextOverflow.ellipsis),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              //todo change price
                              "3000Rs /day",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.navigation),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 32, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.people,
                              size: 12,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              //todo change text
                              "5 people",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.local_offer,
                              size: 12,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              //todo change text
                              "2 Beds",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.airline_seat_legroom_reduced,
                              size: 12,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              //todo change
                              "2 Bathrooms",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 32),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: ClipRRect(
                            child: Image.asset(
                              //todo change
                              "assets/user.jpg",
                              fit: BoxFit.contain,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                //todo change
                                "Maaz Aftab",
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Owner",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            "Chat",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          onPressed: () {},
                          color: kPrimaryColor,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(left: 32, right: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Features",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.wifi,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Wifi",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.local_offer,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Bed",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.videogame_asset,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "T. Tennis",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.wifi,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Wifi",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.local_offer,
                                  color: kPrimaryColor,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Bed",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.videogame_asset,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "T. Tennis",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.wifi,
                                  color: kPrimaryColor,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Wifi",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            /*  Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.local_offer,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Bed",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.videogame_asset,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "T. Tennis",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),*/
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget imageSliderUI() {
    var img = houseObject.imagesList.split(' ');

    for (int i = 0; i < img.length; i++) {
      houseListImages.add(Image.asset(
        //Todo change image link
        "${img[i]}", //${index + 1}
        fit: BoxFit.cover,
      ));
    }
    return CarouselSlider(
      items: houseListImages,

      //Slider Container properties
      options: CarouselOptions(
        //height: 200.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,

        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
    );
  }
}
