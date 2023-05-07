import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:klnceparentsapp/functions/api.dart';
import 'package:klnceparentsapp/functions/extras.dart';
import 'package:klnceparentsapp/pages/student_screen.dart';

class KLNCEParents extends StatefulWidget {
  const KLNCEParents({Key? key}) : super(key: key);

  @override
  State<KLNCEParents> createState() => _KLNCEParentsState();
}

class _KLNCEParentsState extends State<KLNCEParents> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();

  void _clearText() {
    _textController2.text = "";
    _textController1.text = "";
  }

  void _submit() {
    String roll_no = _textController1.text;
    String dob = _textController2.text;
    if (roll_no.length == 6) {
      DateFormat format = DateFormat("dd/MM/yyyy");
      try {
        DateTime dayOfBirthDate = format.parseStrict(dob);
        toast("Signing in");
        getStudentDetails(roll_no, dob).then((value) {
          if(value["error"] == true) {
            showAlert(value["message"], context);
          } else {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => StudentScreen(student: value["student"]),
                transitionDuration: Duration(milliseconds: 150),
                transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
              ),
            );
          }
        });
        return;
      } catch (e) {}
      showAlert("Enter valid date \n Example: 01/01/2000", context);
      return;
    }
    showAlert("No such roll no", context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController1.dispose();
    _textController2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        title: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "KLNCE",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "Parent Portal",
              style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ROLL NO
          Text(
            "Roll no",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextField(
              cursorColor: Colors.deepOrangeAccent,
              keyboardType: TextInputType.number,
              maxLines: 1,
              autocorrect: true,
              onTap: () {},
              onSubmitted: (string) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: _textController1,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(.125),
                hintText: 'Enter your child\'s roll number',
                //border: InputBorder.none,
              ),
            ),
          ),

          // DOB
          Text(
            "Date of Birth",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextField(
              cursorColor: Colors.deepOrangeAccent,
              keyboardType: TextInputType.text,
              maxLines: 1,
              autocorrect: true,
              onTap: () {},
              controller: _textController2,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(.125),
                hintText: 'Enter your child\'s dob (01/01/2000)',
                //border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(1990),
                      lastDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      confirmText: "Select",
                      cancelText: "Back",
                      helpText: "Select your child's DOB",
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData(
                            primarySwatch: Colors.deepOrange,
                            colorScheme: ColorScheme.light(
                              primary: Colors.deepOrange,
                              onPrimary: Colors.white,
                              surface: Colors.grey,
                              onSurface: Colors.black,
                            ),
                            dialogBackgroundColor: Colors.white,
                          ),
                          child: child ?? Container(),
                        );
                      },
                    ).then((value) {
                      setState(() {
                        if (value != null) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _textController2
                              .text = "${value.day < 10 ? '0${value.day}' : {
                              value.day
                            }}/${value.month < 10 ? '0${value.month}' : {value.month}}/${value.year}";
                        }
                      });
                    });
                  },
                  icon: Icon(
                    Icons.calendar_month,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _submit();
            },
            child: Text("Submit"),
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                elevation: 0,
                splashFactory: NoSplash.splashFactory,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                backgroundColor: Colors.deepOrange),
          ),
        ],
      )),
    );
  }
}
