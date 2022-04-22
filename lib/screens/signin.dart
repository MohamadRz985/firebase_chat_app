import 'package:firebase_chat_make/screens/signUp.dart';
import 'package:firebase_chat_make/widgets/myWidgets.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class SignIn extends StatefulWidget {
  // final Function? toggle;
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var userPassController = TextEditingController();
  var userEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            child: Column(
              children: [
                pageName("Login", "Login To Account"),

                //! TextFields =================
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                  child: TextFormField(
                    ////! Use  Validation here
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
                    controller: userEmailController,
                    decoration:
                        fieldDecoration("Enter Your Email ", Icons.email),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 25, 30, 0),
                  child: TextFormField(
                    ////! Use  Validation here
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

                //!CheckBox For Remember=================
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 15),
                  child: Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (bool? value) {
                          if (value == true) {
                            value == true;
                          }
                        },
                      ),
                      const Text(
                        "Remember My Account",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                //!BTNS ==================
                InkWell(
                  child: btns("Login"),
                  onTap: () {
                    print("Login Tapped");
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const ConversationPage()));
                    // print("Login Tapped");
                  },
                ),
                InkWell(
                  child: btns("Sign Up"),
                  onTap: () {
                    // print("Signup Tapped");
                    // widget.toggle!();

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUp()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
