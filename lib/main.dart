import 'package:firebase_three/pages/home_page.dart';
import 'package:firebase_three/pages/sign_in_page.dart';
import 'package:firebase_three/pages/sign_up_page.dart';
import 'package:firebase_three/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveService.dbName);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyFireBaseAppThree());
}


class MyFireBaseAppThree extends StatelessWidget {
  const MyFireBaseAppThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Third Firebase App",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true
        ),
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        primaryColor: Colors.white
      ),
      home: const SignUpPage(),
      routes: {
        HomePage.id: (context) => const HomePage(),
        SignInPage.id: (context) => const SignInPage(),
        SignUpPage.id: (context) => const SignUpPage(),
      },
    );
  }
}
