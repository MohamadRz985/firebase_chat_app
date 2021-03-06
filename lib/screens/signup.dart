import 'dart:async';

import 'package:firebase_chat_make/helper/sphelper.dart';
import 'package:firebase_chat_make/screens/chatRoom.dart';
import 'package:firebase_chat_make/services/auth.dart';
import 'package:firebase_chat_make/services/database.dart';
import 'package:firebase_chat_make/widgets/myWidgets.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class SignUp extends StatefulWidget {
  final Function? toggle;
  const SignUp({Key? key, this.toggle}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  DatabaseMethods dbm = DatabaseMethods();
  AuthMethods auth = AuthMethods();
  var userNameController = TextEditingController();
  var userEmailController = TextEditingController();
  var userPassController = TextEditingController();
  var userPhoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  //!Method for cheking validation of form for signUp  =========
  signMeUp() {
    if (formKey.currentState!.validate()) {
      auth
          .signUpWithEmail(userEmailController.text, userPassController.text)
          .then((value) {
        // print("the value is :$value");
        Map<String, String> userInfoMap = {
          "userName": userNameController.text,
          "userEmail": userEmailController.text,
          "userPassword": userPassController.text,
          "userPhoneNumber": userPhoneController.text
        };
        SPHelper.saveUserEmailSharedPref(userEmailController.text);
        SPHelper.saveUserNameSharedPref(userNameController.text);
        //SPHelper.saveUserPassSharedPref(userPassController.text);

        setState(() {
          isLoading = true;
        });
        dbm.uploadUserData(userInfoMap);
        SPHelper.saveUserLoggedInSharedPref(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const ChatRoom()));
      });
    }
  }

  bool obsucureTap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlueColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SafeArea(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    pageName("Sign Up", "Create New Account"),

                    //! TextFields=====
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                      child: TextFormField(
                        style: largeBlackTextStyle(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter User Name";
                          }
                          if (value.length < 4) {
                            return "Please Enter Valid User Name";
                          }
                          if (!isAlpha(value)) {
                            return "Please Enter Valid User Name";
                          } else {
                            return null;
                          }
                        },
                        controller: userNameController,
                        decoration:
                            fieldDecoration("Enter Your Name ", Icons.person),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: TextFormField(
                        style: largeBlackTextStyle(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Number";
                          }
                          if (!isNumeric(value)) {
                            return "Please Enter Valid Phone Number";
                          } else {
                            return null;
                          }
                        },
                        controller: userPhoneController,
                        decoration: fieldDecoration(
                            "Enter Phone Number ", Icons.mobile_friendly),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: TextFormField(
                        style: largeBlackTextStyle(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Entere Email";
                          }
                          if (!isEmail(value)) {
                            return " Please Enter Valid Email";
                          } else {
                            return null;
                          }
                        },
                        controller: userEmailController,
                        decoration:
                            fieldDecoration("Enter Your Email ", Icons.email),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: TextFormField(
                        obscureText: true,
                        style: largeBlackTextStyle(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Password";
                          }
                          if (value.length < 6) {
                            return "Password Must be at Least 6 Character";
                          } else {
                            return null;
                          }
                        },
                        controller: userPassController,
                        decoration: fieldDecoration("Password ", Icons.lock),
                      ),
                    ),

                    //!Already Have An Account==========
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: InkWell(
                        child: Text('Already Have An Account ?',
                            style: mediumBlackTextStyle()
                            // TextStyle(
                            //     fontSize: 15,
                            //     color: Colors.blue,
                            //     fontWeight: FontWeight.bold),
                            ),
                        onTap: () {
                          widget.toggle!();
                        },
                      ),
                    ),

                    //! BTNS===========
                    InkWell(
                      child: btns("Submit", btnTextStyle()),
                      onTap: () {
                        signMeUp();
                      },
                    )
                  ],
                ),
              ),
            )),
    );
  }
}
