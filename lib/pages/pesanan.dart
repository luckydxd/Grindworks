import 'package:flutter/material.dart';

void main() {

  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Flutter Demo',

      home: Scaffold(

        body: MyHomePage(),

      ),

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

    );

  }

}