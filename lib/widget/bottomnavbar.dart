import 'package:flutter/material.dart';
import 'package:grindworks/pages/homepage.dart';
// import 'package:grindworks/pages/homepage.dart';
import 'package:grindworks/pages/pesanan.dart';
import 'package:grindworks/pages/inbox.dart';
// import 'package:grindworks/pages/detail_book.dart';
// import 'package:grindworks/pages/detail_book.dart';
// import 'package:grindworks/pages/detail_book.dart';

// void main() {
//   runApp(const Bottomnavbar());
// }

// class Bottomnavbar extends StatelessWidget {
//   const Bottomnavbar({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: WelcomePage(),
//     );
//   }
// }
class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  _BottomNavBarState createState() => _BottomNavBarState();
}
class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // Add your screens here
  final List<Widget> _screens = [

    //     Center(child: Text('Chat', style: TextStyle(fontSize: 32))),
    // Center(child: Text('Search', style: TextStyle(fontSize: 32))),
    // Center(child: Text('Order', style: TextStyle(fontSize: 32))),
    // Center(child: Text('Profile', style: TextStyle(fontSize: 32))),
     ArticlePage(),
    //  ChatPage(),
    //  SearchPage(),
     pesanan(),
    //  ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; 
    });
  }

Widget _buildIcon(IconData icon, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: _selectedIndex == index ? Colors.blue : Colors.black),
        if (_selectedIndex == index)
          Container(
            height: 2,
            width: 24,
            color: Colors.blue,

          ),
      ],
    );
  }
  
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.home, 0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.inbox, 1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.search, 2),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.list_alt, 3),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.person, 4),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}