import 'package:devathon_smit_flutter/screens/home%20view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../../widgets/custom_button.dart';
import '../forget/forget_view.dart';
import '../signup/signup.dart';
import '../widgets/custom_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 character long';
    }
    return null;
  }

  final credential = FirebaseAuth.instance;
  void login() async {
    try {
      loading = true;
      setState(() {});
      await credential.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );

      // Login successful
      loading = false;
      emailController.clear();
      passwordController.clear();
      setState(() {});
      Utils().toastMessage("Login Successful", Colors.green);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ));
      loading = false;
      setState(() {});

      debugPrint("Login Successful");
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      loading = false;
      setState(() {});
      if (e.code == 'user-not-found') {
        errorMessage = 'No account found for the provided email.';
        debugPrint(errorMessage);
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password for the given email.';
        debugPrint(errorMessage);
      } else {
        errorMessage = 'Login failed: ${e.message}';
        debugPrint(errorMessage);
      }

      Utils().toastMessage(errorMessage, Colors.red);
    }
    emailController.clear;
    passwordController.clear;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image.asset('assets/images/loginD.png'),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Login',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 25,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff747474)),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15)),
                      child: CustomTextFormField(
                        title: 'Email',
                        validator: validateEmail,
                        controller: emailController,
                        iconR: Icons.person,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff747474)),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15)),
                      child: CustomTextFormField(
                        title: 'Password',
                        iconR: Icons.send,
                        validator: validatePassword,
                        controller: passwordController,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ));
                },
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffB28CFF),
                      decoration: TextDecoration.underline,
                    ),
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
                  buttonText: 'LOG IN',
                  buttonColor: const Color(0xffB28CFF),
                  buttonTextStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // debugPrint('Attempting login...');
                      login();
                      debugPrint('Form is valid');
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
                    'Don\'t have an account?',
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
                            builder: (context) => const SignupView(),
                          ));
                    },
                    child: const Text(
                      ' Sign Up',
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
    );
  }
}
