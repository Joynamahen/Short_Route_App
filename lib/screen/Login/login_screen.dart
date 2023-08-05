import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:short_route/customFunction/custom_function.dart';
import 'package:short_route/screen/Home/home_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _signIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 241, 240, 240),
          persistentFooterButtons: [
            TextButton.icon(
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  padding: const EdgeInsets.all(15.0),
                  primary: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 39, 108, 46),
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                onPressed: () async {
                  try {
                    final GoogleSignInAccount? googleUser =
                        await _googleSignIn.signIn();
                    final GoogleSignInAuthentication googleAuth =
                        await googleUser!.authentication;

                    final AuthCredential credential =
                        GoogleAuthProvider.credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken,
                    );

                    final UserCredential userCredential =
                        await _auth.signInWithCredential(credential);
                    final token = await userCredential.user!.getIdToken();
                    if (userCredential.user != null) {
                      _signIn();
                    }
                  } catch (e) {
                    CustomFunction.loginErrorDialog(context, e.toString());
                  }
                },
                icon: FaIcon(
                    color: Colors.white, FontAwesomeIcons.google, size: 30),
                label: const Text(
                  'Continue with Google',
                  style: TextStyle(color: Colors.white),
                )),
          ],
          body: Center(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
