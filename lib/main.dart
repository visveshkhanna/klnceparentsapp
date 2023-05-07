import 'package:flutter/material.dart';
import 'package:klnceparentsapp/pages/home_screen.dart';
import 'package:klnceparentsapp/pages/website_check.dart';

void main() {
  runApp(const KLNCEParentsApp());
}

class KLNCEParentsApp extends StatelessWidget {
  const KLNCEParentsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KLNCE Parents App',
      theme: ThemeData(),
      home: WebsiteCheckScreen(),
    );
  }
}
