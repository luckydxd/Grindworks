import 'package:flutter/material.dart';
import 'package:grindworks/bottomnavbar.dart';

void main() => runApp(pesanan());

void main() {

  runApp(MyApp());

}

<<<<<<< HEAD
class _pesananState extends State<pesanan> {
=======
class MyApp extends StatelessWidget {

>>>>>>> 1c223159aeba72be7d7196119f9c2d65e8d560f1
  @override

  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 107, 107, 107),
        elevation: 0,
        title: const Text(
          'Pesanan',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false, // Atur menjadi false untuk menempatkan di kiri
      ),
      body: Center(
        child: _buildBody(),
      ),
      bottomNavigationBar: BottomNavBar(),
// bottomNavigationBar: BottomNavBar(),
=======

    return MaterialApp(

      title: 'Flutter Demo',

      home: Scaffold(

        body: MyHomePage(),

      ),

>>>>>>> 1c223159aeba72be7d7196119f9c2d65e8d560f1
    );

  }

}

class MyHomePage extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text('Pesanan'),

        backgroundColor: Colors.white,

        elevation: 0,

        centerTitle: false,

        titleTextStyle: TextStyle(color: Colors.black, fontSize: 24),

      ),

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            Text(

              'Belum Ada Pesanan',

              style: TextStyle(

                fontSize: 20,

                color: Colors.black,

              ),

            ),

            SizedBox(height: 4),

            Text(

              'Jelajahi Marketplace',

              style: TextStyle(

                fontSize: 16,

                color: Colors.lightBlue,

              ),

            ),

          ],

        ),
<<<<<<< HEAD
        
      ],
      
=======

      ),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: 2, // Set the default selected item to the third one

        items: [

          BottomNavigationBarItem(

            icon: Icon(Icons.home),

            label: '',

          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.inventory),

            label: '',

          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.search),

            label: '',

          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.article),

            label: '',

          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.person),

            label: '',

          ),

        ],

        selectedIconTheme: IconThemeData(color: Colors.lightBlue),

        unselectedIconTheme: IconThemeData(color: Colors.black),

      ),

>>>>>>> 1c223159aeba72be7d7196119f9c2d65e8d560f1
    );

  }

}