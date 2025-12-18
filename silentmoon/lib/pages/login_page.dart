import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:silentmoon/components/my_textfeild.dart';
import 'package:silentmoon/helpers/dialogbox_helper.dart';
import 'package:silentmoon/pages/forgot_password.dart';
import 'package:silentmoon/pages/introduction_page.dart';
import 'package:silentmoon/pages/signup_page.dart';
import 'package:silentmoon/pages/user_welcome_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isChecked = false;
  bool isHovering = false;
  bool isHoveringg = false;

  Future<void> signInWithEmailPassword() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      DialogHelper.showErrorDialog(context, 'Please enter email and password.');
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UserWelcomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'invalid-credential':
          message = 'Incorrect email or password.';
          break;
        case 'invalid-email':
          message = 'Invalid email address.';
          break;
        case 'user-disabled':
          message = 'This account has been disabled.';
          break;
        default:
          message = 'Login failed. Please try again.';
      }

      DialogHelper.showErrorDialog(context, message);
    }
  }

  Future<void> signInWithGoogle() async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleUser =
        await googleSignIn.signIn();

    if (googleUser == null) return;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final User user = userCredential.user!;

    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    if (!(await userRef.get()).exists) {
      await userRef.set({
        'username': user.displayName ?? '',
        'email': user.email ?? '',
        'createdAt': DateTime.now(),
        'authProvider': 'google',
      });
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const UserWelcomePage()),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google sign-in failed')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // back button
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const IntroductionPage()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        elevation: 0,
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: ThemeConfigs.color7,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // continue with facebook button
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: GestureDetector(
                    onTap: () {},
                    child: MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          isHovering = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          isHovering = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 200,
                        ), 
                        height: 60,
                        width: 350,
                        decoration: BoxDecoration(
                          color:
                              isHovering
                                  ? ThemeConfigs.color3
                                  : ThemeConfigs.color2,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: ThemeConfigs.color3,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Image.asset(
                                  'assets/facebook.png',
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                              const SizedBox(width: 45),
                              Text(
                                'CONTINUE WITH FACEBOOK',
                                style: TextStyle(
                                  color:
                                      isHovering
                                          ? ThemeConfigs.color2
                                          : ThemeConfigs.color8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // continue with google button
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: GestureDetector(
                    onTap: () {
                      signInWithGoogle();
                    },
                    child: MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          isHoveringg = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          isHoveringg = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 200,
                        ),
                        height: 60,
                        width: 350,
                        decoration: BoxDecoration(
                          color:
                              isHoveringg
                                  ? ThemeConfigs.color3
                                  : ThemeConfigs.color2,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: ThemeConfigs.color3,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Image.asset(
                                  'assets/google.png',
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                              const SizedBox(width: 45),
                              Text(
                                'CONTINUE WITH GOOGLE',
                                style: TextStyle(
                                  color:
                                      isHoveringg
                                          ? ThemeConfigs.color2
                                          : ThemeConfigs.color8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // or login with email text
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 35),
                  child: Text(
                    'OR LOG IN WITH EMAIL',
                    style: TextStyle(
                      color: ThemeConfigs.color9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

                // email textfeild
                MyTextfeild(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 15),

                // password textfeild
                MyTextfeild(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 15),

                // Login button
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () {
                      signInWithEmailPassword();
                    },
                    child: Container(
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                        color: ThemeConfigs.color3,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'LOG IN',
                          style: TextStyle(color: ThemeConfigs.color2),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // forgot password link
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const ForgotPassword()),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: ThemeConfigs.color8,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

                const SizedBox(height: 100),

                // sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'DO NOT HAVE AN ACCOUNT?',
                      style: TextStyle(color: ThemeConfigs.color6),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const SignupPage()),
                        );
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(color: ThemeConfigs.color3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
