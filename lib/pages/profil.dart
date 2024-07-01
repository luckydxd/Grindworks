import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grindworks/api/my_api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grindworks/regist_login/sing_in.dart';
// import 'package:grindworks/main.dart';


class ProfileScreen extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    final api = CallApi();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    if (token != null) {
        print('Logout with token: $token'); 

        final response = await api.getData('logout', token); 

        if (response.statusCode == 200 || response.statusCode == 500) {
            var data = json.decode(response.body);
            print('Logout response: $data');

            localStorage.remove('token');
            // Navigator.of(context).pushReplacementNamed('/SignIn');
Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SignIn()));
        } else {
            print('Logout failed with status: ${response.statusCode}');
            print('Response body: ${response.body}');
        }
    } else {
        print('No token found');
    }
}

Future<String> getUsername() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('token');

    final response = await http.get(
      Uri.parse('http://192.168.112.73/laravel/public/api/user'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonRes = json.decode(response.body);
      return jsonRes['user']['name'];
    } else {
      print('Failed with status: ${response.statusCode}');
      print('Failed with body: ${response.body}');
      throw Exception('Failed to load username');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.grey,
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                SizedBox(width: 16),
                FutureBuilder<String>(
                  future: getUsername(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data ?? 'User123',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Failed to load username');
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Pengaturan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Preferensi'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Akun'),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () => _logout(context),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}