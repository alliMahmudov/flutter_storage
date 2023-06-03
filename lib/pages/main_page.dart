import 'package:flutter/material.dart';
import 'package:flutter_advanced/service/auth_service.dart';

class MainPage extends StatefulWidget {
  static const String id = "main_page";
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase"),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.red,
          onPressed: (){
            AuthService.signOutUser(context);
          },
          child: const Text("Sign Out"),
        ),
      ),
    );
  }
}
