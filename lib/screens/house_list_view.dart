import 'package:flutter/material.dart';
import 'package:dima_app/models/hotel_list_data.dart';
import 'package:dima_app/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'detailOfHouse_screen.dart';

class HouseListView extends StatelessWidget {
  const HouseListView(
      {Key key,
      this.houseData,
      //this.animationController,
      //this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final HouseListData houseData;
  //final AnimationController animationController;
  // final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => DetailOfHouse(houseData),
                  fullscreenDialog: true),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  offset: const Offset(4, 4),
                  blurRadius: 16,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 2,
                        child: Image.asset(
                          houseData.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        color: kBackgroundColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 8, bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        houseData.titleTxt,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            houseData.subTxt,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey
                                                    .withOpacity(0.8)),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.mapMarkerAlt,
                                            size: 12,
                                            color: kPrimaryColor,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${houseData.dist.toStringAsFixed(1)} km to city',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey
                                                      .withOpacity(0.8)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Row(
                                          children: <Widget>[
                                            SmoothStarRating(
                                              allowHalfRating: true,
                                              starCount: 5,
                                              rating: houseData.rating,
                                              size: 20,
                                              color: kPrimaryColor,
                                              borderColor: kPrimaryColor,
                                            ),
                                            Text(
                                              ' ${houseData.reviews} Reviews',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey
                                                      .withOpacity(0.8)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16, top: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    '\$${houseData.perNight}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    '/per night',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.withOpacity(0.8)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite_border,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
