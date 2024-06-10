import 'package:flutter/material.dart';
// import 'package:grindworks/widget/bottomnavbar.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori'),
      ),
      body: ListView(
        children: [
          CategoryItem(
            icon: Icons.web,
            title: 'Pengembangan Website',
            subtitle: 'WordPress, Website Kustom',
          ),
          CategoryItem(
            icon: Icons.phone_android,
            title: 'Pengembangan Aplikasi Seluler',
            subtitle: 'Pengembangan Lintas-Platform, Pengembangan Aplikasi iOS',
          ),
          CategoryItem(
            icon: Icons.computer,
            title: 'Pengembangan AI',
            subtitle: 'Aplikasi AI, Integrasi AI',
          ),
          CategoryItem(
            icon: Icons.videogame_asset,
            title: 'Pengembangan Game',
            subtitle: 'Full Pembuatan Game, Pembuatan Prototipe',
          ),
        ],
      ),
      // Remove/Comment out the bottomNavigationBar to exclude it from your page
      //bottomNavigationBar: BottomNavigationBar(
      //  items: const <BottomNavigationBarItem>[
      //    BottomNavigationBarItem(
      //      icon: Icon(Icons.home),
      //      label: 'Home',
      //    ),
      //    BottomNavigationBarItem(
      //      icon: Icon(Icons.search),
      //      label: 'Search',
      //    ),
      //    BottomNavigationBarItem(
      //      icon: Icon(Icons.library_books),
      //      label: 'Library',
      //    ),
      //    BottomNavigationBarItem(
      //      icon: Icon(Icons.account_circle),
      //      label: 'Account',
      //    ),
      //  ],
      //  selectedItemColor: Colors.amber[800],
      //),
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  CategoryItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        // Handle tap
      },
    );
  }
}
