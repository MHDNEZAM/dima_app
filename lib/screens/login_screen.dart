import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dima_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:dima_app/utilities/constants.dart';
import 'package:dima_app/utilities/firebaseAuthentication.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';
import 'properties_screen.dart';
import 'package:dima_app/components/rounded_button.dart';
import 'package:dima_app/components/already_have_an_account_acheck.dart';
import 'package:dima_app/components/rounded_input_field.dart';
import 'package:dima_app/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'test.dart';

//final _firestore = FirebaseFirestore.instance;
final _firestore = FirebaseFirestore.instance;

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: size.width * 0.35,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.03),
                    Image.asset(
                      "assets/images/loginImg.jpg",
                      height: size.height * 0.35,
                      width: size.width * 0.8,
                    ),
                    SizedBox(height: size.height * 0.03),
                    RoundedInputField(
                      key: new Key('email'),
                      hintText: "Your Email",
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    RoundedPasswordField(
                      key: new Key('password'),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    RoundedButton(
                      text: "LOGIN",
                      press: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          await Firebase.initializeApp();
                          final _auth = FirebaseAuth.instance;

                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if (user != null) {
                            firebaseAuthenticationEmail = email;

                            var collectionRef = _firestore.collection('users');
                            var doc =
                                await collectionRef.doc(user.user.uid).get();
                            if (!doc.exists) {
                              //doesn't exist
                              _firestore
                                  .collection("users")
                                  .doc(user.user.uid)
                                  .set({
                                'uid': user.user.uid,
                                'name': user.user.email.split('@')[0],
                                //'photo': 'assets/images/profile/Male.png',
                                'profileImage':
                                    'https://firebasestorage.googleapis.com/v0/b/property-6a8fc.appspot.com/o/uploads%2Fprofile%2FprofileImage.png?alt=media&token=2d073862-6fcc-451a-934f-67aac96860c9',
                                'Sex': '',
                              });
                            }

                            Navigator.pushNamed(context, HomeScreen.id);
                          } else {
                            showNormalDialog(
                                context, '', 'wrong email or password');
                          }

                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          setState(() {
                            showSpinner = false;
                          });
                          var error = e.toString();
                          print(error);
                          if (error.contains('Failed assertion') ||
                              error.contains('Given String is empty or null')) {
                            showNormalDialog(context, '',
                                'Email and Password Can not be null');
                          } else if (error.contains(']')) {
                            showNormalDialog(context, '', error.split("]")[1]);
                          } else if (error.contains(']')) {}
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      press: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                    ),
                    OrDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        /* SocalIcon(
                          iconSrc: "assets/icons/facebook.svg",
                          press: () {},
                        ),
                        SocalIcon(
                          iconSrc: "assets/icons/twitter.svg",
                          press: () {},
                        ),*/
                        SocalIcon(
                          iconSrc: "assets/icons/google-plus.svg",
                          press: () async {
                            //await signInWithGoogle();
                            signInWithGoogle().then((result) {
                              if (result != null) {
                                Navigator.pushNamed(context, HomeScreen.id);
                              }
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),
    );
  }
}

class SocalIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  const SocalIcon({
    Key key,
    this.iconSrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}

void showNormalDialog(BuildContext context, String title, String content) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: title,
    desc: content,
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
  /*showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      });*/
}

/*
Widget _signInButton(context) {
  return OutlineButton(
    splashColor: Colors.grey,
    onPressed: () {
  },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
              image: AssetImage("assets/images/google_logo.png"), height: 35.0),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Sign in with Google',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
*/
