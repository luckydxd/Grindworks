import 'package:flutter/material.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GRINDWORKS',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _loginUsernameController = TextEditingController();
  TextEditingController _loginPasswordController = TextEditingController();
  TextEditingController _signupUsernameController = TextEditingController();
  TextEditingController _signupPasswordController = TextEditingController();

  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GRINDWORKS'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLogin) ...[
                TextField(
                  controller: _loginUsernameController,
                  decoration: InputDecoration(
                    labelText: 'Username/Email',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _loginPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _loginPressed();
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = false;
                    });
                  },
                  child: Text('Belum punya akun? sign up!'),
                ),
              ] else ...[
                TextField(
                  controller: _signupUsernameController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _signupPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _signupPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Password',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _signupPressed();
                  },
                  child: Text('Sign up'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = true;
                    });
                  },
                  child: Text('Sudah punya akun? Login!'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _loginPressed() {
    String username = _loginUsernameController.text;
    String password = _loginPasswordController.text;

    // Di sini Anda bisa menambahkan logika validasi login
    // Contoh sederhana, jika username dan password kosong maka akan dianggap gagal login
    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog('Username dan password harus diis');
    } else {
      // Di sini Anda bisa menambahkan logika autentikasi, misalnya dengan memeriksa ke server
      // Jika autentikasi berhasil, bisa melakukan navigasi ke halaman selanjutnya
      // Contoh sederhana, navigasi ke halaman beranda
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(username)),
      );
    }
  }

  void _signupPressed() {
    String username = _signupUsernameController.text;
    String password = _signupPasswordController.text;

    // Di sini Anda bisa menambahkan logika validasi pendaftaran
    // Contoh sederhana, jika username dan password kosong maka akan dianggap gagal pendaftaran
    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog('Username dan password harus diisi');
    } else {
      // Di sini Anda bisa menambahkan logika untuk menyimpan data pendaftaran, misalnya ke server
      // Setelah pendaftaran berhasil, bisa melakukan navigasi kembali ke halaman login
      // Contoh sederhana, navigasi kembali ke halaman login
      setState(() {
        _isLogin = true;
      });
      _showSuccessDialog('Registrasi succes! kamu bisa login.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final String username;

  HomePage(this.username);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome, $username!'),
      ),
    );
  }
}
