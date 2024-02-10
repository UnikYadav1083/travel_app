import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/widgets/auth_service.dart';
import 'package:travel_app/widgets/gradient_button.dart';
import 'package:travel_app/widgets/social_button.dart';
import 'screens/homeScreen.dart';
import 'widgets/login_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  signUserIn(BuildContext context) async {
    try {
      UserCredential credential =   await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Email',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset("assets/images/signin_balls.png"),
              const Text("Sign in",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  )),
              const SizedBox(
                height: 50,
              ),
              SocialButton(
                iconPath: "assets/svgs/g_logo.svg",
                label: "Continue with Google",
                onPressed: () async {
                  final  account = await AuthService().signInWithGoogle();
                  if (account != null) {
                    // print('Signed in: ${account.displayName}');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "or",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
               LoginField(
                controller: _emailController,
                hintText: 'Email',
              ),
              const SizedBox(
                height: 15,
              ),
               LoginField(
                controller: _passwordController,
                hintText: 'Password',
              ),
              const SizedBox(
                height: 20,
              ),
              GradientButton(
                onTap: () => signUserIn(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
