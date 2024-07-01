import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grindworks/widget/bottomnavbar.dart';
import 'package:local_auth/local_auth.dart';
import 'package:grindworks/api/my_api.dart';
import 'package:flutter/services.dart';
import 'package:grindworks/components/text_widget.dart';
import 'package:grindworks/auth/auth_page.dart';
import 'package:grindworks/regist_login/sing_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController textController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;
  String _authorized = 'Not Authorized';

  @override
  void dispose() {
    textController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _showMsg(String msg) {
    final snackBar = SnackBar(
      backgroundColor: const Color(0xFF363f93),
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _login() async {
    var data = {
      'email': emailController.text,
      'password': textController.text,
    };

    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AuthPage()));
    } else {
      if (!mounted) return;
      _showMsg(body['message']);
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });

      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
      );

      if (!mounted) return;
      setState(() {
        _isAuthenticating = false;
        _authorized = authenticated ? 'Authorized' : 'Not Authorized';
      });

      if (authenticated) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        String? token = localStorage.getString('token');
        if (token != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const AuthPage()));
        } else {
          _showMsg('Please login manually the first time to set up biometrics.');
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (!mounted) return;
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.1),
              Container(
                padding: const EdgeInsets.only(left: 0, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Color(0xFF363f93)),
                        onPressed: () =>
                            Navigator.of(context, rootNavigator: true)
                                .pop(context))
                  ],
                ),
              ),
              SizedBox(height: height * 0.1),
              Container(
                width: 150,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png'),
                  ],
                ),
              ),
              SizedBox(height: height * 0.1),
              TextInput(
                textString: "Email",
                textController: emailController,
                hint: "Email",
                obscureText: false,
              ),
              SizedBox(height: height * .05),
              TextInput(
                textString: "Password",
                textController: textController,
                hint: "Password",
                obscureText: true,
              ),
              SizedBox(height: height * .05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                      text: "Sign in", fontSize: 22, isUnderLine: false),
                  GestureDetector(
                      onTap: () {
                        _login();
                      },
                      child: Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF363f93),
                          ),
                          child: const Icon(Icons.arrow_forward,
                              color: Colors.white, size: 30)))
                ],
              ),
              SizedBox(height: height * 0.1),
              GestureDetector(
                onTap: () {
                  _authenticateWithBiometrics();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign in with Biometrics',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: TextWidget(
                        text: "Sign up", fontSize: 16, isUnderLine: true),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: TextWidget(
                        text: "Forgot Password",
                        fontSize: 16,
                        isUnderLine: true),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  final String textString;
  TextEditingController textController;
  final String hint;
  bool obscureText;

  TextInput(
      {super.key,
      required this.textString,
      required this.textController,
      required this.hint,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Color(0xFF000000)),
      cursorColor: const Color(0xFF9b9b9b),
      controller: textController,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: textString,
        hintStyle: const TextStyle(
            color: Color(0xFF9b9b9b),
            fontSize: 15,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
