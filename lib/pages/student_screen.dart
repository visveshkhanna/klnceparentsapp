import 'package:flutter/material.dart';
import 'package:klnceparentsapp/pages/website_check.dart';

class StudentScreen extends StatefulWidget {
  final student;
  const StudentScreen({super.key, required this.student});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
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
        actions: [
          IconButton(onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => WebsiteCheckScreen(),
                transitionDuration: Duration(milliseconds: 150),
                transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
              ),
            );
          }, icon: Icon(Icons.logout, color: Colors.black, size: 30,), tooltip: "logout",)
        ],
      ),
      body: SingleChildScrollView(
          //physics: BouncingScrollPhysics(),
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${widget.student["name"]}",
              style: TextStyle(fontSize: 25, color: Colors.black54),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Roll No: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Text("${widget.student["rollNo"]}", style: TextStyle(fontSize: 18),)
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("University Roll No: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Text("${widget.student["universityRegisterNo"]}", style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Department: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Text("${widget.student["department"]}", style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      )),
    );
  }
}
