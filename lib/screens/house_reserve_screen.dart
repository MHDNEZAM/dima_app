import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dima_app/components/rounded_button.dart';
import 'package:dima_app/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

final _firestore = FirebaseFirestore.instance;

class HouseReserveScreen extends StatefulWidget {
  static const String id = 'house_reserve_screen';
  final String houseUid;
  HouseReserveScreen(this.houseUid);

  @override
  _HouseReserveScreenState createState() => _HouseReserveScreenState(houseUid);
}

class _HouseReserveScreenState extends State<HouseReserveScreen> {
  final String houseUid;
  _HouseReserveScreenState(this.houseUid);
  final _auth = FirebaseAuth.instance;
  String _selectedDate;
  String _dateCount;
  String _range;
  String _rangeCount;
  List<DateTime> blackoutDates = new List<DateTime>();
  List<DateTime> selectedDates = new List<DateTime>();

  @override
  void initState() {
    _selectedDate = '';
    _dateCount = '';
    _range = '';
    _rangeCount = '';
    super.initState();
    blackoutDates.add(DateTime(2021, 02, 18));
    blackoutDates.add(DateTime(2021, 02, 21));
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    selectedDates.clear();
    for (var selected in args.value) {
      selectedDates.add(selected);
    }
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
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore
            .collection('users')
            .doc(_auth.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            //todo
            return TextField();
          }
          return Scaffold(
              body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      height: 250,
                      child: SfDateRangePicker(
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.multiple,
                        initialSelectedRange: PickerDateRange(
                            DateTime.now().subtract(const Duration(days: 4)),
                            DateTime.now().add(const Duration(days: 3))),
                        enablePastDates: false,
                        monthViewSettings: DateRangePickerMonthViewSettings(
                          blackoutDates: blackoutDates,
                        ),
                      )),
                ],
              ),
            ),
          ));
        });
  }
}
