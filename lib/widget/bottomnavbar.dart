import 'package:flutter/material.dart';
import 'package:grindworks/pages/homepage.dart';
import 'package:grindworks/pages/pesanan.dart';
import 'package:grindworks/pages/inbox.dart';
import 'package:grindworks/pages/pencarian.dart';
import 'package:grindworks/pages/profil.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ArticlePage(),
    InboxScreen(),
    SearchPage(),
    pesanan(),
    ProfileScreen(),
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
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
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
