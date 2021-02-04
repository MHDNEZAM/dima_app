import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dima_app/components/rounded_button.dart';
import 'package:dima_app/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:dima_app/models/hotel_list_data.dart';

final _firestore = FirebaseFirestore.instance;

class HouseReserveScreen extends StatefulWidget {
  static const String id = 'house_reserve_screen';

  final HouseListData houseObject;
  HouseReserveScreen(this.houseObject);

  @override
  _HouseReserveScreenState createState() =>
      _HouseReserveScreenState(houseObject);
}

class _HouseReserveScreenState extends State<HouseReserveScreen> {
  final HouseListData houseObject;
  _HouseReserveScreenState(this.houseObject);
  Razorpay razorpay = new Razorpay();
  final _auth = FirebaseAuth.instance;

  String _selectedDate;
  int _dateCount = 0;
  String _range;
  String _rangeCount;
  List<DateTime> blackoutDates = new List<DateTime>();
  List<DateTime> selectedDates = new List<DateTime>();
  //List<DateTime> reservedDates = new List<DateTime>();
  bool showSpinner = false;

  @override
  void initState() {
    _selectedDate = '';
    _dateCount = 0;
    _range = '';
    _rangeCount = '';
    super.initState();
    setState(() {});

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("Success");

    _firestore.collection("reservedDate").doc(houseObject.houseUid).set({
      'houseUID': houseObject.houseUid,
      'time': selectedDates,
    });

    _firestore.collection("reserveHouses").doc().set({
      'set_time': DateTime.now(),
      'userUid': _auth.currentUser.uid,
      'houseUid': houseObject.houseUid,
      // 'price': houseObject.perNight.toString(),
      'data_count': _dateCount,
      'period': selectedDates,
    });

    setState(() {
      showSpinner = false;
      selectedDates.clear();
      _dateCount = selectedDates.length;
    });
    successAlert();
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    print("Failure");
    setState(() {
      showSpinner = false;
    });
    failAlert();
  }

  void failAlert() {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.red,
      ),
      alertAlignment: Alignment.center,
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.error,
      title: "Payment Failure",
      desc: "There were problem in your payment pleas try again.",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.redAccent,
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  void successAlert() {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: kPrimaryColor,
      ),
      alertAlignment: Alignment.center,
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: "Payment Was Made Succesfully",
      desc: "Your selected house has been reserved for selected dayes",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: kPrimaryColor,
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  void handlerExternalWallet(ExternalWalletResponse response) {}

  void openCheckout() {
    print('start payment');
    var options = {
      "key": "rzp_test_Sn7ayjgOB2HlRx",
      "amount": houseObject.perNight * _dateCount * 100,
      "currency": "USD",
      "name": houseObject.titleTxt,
      "description": "Payment for renting: $_dateCount days ",
      "prefill": {
        "contact": "00393516466699",
        "email": "barekalnoor@gmail.com"
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    selectedDates.clear();

    for (var selected in args.value) {
      selectedDates.add(selected);
    }
    _dateCount = selectedDates.length;
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
        _selectedDate = args.value;
      } else if (args.value is List<DateTime>) {
        // _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Reserve House',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore
            .collection('reservedDate')
            .doc(houseObject.houseUid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            //todo
            return Container();
          }
          //blackoutDates.clear();

          if (snapshot.data.data() != null) {
            var time = snapshot.data.data()['time'];
            for (var reservedTimeHouses in time) {
              blackoutDates.add(DateTime.fromMillisecondsSinceEpoch(
                  reservedTimeHouses.seconds * 1000));
            }
          }
          return Scaffold(
              body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    getAppBarUI(),
                    Container(
                        height: 250,
                        child: SfDateRangePicker(
                          onSelectionChanged: _onSelectionChanged,
                          selectionColor: kPrimaryColor,
                          selectionMode: DateRangePickerSelectionMode.multiple,
                          initialSelectedRange: PickerDateRange(
                              DateTime.now().subtract(const Duration(days: 4)),
                              DateTime.now().add(const Duration(days: 3))),
                          enablePastDates: false,
                          monthViewSettings: DateRangePickerMonthViewSettings(
                            blackoutDates: blackoutDates,
                          ),
                          monthCellStyle: DateRangePickerMonthCellStyle(
                            todayCellDecoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                border: Border.all(
                                    color: kPrimaryLightColor, width: 2),
                                shape: BoxShape.circle),
                            blackoutDatesDecoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(
                                    color: const Color(0xFFF44436), width: 1),
                                shape: BoxShape.circle),
                            weekendDatesDecoration: BoxDecoration(
                                color: const Color(0xFFDFDFDF),
                                border: Border.all(
                                    color: const Color(0xFFB6B6B6), width: 1),
                                shape: BoxShape.circle),
                            specialDatesDecoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(
                                    color: const Color(0xFF2B732F), width: 1),
                                shape: BoxShape.circle),
                            blackoutDateTextStyle: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.lineThrough),
                            specialDatesTextStyle:
                                const TextStyle(color: Colors.white),
                          ),
                        )),
                    RaisedButton(
                      onPressed: () {
                        if (_dateCount == 0) {
                          Alert(
                                  context: context,
                                  title: "No date selected",
                                  desc:
                                      "Select at least on date before you can reserve")
                              .show();
                        } else {
                          setState(() {
                            showSpinner = true;
                            openCheckout();
                          });
                        }
                      },
                      child: Text(
                        'Reserve',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
        });
  }
}
