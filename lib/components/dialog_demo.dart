/*
showDialog(
context: context,
builder: (BuildContext context) {
return Dialog(
shape: RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(20.0)), //this right here
child: Container(
height: 200,
child: Padding(
padding: const EdgeInsets.all(12.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
TextField(
decoration: InputDecoration(
border: InputBorder.none,
hintText: 'What do you want to remember?'),
),
SizedBox(
width: 320.0,
child: RaisedButton(
onPressed: () {},
child: Text(
"Save",
style: TextStyle(color: Colors.white),
),
color: const Color(0xFF1BC0C5),
),
)
],
),
),
),
);
});*/

/*
showGeneralDialog(
context: context,
barrierDismissible: true,
barrierLabel: MaterialLocalizations.of(context)
.modalBarrierDismissLabel,
barrierColor: Colors.black45,
transitionDuration: const Duration(milliseconds: 200),
pageBuilder: (BuildContext buildContext,
    Animation animation,
Animation secondaryAnimation) {
return Center(
child: Container(
width: MediaQuery.of(context).size.width - 10,
height: MediaQuery.of(context).size.height -  80,
padding: EdgeInsets.all(20),
color: Colors.white,
child: Column(
children: [
RaisedButton(
onPressed: () {
Navigator.of(context).pop();
},
child: Text(
"Save",
style: TextStyle(color: Colors.white),
),
color: const Color(0xFF1BC0C5),
)
],
),
),
);
});*/
