import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:tracker/components/rect_button.dart';
import 'package:tracker/components/rect_textformfield.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKeySignup = GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _fn = new TextEditingController();
  final TextEditingController _ln = new TextEditingController();
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  handleSubmit() {
    if (_formKeySignup.currentState!.validate()) {
      signUpUser(context);
    }
  }

  Future signUpUser(BuildContext context) async {
    try {
      String emailText = _emailController.text.trim();
      String passwordText = _passwordController.text.trim();
      String fnText = _fn.text.trim();
      String lnText = _ln.text.trim();

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailText, password: passwordText);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signing you up...'),
          duration: const Duration(seconds: 1),
        ),
      );
      await addUserDetails(emailText, passwordText, fnText, lnText);
      FirebaseAuth.instance.currentUser!.reload();
      var user = FirebaseAuth.instance.currentUser!;
      if (user != null) {
        //not signed in
        Navigator.pushReplacementNamed(context, "/auth");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Oops! There's something wrong with your email or password. Check again!"),
        ),
      );
    }
  }

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

  Future addUserDetails(
      String email, String password, String firstname, String lastname) async {
    await FirebaseFirestore.instance.collection("users2").add({
      "email": email,
      "password": password,
      "first name": firstname,
      "last name": lastname
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: (screenWidth > 750) ? (screenWidth * 0.5) : screenWidth,
                child: Form(
                  key: _formKeySignup,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "SIGN UP",
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
                          illustration: UnDrawIllustration.forms,
                          color: Theme.of(context).primaryColor),
                      RectTextFormField(
                        controller: _fn,
                        labelTextField: 'First Name',
                        isObscured: false,
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      RectTextFormField(
                        controller: _ln,
                        labelTextField: 'Last Name',
                        isObscured: false,
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
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
                      Container(
                        width: double.infinity,
                        child: FlutterPwValidator(
                          key: validatorKey,
                          successColor: Colors.green.shade700,
                          controller: _passwordController,
                          minLength: 6,
                          width: 400,
                          height: 150,
                          onSuccess: () {},
                          onFail: () {},
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RectButton(
                        formKey: _formKeySignup,
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
      ),
    );
  }
}
