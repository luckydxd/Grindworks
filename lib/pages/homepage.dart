import 'dart:convert';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grindworks/api/my_api.dart';
import 'package:grindworks/components/text_widget.dart';
import 'package:grindworks/models/get_article_info.dart';
import 'package:grindworks/models/get_layanan_info.dart';
import 'package:grindworks/models/get_kategori_info.dart';
import 'package:grindworks/pages/all_books.dart';
import 'package:grindworks/pages/detail_layanan_page.dart';
import 'package:grindworks/pages/pencarian.dart';
import 'package:grindworks/utils/currency_format.dart';

// import 'package:grindworks/pages/detail_layanan.dart';
// import 'package:grindworks/widget/bottomnavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  var articles = <ArticleInfo>[];
  var allarticles = <ArticleInfo>[];
  var layanan = <LayananInfo>[];
  var kategori = <KategoriInfo>[];

  @override
  void initState() {
    _getArticles();

    super.initState();
  }

  _getArticles() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString("user");
    await _initData();
  }

  _initData() async {
    await CallApi().getPublicData("recommendedarticles").then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        articles = list.map((model) => ArticleInfo.fromJson(model)).toList();
      });
    });
    await CallApi().getPublicData("allarticles").then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        allarticles = list.map((model) => ArticleInfo.fromJson(model)).toList();
      });
    });
    await CallApi().getPublicData("getkategori").then((response) {
      print('Response data: ${response.body}'); // perbaikan di baris ini
      if (response.body is String) {
        setState(() {
          Iterable list = json.decode(response.body); // dan disini
          kategori = list.map((model) => KategoriInfo.fromJson(model)).toList();
        });
      } else {
        print('Error getting Kategori: ${response.body}'); // dan disini
      }
    }).catchError((error) {
      print('Error occured: $error');
    });

    await CallApi().getPublicData("kategori").then((response) {
      print('Response data: ${response.body}'); // perbaikan di baris ini
      if (response.body is String) {
        setState(() {
          Iterable list = json.decode(response.body); // dan disini
          kategori = list.map((model) => KategoriInfo.fromJson(model)).toList();
        });
      } else {
        print('Error getting Kategori: ${response.body}'); // dan disini
      }
    }).catchError((error) {
      print('Error occured: $error');
    });

    await CallApi().getPublicData("getlayanan").then((response) {
      print('Response data: ${response.body}'); // perbaikan di baris ini
      if (response.body is String) {
        setState(() {
          Iterable list = json.decode(response.body); // dan disini
          layanan = list.map((model) => LayananInfo.fromJson(model)).toList();
        });
      } else {
        print('Error getting Layanan: ${response.body}'); // dan disini
      }
    }).catchError((error) {
      print('Error occured: $error');
    });
    // await CallApi().getPublicData("layanan").then((response) {
    //   setState(() {
    //     Iterable list = json.decode(response);
    //     layanan = list.map((model) => LayananInfo.fromJson(model)).toList();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    debugPrint(height.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 20,
        backgroundColor: const Color(0xFFffffff),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 30),
            width: double.infinity,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Image.asset('assets/logo.png')],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: "Kategori Populer", fontSize: 20),
                Expanded(child: Container()),
                Row(
                  children: [
                    TextWidget(
                      text: "Lihat Semua",
                      fontSize: 14,
                      color: Color(0xFFF76C5E),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios,
                          color: Color(0xFFF76C5E), size: 16),
                      onPressed: () {
                        // Navigasi ke halaman pencarian
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
            height: height * 0.27,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.9),
              itemCount: kategori.length,
              itemBuilder: (_, i) {
                return GestureDetector(
                  onTap: () {
                    debugPrint(i.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllLayanan()),
                    );
                  },
                  child: kategori.isEmpty
                      ? CircularProgressIndicator()
                      : Stack(
                          children: [
                            Positioned(
                              // top: 2,
                              child: Container(
                                height: 175,
                                width: width * 0.85,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      offset: Offset(-10.0, 0),
                                      blurRadius: 20,
                                      spreadRadius: 4.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              // top: 15,
                              // left: 2,
                              child: Card(
                                elevation: 10,
                                shadowColor: Colors.grey.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  height: 170,
                                  width: 170,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        "http://192.168.112.73:8000/uploads/" +
                                            (kategori[i].img ?? ''),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: width * 0.46,
                              child: Container(
                                height: 200,
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: kategori[i].nama ?? '',
                                      fontSize: 20,
                                    ),
                                    // TextWidget(
                                    //   color: Colors.grey,
                                    //   text: kategori[i].deskripsi == null
                                    //       ? "Lucky"
                                    //       : kategori[i].deskripsi ?? '',
                                    //   fontSize: 16,
                                    // ),
                                    // Divider(color: Colors.black),
                                    // TextWidget(
                                    //   text: kategori[i].deskripsi ?? '',
                                    //   fontSize: 16,
                                    //   color: Colors.grey,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: "Rekomendasi", fontSize: 20),
                // Row(
                //   children: [
                //     TextWidget(
                //       text: "Lihat Semua",
                //       fontSize: 14,
                //       color: Color(0xFFF76C5E),
                //     ),
                //     IconButton(
                //       icon: Icon(
                //         Icons.arrow_forward_ios,
                //         color: Color(0xFFF76C5E),
                //         size: 16,
                //       ),
                //       onPressed: () {},
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: height * 0.35,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: layanan.length,
                  itemBuilder: (_, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              debugPrint(
                                  'Navigating to DetailLayanan with Layanan Info: ${layanan[i]}');
                              return DetailLayananPage(
                                layananInfo: layanan[
                                    i], // Kirim satu objek LayananInfo dari daftar
                                index: i,
                              );
                            },
                          ),
                        );
                      },
                      child: layanan.isEmpty
                          ? CircularProgressIndicator()
                          : Container(
                              height: height * 0.4,
                              width: 150,
                              margin: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: ClipRect(
                                      child: AspectRatio(
                                        aspectRatio:
                                            1, // Rasio aspek 1:1 untuk gambar persegi
                                        child: Image.network(
                                          "http://192.168.112.73:8000/uploads/" +
                                              layanan[i].img.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 5,
                                  ),
                                  SizedBox(
                                      height:
                                          10), // Spasi antara gambar dan deskripsi
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: TextWidget(
                                        text:
                                            (layanan[i].judul?.length ?? 0) > 50
                                                ? (layanan[i]
                                                        .judul!
                                                        .substring(0, 50) +
                                                    '...')
                                                : (layanan[i].judul ?? ''),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          2), // Spasi antara deskripsi dan info lainnya
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.blue, size: 16),
                                          SizedBox(width: 2),
                                          Text('4.9',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blue)),
                                        ],
                                      ),
                                      Text(
                                        "Rp.${formatCurrency(layanan[i].hargaLayanan)}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}
