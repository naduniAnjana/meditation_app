import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:silentmoon/components/my_textfeild.dart';
import 'package:silentmoon/pages/introduction_page.dart';
import 'package:silentmoon/pages/login_page.dart';
import 'package:silentmoon/pages/user_welcome_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isChecked = false;
  bool isHovering = false;
  bool isHoveringg = false;

  Future<void> signUpUser() async {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("All fields are required")));
      return;
    }

    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please accept the Privacy Policy")),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username,
        'email': email,
        'createdAt': DateTime.now(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UserWelcomePage()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Signup failed")));
    }
  }

  Future<void> signUpWithGoogle() async {
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
          context, MaterialPageRoute(builder: (_) => const IntroductionPage()));
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
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
                  'Create your account',
                  style: TextStyle(
                    color: ThemeConfigs.color7,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                // continue with facebook button
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: GestureDetector(
                    onTap: () {
                      
                    },
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
                            milliseconds: 200
                        ), 
                        height: 60,
                        width: 350,
                        decoration: BoxDecoration(
                          color: isHovering
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
                              const SizedBox(
                                  width: 45), 
                              Text(
                                'CONTINUE WITH FACEBOOK',
                                style: TextStyle(
                                  color: isHovering
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
                      signUpWithGoogle();
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
                            milliseconds: 200
                        ), // Smooth transition
                        height: 60,
                        width: 350,
                        decoration: BoxDecoration(
                          color: isHoveringg
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
                              const SizedBox(
                                  width: 45), 
                              Text(
                                'CONTINUE WITH GOOGLE',
                                style: TextStyle(
                                  color: isHoveringg
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
            
                // username textfeild
                MyTextfeild(
                  controller: usernameController, 
                  hintText: 'Username', 
                  obscureText: false,
                ),

                const SizedBox(height: 15),

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

                // privace policy link and tick box
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'I have read the Privace Policy',
                        style: TextStyle(
                          color: ThemeConfigs.color10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Checkbox(   
                        value: isChecked, 
                        onChanged: (value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        }
                      ),
                    ],
                  ),
                ),

                // get started button
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: GestureDetector(
                    onTap: () {
                      signUpUser();
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
                          'SIGN UP',
                          style: TextStyle(
                            color: ThemeConfigs.color2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ALREADY HAVE AN ACCOUNT?',
                      style: TextStyle(color: ThemeConfigs.color6),
                    ),

                    const SizedBox(width: 5),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'LOG IN',
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