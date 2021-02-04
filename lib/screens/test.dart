import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dima_app/utilities/constants.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
String baseFolder =
    'https://firebasestorage.googleapis.com/v0/b/property-6a8fc.appspot.com/o/uploads%2Fhouses%2F';
String baseAssestFolder = 'assets/images/houses/';
List<String> imagesList = new List<String>();
List<String> imagesListAssets = new List<String>();
bool haveWifi;
bool havePool;
bool haveTennis;
int maxPeople;
int bedNumber;
int bathroomNumber;
String imagePath;
String titleTxt;
String subTxt;
double dist;
double reviews;
double rating;
double perNight;
String ownerId;
String houseUid;
String imagePathAssets;

class AddHousesTOFirebaseDatabase extends StatelessWidget {
  Widget build(BuildContext context) {
    // First house
    print('Start Adding');
    var newDocRef1 = _firestore.collection('houses').doc();
    imagesList.clear();
    imagesList.add(baseFolder + '1%2F0.jpg?alt=media');
    imagesList.add(baseFolder + '1%2F1.jpg?alt=media');
    imagesList.add(baseFolder + '1%2F2.jpg?alt=media');

    haveWifi = true;
    havePool = true;
    haveTennis = true;
    maxPeople = 8;
    bedNumber = 5;
    bathroomNumber = 3;

    imagePath = baseFolder + '1%2F0.jpg?alt=media';
    titleTxt = 'Newland Cottage';
    subTxt = 'Damascus, Syria';
    dist = 2.0;
    reviews = 80;
    rating = 4.4;
    perNight = 180;
    ownerId = 'ZE2oKBB1xceePBTNAYM6RcO2sRM2';
    houseUid = newDocRef1.id;
    newDocRef1.set({
      'imagesList': imagesList,
      'haveWifi': haveWifi,
      'havePool': havePool,
      'haveTennis': haveTennis,
      'maxPeople': maxPeople,
      'bedNumber': bedNumber,
      'bathroomNumber': bathroomNumber,
      'imagePath': imagePath,
      'titleTxt': titleTxt,
      'subTxt': subTxt,
      'dist': dist,
      'reviews': reviews,
      'rating': rating,
      'perNight': perNight,
      'ownerId': ownerId,
      'houseUid': houseUid,
    });
    // Second house
    var newDocRef2 = _firestore.collection('houses').doc();
    imagesList.clear();
    imagesList.add(baseFolder + '2%2F0.jpg?alt=media');
    imagesList.add(baseFolder + '2%2F1.jpg?alt=media');
    imagesList.add(baseFolder + '2%2F2.jpg?alt=media');
    imagesList.add(baseFolder + '2%2F3.jpg?alt=media');

    haveWifi = true;
    havePool = true;
    haveTennis = true;
    maxPeople = 8;
    bedNumber = 5;
    bathroomNumber = 2;

    imagePath = baseFolder + '1%2F0.jpg?alt=media';
    titleTxt = 'Sunnyside';
    subTxt = 'Damascus, Syria';
    dist = 4.0;
    reviews = 74;
    rating = 4.6;
    perNight = 200;
    ownerId = 'ZE2oKBB1xceePBTNAYM6RcO2sRM2';
    houseUid = newDocRef2.id;
    newDocRef2.set({
      'imagesList': imagesList,
      'haveWifi': haveWifi,
      'havePool': havePool,
      'haveTennis': haveTennis,
      'maxPeople': maxPeople,
      'bedNumber': bedNumber,
      'bathroomNumber': bathroomNumber,
      'imagePath': imagePath,
      'titleTxt': titleTxt,
      'subTxt': subTxt,
      'dist': dist,
      'reviews': reviews,
      'rating': rating,
      'perNight': perNight,
      'ownerId': ownerId,
      'houseUid': houseUid,
    });
    // Third house
    var newDocRef3 = _firestore.collection('houses').doc();
    imagesList.clear();
    imagesList.add(baseFolder + '3%2F0.jpg?alt=media');
    imagesList.add(baseFolder + '3%2F1.jpg?alt=media');
    imagesList.add(baseFolder + '3%2F2.jpg?alt=media');
    haveWifi = true;
    havePool = true;
    haveTennis = true;
    maxPeople = 10;
    bedNumber = 6;
    bathroomNumber = 3;

    imagePath = baseFolder + '1%2F0.jpg?alt=media';
    titleTxt = 'The Lodge';
    subTxt = 'Damascus, Syria';
    dist = 3.0;
    reviews = 62;
    rating = 4.0;
    perNight = 60;
    ownerId = 'ZE2oKBB1xceePBTNAYM6RcO2sRM2';
    houseUid = newDocRef3.id;
    newDocRef3.set({
      'imagesList': imagesList,
      'haveWifi': haveWifi,
      'havePool': havePool,
      'haveTennis': haveTennis,
      'maxPeople': maxPeople,
      'bedNumber': bedNumber,
      'bathroomNumber': bathroomNumber,
      'imagePath': imagePath,
      'titleTxt': titleTxt,
      'subTxt': subTxt,
      'dist': dist,
      'reviews': reviews,
      'rating': rating,
      'perNight': perNight,
      'ownerId': ownerId,
      'houseUid': houseUid,
    });
    // Fourth house
    var newDocRef4 = _firestore.collection('houses').doc();
    imagesList.clear();
    imagesList.add(baseFolder + '4%2F0.jpg?alt=media');
    imagesList.add(baseFolder + '4%2F1.jpg?alt=media');
    imagesList.add(baseFolder + '4%2F2.jpg?alt=media');
    imagesList.add(baseFolder + '4%2F3.jpg?alt=media');
    haveWifi = true;
    havePool = true;
    haveTennis = true;
    maxPeople = 4;
    bedNumber = 2;
    bathroomNumber = 1;

    imagePath = baseFolder + '1%2F0.jpg?alt=media';
    titleTxt = 'The Laurels';
    subTxt = 'Damascus, Syria';
    dist = 7.0;
    reviews = 90;
    rating = 4.4;
    perNight = 170;
    ownerId = 'ZE2oKBB1xceePBTNAYM6RcO2sRM2';
    houseUid = newDocRef4.id;
    newDocRef4.set({
      'imagesList': imagesList,
      'haveWifi': haveWifi,
      'havePool': havePool,
      'haveTennis': haveTennis,
      'maxPeople': maxPeople,
      'bedNumber': bedNumber,
      'bathroomNumber': bathroomNumber,
      'imagePath': imagePath,
      'titleTxt': titleTxt,
      'subTxt': subTxt,
      'dist': dist,
      'reviews': reviews,
      'rating': rating,
      'perNight': perNight,
      'ownerId': ownerId,
      'houseUid': houseUid,
    });
    // Five house
    var newDocRef5 = _firestore.collection('houses').doc();
    imagesList.clear();
    imagesList.add(baseFolder + '5%2F0.jpg?alt=media');
    imagesList.add(baseFolder + '5%2F1.jpg?alt=media');
    imagesList.add(baseFolder + '5%2F2.jpg?alt=media');
    haveWifi = true;
    havePool = true;
    haveTennis = true;
    maxPeople = 12;
    bedNumber = 8;
    bathroomNumber = 4;

    imagePath = baseFolder + '1%2F0.jpg?alt=media';
    titleTxt = 'The Coach House';
    subTxt = 'Damascus, Syria';
    dist = 2.7;
    reviews = 240;
    rating = 4.9;
    perNight = 300;
    ownerId = 'ZE2oKBB1xceePBTNAYM6RcO2sRM2';
    houseUid = newDocRef5.id;
    newDocRef5.set({
      'imagesList': imagesList,
      'haveWifi': haveWifi,
      'havePool': havePool,
      'haveTennis': haveTennis,
      'maxPeople': maxPeople,
      'bedNumber': bedNumber,
      'bathroomNumber': bathroomNumber,
      'imagePath': imagePath,
      'titleTxt': titleTxt,
      'subTxt': subTxt,
      'dist': dist,
      'reviews': reviews,
      'rating': rating,
      'perNight': perNight,
      'ownerId': ownerId,
      'houseUid': houseUid,
    });
    // six house
    var newDocRef6 = _firestore.collection('houses').doc();
    imagesList.clear();
    imagesList.add(baseFolder + '6%2F0.jpg?alt=media');
    imagesList.add(baseFolder + '6%2F1.jpg?alt=media');
    haveWifi = true;
    havePool = true;
    haveTennis = true;
    maxPeople = 9;
    bedNumber = 4;
    bathroomNumber = 2;
    imagePath = baseFolder + '1%2F0.jpg?alt=media';
    titleTxt = 'Primrose Cottage';
    subTxt = 'Damascus, Syria';
    dist = 7.5;
    reviews = 25;
    rating = 3.3;
    perNight = 50;
    ownerId = 'ZE2oKBB1xceePBTNAYM6RcO2sRM2';
    houseUid = newDocRef6.id;

    newDocRef6.set({
      'imagesList': imagesList,
      'haveWifi': haveWifi,
      'havePool': havePool,
      'haveTennis': haveTennis,
      'maxPeople': maxPeople,
      'bedNumber': bedNumber,
      'bathroomNumber': bathroomNumber,
      'imagePath': imagePath,
      'titleTxt': titleTxt,
      'subTxt': subTxt,
      'dist': dist,
      'reviews': reviews,
      'rating': rating,
      'perNight': perNight,
      'ownerId': ownerId,
      'houseUid': houseUid,
    });

    // seven house
    var newDocRef7 = _firestore.collection('houses').doc();
    imagesList.clear();
    imagesList.add(baseFolder + '7%2F0.jpg?alt=media');
    imagesList.add(baseFolder + '7%2F1.jpg?alt=media');
    imagesList.add(baseFolder + '7%2F2.jpg?alt=media');
    haveWifi = true;
    havePool = true;
    haveTennis = true;
    maxPeople = 4;
    bedNumber = 2;
    bathroomNumber = 1;
    imagePath = baseFolder + '1%2F0.jpg?alt=media';
    titleTxt = 'The Gables';
    subTxt = 'Aleppo, Syria';
    dist = 3.0;
    reviews = 380;
    rating = 4.2;
    perNight = 210;
    ownerId = 'ZE2oKBB1xceePBTNAYM6RcO2sRM2';
    houseUid = newDocRef7.id;

    newDocRef7.set({
      'imagesList': imagesList,
      'haveWifi': haveWifi,
      'havePool': havePool,
      'haveTennis': haveTennis,
      'maxPeople': maxPeople,
      'bedNumber': bedNumber,
      'bathroomNumber': bathroomNumber,
      'imagePath': imagePath,
      'titleTxt': titleTxt,
      'subTxt': subTxt,
      'dist': dist,
      'reviews': reviews,
      'rating': rating,
      'perNight': perNight,
      'ownerId': ownerId,
      'houseUid': houseUid,
    });
    // eight house
    var newDocRef8 = _firestore.collection('houses').doc();
    imagesList.clear();
    imagesList.add(baseFolder + '8%2F0.jpg?alt=media');
    imagesList.add(baseFolder + '8%2F1.jpg?alt=media');
    haveWifi = true;
    havePool = true;
    haveTennis = true;
    maxPeople = 10;
    bedNumber = 7;
    bathroomNumber = 3;
    imagePath = baseFolder + '1%2F0.jpg?alt=media';
    titleTxt = 'The Granary';
    subTxt = 'Aleppo, Syria';
    dist = 1.5;
    reviews = 25;
    rating = 4.3;
    perNight = 85;
    ownerId = 'ZE2oKBB1xceePBTNAYM6RcO2sRM2';
    houseUid = newDocRef8.id;

    newDocRef8.set({
      'imagesList': imagesList,
      'haveWifi': haveWifi,
      'havePool': havePool,
      'haveTennis': haveTennis,
      'maxPeople': maxPeople,
      'bedNumber': bedNumber,
      'bathroomNumber': bathroomNumber,
      'imagePath': imagePath,
      'titleTxt': titleTxt,
      'subTxt': subTxt,
      'dist': dist,
      'reviews': reviews,
      'rating': rating,
      'perNight': perNight,
      'ownerId': ownerId,
      'houseUid': houseUid,
    });
    return Container();
  }
}
