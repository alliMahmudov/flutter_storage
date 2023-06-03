import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced/pages/main_page.dart';
import 'package:flutter_advanced/pages/signin_page.dart';
import 'package:flutter_advanced/service/auth_service.dart';

class SplashPage extends StatefulWidget {
  static const String id = "splash_page";

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initTimer();
  }

  void _initTimer() {
    Timer(const Duration(seconds: 2), () {
      _callNextPage();
    });
  }

  _callNextPage() {
    if (AuthService.isLoggedIn()) {
      Navigator.pushReplacementNamed(context, MainPage.id);
    } else {
      Navigator.pushReplacementNamed(context, SignInPage.id);
    }
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("SPLASH PAGE"),
      ),
    );
  }
}
