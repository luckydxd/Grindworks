import 'package:flutter/material.dart';
import 'package:grindworks/components/text_widget.dart';
import 'package:grindworks/models/get_layanan_info.dart';
import 'package:grindworks/utils/currency_format.dart';
import 'package:grindworks/pages/pesanan_page.dart';

class DetailLayananPage extends StatefulWidget {
  final LayananInfo? layananInfo;
  final int index;

  DetailLayananPage({required this.layananInfo, required this.index});

  @override
  _DetailLayananPageState createState() => _DetailLayananPageState();
}

class _DetailLayananPageState extends State<DetailLayananPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 30,
            backgroundColor: Color(0xFFffffff),
            elevation: 0.0,
          ),
          body: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Container(
                  //   padding: const EdgeInsets.only(left: 0, right: 30),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       IconButton(
                  //         padding: EdgeInsets.zero,
                  //         constraints: BoxConstraints(),
                  //         icon: Icon(Icons.arrow_back_ios,
                  //             color: Color(0xFF363f93)),
                  //         onPressed: () => Navigator.pop(context),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    width: screenWidth - 40,
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: this.widget.layananInfo?.judul ?? '',
                          fontSize: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: "Lucky D.",
                              fontSize: 16,
                              color: Color(0xFF7b8ea3),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.calendar_today, size: 20),
                                  SizedBox(
                                      width:
                                          5), // Jarak antara ikon kalender dan teks
                                  Text(
                                    'Waktu Pengiriman\n9 Hari',
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xFF7b8ea3)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.blue),
                            SizedBox(width: 5),
                            Text('4.9'),
                          ],
                        ),
                        // Divider(color: Colors.grey),
                        // TextWidget(
                        //   text: this.widget.layananInfo?.deskripsi2 ?? '',
                        //   fontSize: 16,
                        //   color: Color(0xFF7b8ea3),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          width: 300,
                          child: Material(
                            elevation: 0.0,
                            child: Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "http://192.168.112.73:8000/uploads/" +
                                        (widget.layananInfo?.img ?? ''),
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5), // Jarak antara gambar dan detail
                      // Detail di bawah gambar
                    ],
                  ),
                  SizedBox(height: 20),
                  // Divider(color: Color(0xFF7b8ea3)),
                  SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      TextWidget(text: "Deskripsi Layanan", fontSize: 18),
                      Expanded(child: Container()),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 120,
                    child: TextWidget(
                      text: widget.layananInfo?.deskripsi ?? "",
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      TextWidget(text: "Layanan yang diberikan", fontSize: 18),
                      Expanded(child: Container()),
                    ],
                  ),
                  Container(
                    height: 100,
                    alignment: Alignment.centerLeft,
                    child: TextWidget(
                      text: widget.layananInfo?.deskripsi2 ?? "",
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      TextWidget(text: "Alat", fontSize: 18),
                      Expanded(child: Container()),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 120,
                    child: TextWidget(
                      text: widget.layananInfo?.alat ?? "",
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      TextWidget(text: "Jumlah Revisi", fontSize: 18),
                      Expanded(child: Container()),
                    ],
                  ),

                  Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: TextWidget(
                      text: widget.layananInfo?.revisi.toString() ?? "",
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 85, 178, 255)),
                      onPressed: () {},
                      child: Text('Kirim Pesan'),
                    ),
                  ),
                  Divider(color: Color(0xFF7b8ea3)),
                  Row(
                    children: [
                      Expanded(
                          child: Container()), // Adds space before the text
                      TextWidget(text: "Pembayaran", fontSize: 18),
                      Expanded(child: Container()), // Adds space after the text
                    ],
                  ),
                  Divider(color: Color(0xFF7b8ea3)),
                  Container(
                    height: 50,
                    child: TextWidget(
                      text: widget.layananInfo?.info ?? "",
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 60,
                    child: TextWidget(
                      text: widget.layananInfo?.fitur ?? "",
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Rp.${formatCurrency(widget.layananInfo?.hargaLayanan)}",
                    // "Rp.${layanan.hargaLayanan?.toStringAsFixed(0) ?? "0"}rb",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),

                   Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PesananPage(layananInfo: widget.layananInfo),
                          ),
                        );
                      },
                      child: Text('Lanjutkan Pembayaran'),
                  ),
                   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
