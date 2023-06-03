import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/components/rect_button.dart';
import 'package:tracker/components/rect_textformfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKeyLogin = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  handleSubmit() {
    const SnackBar(content: Text('Submitting...'));
    if (_formKeyLogin.currentState!.validate()) {
      signInUser(context);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Submitted!')),
      // );
    }
  }

  // Function that signs in user to firebase
  Future signInUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
              "Oops! There's something wrong with your email or password. Check again!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              width: (screenWidth > 750) ? (screenWidth * 0.5) : screenWidth,
              child: Form(
                key: _formKeyLogin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "LOGIN",
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            offset: Offset(5.0, 5.0),
                            blurRadius: 2.0,
                            color: Colors.grey.shade300,
                          ),
                        ],
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 20,
                        fontSize: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .fontSize!,
                      ),
                    ),
                    UnDraw(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width * 0.35,
                        illustration: UnDrawIllustration.mobile_login,
                        color: Theme.of(context).primaryColor),
                    RectTextFormField(
                      controller: _emailController,
                      labelTextField: 'Email',
                      isObscured: false,
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    RectTextFormField(
                      controller: _passwordController,
                      isObscured: true,
                      labelTextField: 'Password',
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/signup");
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    RectButton(
                      formKey: _formKeyLogin,
                      vp: 10,
                      hp: 0,
                      handler: handleSubmit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
