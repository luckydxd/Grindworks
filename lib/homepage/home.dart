import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = 0;
    });
  }
@override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
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
      body: Center(
        child: Text('Selected Index: $_selectedIndex'),

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