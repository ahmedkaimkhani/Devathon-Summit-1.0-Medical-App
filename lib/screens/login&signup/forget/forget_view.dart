import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/utils.dart';
import '../../../widgets/custom_button.dart';
import '../login/login_view.dart';
import '../widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool circularLoader = false;
  bool loading = false;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (value.length < 6) {
      return 'Password must be at least 6 character long';
    }
    return null;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  void forgotPassword() {
    setState(() {
      circularLoader = true;
    });
    auth
        .sendPasswordResetEmail(email: emailController.text.toString())
        .then((value) {
      Utils().toastMessage(
          "We have sent your email to recover your password, please check your email",
          Colors.green);
      emailController.clear;
      setState(() {
        circularLoader = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString(), Colors.red);
      setState(() {
        circularLoader = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xffFFFFFF),
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/forget.gif",
                    height: 200,
                  ),
                ),
                const Center(
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Enter your registered email below to receive password reset instruction \u{1F511}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Email",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15)),
                    child: CustomTextFormField(
                      title: 'Email',
                      validator: validateEmail,
                      controller: emailController,
                      iconR: Icons.alternate_email,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    loading: loading,
                    buttonText: 'SIGN UP',
                    buttonColor: const Color(0xffB28CFF),
                    buttonTextStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        forgotPassword();
                        debugPrint('Form is valid');
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const GetStartedView(),
                        //     ));
                      } else {
                        debugPrint('Form is invalid');
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ));
                      },
                      child: const Text(
                        ' Log In',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold),
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

// if (_formKey.currentState!.validate()) {
//                           forgotPassword();
//                         }