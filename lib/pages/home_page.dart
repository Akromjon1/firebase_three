import 'package:firebase_three/pages/sign_in_page.dart';
import 'package:firebase_three/services/auth_service.dart';
import 'package:firebase_three/services/hive_service.dart';
import 'package:flutter/material.dart';

import '../services/util_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _logOut()async{
    try{
      await AuthService.signOutUser(context);
    }catch(e){
      Utils.fireSnackBar(e.toString(), context);
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        actions: [
          IconButton(onPressed: _logOut,
              splashRadius: 25,
              icon: const Icon(Icons.logout,)),
        ],
      ),
    );
  }
}
