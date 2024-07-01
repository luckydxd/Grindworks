import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grindworks/api/my_api.dart';
import 'package:grindworks/components/text_widget.dart';
import 'package:grindworks/models/get_article_info.dart';
import 'package:grindworks/models/get_layanan_info.dart';
import 'package:grindworks/pages/detail_layanan_page.dart';
import 'package:grindworks/utils/currency_format.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

class AllLayanan extends StatefulWidget {
  const AllLayanan({super.key});

  @override
  _AllLayananState createState() => _AllLayananState();
}

class _AllLayananState extends State<AllLayanan> {
  var articles = <ArticleInfo>[];
  var layanan = <LayananInfo>[];

  @override
  void initState() {
    _getArticles();

    super.initState();
  }

  _getArticles() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // ignore: unused_local_variable

    var user = localStorage.getString("user");

    /*

    if(user!=null){

      var userInfo=jsonDecode(user);

      debugPrint(userInfo);

    } else {

      debugPrint("no info");

    }*/

    await _initData();
  }

  _initData() async {
    await CallApi().getPublicData("allarticles").then((response) {
      setState(() {
        Iterable list = json.decode(response.body);

        articles = list.map((model) => ArticleInfo.fromJson(model)).toList();
      });
    });

    await CallApi().getPublicData("getlayanan").then((response) {
      print('Response data: ${response.body}');
      if (response.body is String) {
        setState(() {
          Iterable list = json.decode(response.body);
          layanan = list.map((model) => LayananInfo.fromJson(model)).toList();
        });
      } else {
        print('Error getting Layanan: ${response.body}');
      }
    }).catchError((error) {
      print('Error occurred: $error');
    });
  }

  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.arrow_back_ios,
                            color: Color(0xFF363f93)),
                        onPressed: () => Navigator.pop(context)),
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon:
                            Icon(Icons.home_outlined, color: Color(0xFF363f93)),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticlePage()))),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: layanan.length == 0
                      ? CircularProgressIndicator()
                      : Column(
                          children: layanan.map((layanan) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailLayananPage(
                                            layananInfo: layanan, index: 0)));
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Image.network(
                                          "http://192.168.112.73:8000/uploads/" +
                                              (layanan.img ?? ''),
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          layanan.judul ?? "",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    color: Colors.blue,
                                                    size: 16),
                                                SizedBox(width: 4),
                                                Text('4.9',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.blue)),
                                              ],
                                            ),
                                            Text(
                                              "Rp.${formatCurrency(layanan.hargaLayanan)}",
                                              // "Rp.${layanan.hargaLayanan?.toStringAsFixed(0) ?? "0"}rb",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
