import 'package:flutter/material.dart';
import 'package:klnceparentsapp/pages/home_screen.dart';
import 'package:klnceparentsapp/pages/website_down.dart';

import '../functions/api.dart';

class WebsiteCheckScreen extends StatefulWidget {
  const WebsiteCheckScreen({Key? key}) : super(key: key);

  @override
  State<WebsiteCheckScreen> createState() => _WebsiteCheckScreenState();
}

class _WebsiteCheckScreenState extends State<WebsiteCheckScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkWebsiteStatus().then((value) {
      setState(() {
        if (value == false) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => WebsiteDownScreen(),
              transitionDuration: Duration(milliseconds: 150),
              transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => KLNCEParents(),
              transitionDuration: Duration(milliseconds: 150),
              transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(color: Colors.deepOrange,),
      ),
    );
  }
}
