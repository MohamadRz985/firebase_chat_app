import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_make/helper/sphelper.dart';
import 'package:firebase_chat_make/screens/chatRoom.dart';
import 'package:firebase_chat_make/services/auth.dart';
import 'package:firebase_chat_make/services/database.dart';
import 'package:firebase_chat_make/widgets/myWidgets.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class SignIn extends StatefulWidget {
  final Function? toggle;
  const SignIn({Key? key, this.toggle})
      : super(
          key: key,
        );

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var userPassController = TextEditingController();
  var userEmailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthMethods auth = AuthMethods();
  DatabaseMethods dbm = DatabaseMethods();
  late QuerySnapshot snapshotUserInfo;

  //! E3 -- Make Function To help us Loggin =============
  logInFunc() {
    if (formKey.currentState!.validate()) {
      SPHelper.saveUserEmailSharedPref(userEmailController.text);
      //  SPHelper.saveUserPassSharedPref(userPassController.text);

      dbm.getUsersbyUserEmail(userEmailController.text).then((value) {
        snapshotUserInfo = value;
        SPHelper.saveUserNameSharedPref(
            snapshotUserInfo.docs[0].get("userName"));
        setState(() {
          isLoading = true;
        });
      });
      auth
          .signInWithEmail(userEmailController.text, userPassController.text)
          .then((value) {
        if (value != null) {
          SPHelper.saveUserLoggedInSharedPref(true);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ChatRoom()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlueColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                pageName("Login", "Login To Account"),

                //! TextFields =================
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                  //! Username Field ====
                  child: TextFormField(
                    style: largeBlackTextStyle(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter User Name";
                      }
                      if (value.length < 4) {
                        return "Please Enter Valid User Name";
                      }
                      if (!isEmail(value)) {
                        return "Please Enter Valid UserName";
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
                  margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                  //! Password Field =========
                  child: TextFormField(
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
                    obscureText: true,
                    decoration:
                        fieldDecoration("Enter Your Password ", Icons.lock),
                  ),
                ),

                // //!CheckBox For Remember=================
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(30, 20, 30, 15),
                //   child: Row(
                //     children: [
                //       Checkbox(
                //         value: false,
                //         onChanged: (bool? value) {
                //           if (value == true) {
                //             value == true;
                //           }
                //         },
                //       ),
                //       const Text(
                //         "Remember My Account",
                //         style: TextStyle(
                //           fontSize: 15,
                //           color: Colors.black,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 25,
                ),
                //!BTNS ==================
                InkWell(
                  child: btns("Login", btnTextStyle()),
                  onTap: () {
                    logInFunc();
                  },
                ),
                InkWell(
                    child: btns("Sign Up", btnTextStyle()),
                    onTap: () {
                      widget.toggle!();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
