import 'package:flutter/material.dart';
// import 'package:grindworks/widget/bottomnavbar.dart';

void main() => runApp(pesanan());

class pesanan extends StatefulWidget {
  const pesanan({super.key});

  @override
  _pesananState createState() => _pesananState();
}

class _pesananState extends State<pesanan> {
  @override
  Widget build(BuildContext context) {
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
      // bottomNavigationBar: BottomNavBar(),
// bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget _buildBody() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Belum ada pesanan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
