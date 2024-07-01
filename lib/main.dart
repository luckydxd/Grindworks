import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grindworks/regist_login/sing_in.dart';
import 'package:grindworks/welcome/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
      routes: {
        '/signIn': (context) => SignIn(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _seenWelcomePage = false;

  @override
  void initState() {
    super.initState();
    _checkWelcomePageSeen();
  }

  _checkWelcomePageSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = prefs.getBool('seenWelcomePage') ?? false;
    setState(() {
      _seenWelcomePage = seen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_seenWelcomePage) {
      return SignIn();
    } else {
      return WelcomePage(
        onWelcomeComplete: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('seenWelcomePage', true);
          setState(() {
            _seenWelcomePage = true;
          });
        },
      );
    }
  }
}
