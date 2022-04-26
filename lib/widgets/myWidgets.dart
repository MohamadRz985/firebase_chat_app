import 'package:flutter/material.dart';

//! 1.For Title Of Pages=====================
Widget pageName(String namePage, String explane) {
  return Center(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 50),
          child: Text(
            namePage,
            style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 10),
          height: 4,
          width: 100,
          color: Colors.red,
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, top: 25),
            child: Text(
              explane,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ))
      ],
    ),
  );
}
//! 2.Making Decoration For Textfields===================

InputDecoration fieldDecoration(String hintText, IconData prefixIcon) {
  return InputDecoration(
      hintStyle: mediumBlackTextStyle(),
      prefixIcon: Icon(
        prefixIcon,
        color: Colors.red,
      ),
      hintText: hintText,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10)));
}

//! 3.BTNs============

Widget btns(String btnName, TextStyle style) {
  return Container(
      width: 300,
      height: 50,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 25),
      child: Text(btnName, style: style),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.red,
      )

      // child: MaterialButton(
      //   onPressed: () {
      //     ontapBtn();
      //   },
      //   child: Text(
      //     btnName,
      //     style: const TextStyle(
      //       color: Colors.white,
      //       fontSize: 18,
      //     ),
      //   ),
      //   color: Colors.red,
      //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      // ),
      );
}

Color mainBlueColor = const Color.fromARGB(255, 121, 190, 236);
Color mainRedColor = const Color.fromARGB(216, 223, 30, 30);

TextStyle mediumTextStyle() {
  return const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18);
}

TextStyle btnTextStyle() {
  return const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w600, fontSize: 19);
}

TextStyle largeTextStyle() {
  return const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19);
}

TextStyle textFieldInputTextStyle() {
  return const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w400, fontSize: 19);
}

TextStyle textFieldInputBlackTextStyle() {
  return const TextStyle(
      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 19);
}

TextStyle hintTextfieldStyle() {
  return const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18);
}

TextStyle mediumBlackTextStyle() {
  return const TextStyle(
      color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18);
}

TextStyle largeBlackTextStyle() {
  return const TextStyle(
      color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18);
}

Color mainCardColor = const Color.fromARGB(115, 81, 119, 243);
