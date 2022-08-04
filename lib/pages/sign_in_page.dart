import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_three/pages/sign_up_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/hive_service.dart';
import '../services/util_service.dart';
import 'home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  static const id = "sign_in_page";

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  void _signIn(){
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    if(email.isEmpty || password.isEmpty) {
      Utils.fireSnackBar("Please fill all gaps", context);
      return;
    }
    isLoading = true;
    setState(() {});
    AuthService.signInUser(context, email, password).then((user) => _checkUser(user));
  }
  void _checkUser(User? user) async {
    if(user != null) {
      await HiveService.setData(StorageKey.uid, user.uid);
      if(mounted) Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      Utils.fireSnackBar("Please check your entered data, Please try again!", context);
    }

    isLoading = false;
    setState(() {});
  }
  void _goSignUp(){
    Navigator.pushReplacementNamed(context, SignUpPage.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("SignInPage")
      ),
      body:  Stack(
        children: [
          Center(child: isLoading ? const CircularProgressIndicator() : null),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[700]
                        ),
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                            hintText: "Email"
                          ),
                          style: const TextStyle(color: Colors.white
                          ),
                        ),
                      ),
                  const SizedBox(height: 20,),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[700]
                    ),
                    child: TextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          border: InputBorder.none,
                          hintText: "Password"
                      ),
                      style: const TextStyle(color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: _signIn,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: MediaQuery.of(context).size.width < 600
                        ? const Size(double.infinity, 50)
                        : const Size(500, 50),
                  ),
                    child: const Text("Sign In"),),
                  const SizedBox(height: 20,),
                  Text.rich(
                      TextSpan(
                          style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                          children: [
                            const TextSpan(
                              text: "Don't have an account?  ",
                            ),
                            TextSpan(
                              style: const TextStyle(color: Colors.grey),
                              text: "Sign Up",
                              recognizer: TapGestureRecognizer()..onTap = _goSignUp,
                            ),
                          ]
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
