import 'package:chat_app/widgets/custom_bottom.dart';
import 'package:chat_app/widgets/custom_text_form_fild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants/constants.dart';
import '../helper/show_snack_bar.dart';
import 'resgiter_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  bool? isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading!,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  "assets/images/scholar.png",
                  height: 100,
                ),
                const Text(
                  'Scholar Chat',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontFamily: 'pacifico'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      ' Login',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFild(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFild(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBottom(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        showSnackBar(context, 'success');
                        Navigator.pushNamed(context, 'homePage',
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                              context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,
                              'Wrong password provided for that user.');
                        }
                      } catch (e) {
                        showSnackBar(context, 'there was an error');
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'Login',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'You don\'t have an account? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        '   Sign Up',
                        style: TextStyle(color: Color(0xffC7EDE6)),
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

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
