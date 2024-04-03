import 'package:flutter/material.dart';
import 'package:tuloss_coo/pages/Home/connexion.dart';
import 'package:tuloss_coo/pages/cooperative/accueil.dart';
import 'package:tuloss_coo/pages/cooperative/add.dart';
import 'package:tuloss_coo/pages/cooperative/liste.dart';
import 'package:tuloss_coo/pages/Home/home.dart';
import 'package:tuloss_coo/pages/Home/inscription.dart';
import 'package:tuloss_coo/pages/cooperative/liste2.dart';
import 'package:tuloss_coo/pages/formation/accueil.dart';
import 'package:tuloss_coo/pages/membre/accueil.dart';
import 'package:tuloss_coo/pages/signature.dart';
import 'package:tuloss_coo/widget/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      home: AccueilFormationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

