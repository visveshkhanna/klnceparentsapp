import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void toast(String? val) {
  Fluttertoast.showToast(
      msg: "$val",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showAlert(String data, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        titlePadding: EdgeInsets.only(top: 15, left: 15),
        contentPadding:
            EdgeInsets.only(top: 25, bottom: 25, left: 20, right: 20),
        //actionsPadding: EdgeInsets.symmetric(vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              color: Colors.red,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'Alert',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
              ),
            )
          ],
        ),
        content: Text(
          "$data",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          textAlign: TextAlign.left,
        ),
      );
    },
  );
}
