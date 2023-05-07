import 'package:flutter/material.dart';
import 'package:klnceparentsapp/functions/api.dart';
import 'package:klnceparentsapp/pages/home_screen.dart';

import '../functions/extras.dart';

class WebsiteDownScreen extends StatefulWidget {
  const WebsiteDownScreen({Key? key}) : super(key: key);

  @override
  State<WebsiteDownScreen> createState() => _WebsiteDownScreenState();
}

class _WebsiteDownScreenState extends State<WebsiteDownScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
          Text(
            "Website Down!",
            style: TextStyle(
              fontSize: 25,
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(
            onPressed: () {
              toast("checking status!");
              checkWebsiteStatus().then((value) {
                setState(() {
                  if (value == true) {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => KLNCEParents(),
                        transitionDuration: Duration(milliseconds: 150),
                        transitionsBuilder: (_, a, __, c) =>
                            FadeTransition(opacity: a, child: c),
                      ),
                    );
                  } else {
                    toast("Website still down!");
                  }
                });
              });
            },
            child: Text("Check status"),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
          )
        ],
      )),
    );
  }
}
