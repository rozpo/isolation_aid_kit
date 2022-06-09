import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:isolation_aid_kit/page/SearchPage.dart';

import 'firebase/auth/AuthUtils.dart';
import 'page/AddPage.dart';
import 'page/HomePage.dart';
import 'page/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Widget _startPage = HomePage();
  if (!isUserSignIn()) {
    _startPage = LoginPage();
  }

  runApp(new MaterialApp(
    title: 'App',
    home: _startPage,
    routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => HomePage(),
      '/login': (BuildContext context) => LoginPage(),
      '/search': (context) => SearchPage(),
      '/add': (context) => AddPage(),
    },
  ));
}

