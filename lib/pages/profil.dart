import 'package:flutter/material.dart';
// import 'package:grindworks/widget/bottomnavbar.dart';

class ProfileScreen extends StatelessWidget {
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
                Text(
                  'User123',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                )
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
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}
