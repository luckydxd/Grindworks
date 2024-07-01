import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grindworks/api/my_api.dart';
import 'package:grindworks/components/text_widget.dart';
import 'package:grindworks/models/get_layanan_info.dart';

class DetailLayanan extends StatefulWidget {
  DetailLayanan({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  DetailLayananState createState() => DetailLayananState();
}

class DetailLayananState extends State<DetailLayanan> {
  var layanan = <LayananInfo>[];

  @override
  void initState() {
    super.initState();

    getDetailLayanan();
  }

  Future<void> getDetailLayanan() async {
    var response = await CallApi().getPublicData("getlayanan/${widget.index}");
    var data = json.decode(response.body);
    LayananInfo layanan = LayananInfo.fromJson(data);
    setState(() {
      layanan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: layanan[0].deskripsi ??
                    '', // tergantung list layanan tidak kosong
                fontSize: 20,
              ),
              SizedBox(height: 10),
              Row(
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
                  SizedBox(width: 10),
                  Text('Freelancer123'),
                  Spacer(),
                  Icon(Icons.calendar_today, size: 20),
                  SizedBox(width: 5),
                  Text('Waktu Pengiriman\n9 Hari'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.blue),
                  SizedBox(width: 5),
                  Text('4.9'),
                ],
              ),
              SizedBox(height: 10),
              Image.asset('assets/background1.png'),
              SizedBox(height: 10),
              Text(
                'Deskripsi Layanan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(
                  'etiam sed. Pharetra morbi urna nisi non dis arcu egestas ipsum. Vulputate iaculis laoreet elementum volutpat.'),
              SizedBox(height: 10),
              Text(
                'Layanan yang Diberikan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              ...[
                'etiam sed. Pharetra morbi urna nisi non dis arcu egestas ipsum. Vulputate iaculis laoreet elementum volutpat.',
                'etiam sed.',
                'Tipe Perangkat: etiam sed.',
              ].map((text) => Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(text),
                  )),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Kirim Pesan'),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Pertanyaan yang Sering Diajukan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Pembayaran',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('<Judul Paket>'),
                      Text('<Fitur yang disediakan paket>'),
                    ],
                  ),
                  Text('Rp.300rb'),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {},
                  child: Text('Lanjutkan Pembayaran'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
