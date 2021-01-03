import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:dima_app/utilities/constants.dart';
import 'package:dima_app/utilities/firebaseAuthentication.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';
import 'properties_screen.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:dima_app/components/rounded_button.dart';
import 'package:dima_app/components/already_have_an_account_acheck.dart';
import 'package:dima_app/components/rounded_input_field.dart';
import 'package:dima_app/components/rounded_password_field.dart';

import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //final _auth = FirebaseAuth.instance;
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
          height: size.height,
          width: double.infinity,
          // Here i can use size.width but use double.infinity because both work as a same
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/signup_top.png",
                  width: size.width * 0.35,
                ),
              ),
              /* Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: size.width * 0.25,
              ),
            ),*/
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "SIGNUP",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SvgPicture.asset(
                      "assets/icons/signup.svg",
                      height: size.height * 0.35,
                    ),
                    RoundedInputField(
                      hintText: "Your Email",
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    RoundedPasswordField(
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    RoundedButton(
                      text: "SIGNUP",
                      press: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          await Firebase.initializeApp();
                          final _auth = FirebaseAuth.instance;

                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            firebaseAuthenticationEmail = email;
                            Navigator.pushNamed(context, PropertiesScreen.id);
                          }

                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          setState(() {
                            showSpinner = false;
                          });
                          showNormalDialog(context, '', e.toString());
                          print(e);
                        }
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                    ),
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

void showNormalDialog(BuildContext context, String title, String content) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      });
}
