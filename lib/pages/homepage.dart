import 'dart:convert';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grindworks/api/my_api.dart';
import 'package:grindworks/components/text_widget.dart';
import 'package:grindworks/models/get_article_info.dart';
import 'package:grindworks/pages/detail_book.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    debugPrint(height.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 30,
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
                      onPressed: () {},
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
              itemCount: articles.length,
              itemBuilder: (_, i) {
                return GestureDetector(
                  onTap: () {
                    debugPrint(i.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailBookPage(index: 1)),
                    );
                  },
                  child: articles.isEmpty
                      ? CircularProgressIndicator()
                      : Stack(
                          children: [
                            Positioned(
                              top: 35,
                              child: Container(
                                height: 180,
                                width: width * 0.85,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0.0),
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
                              top: 40,
                              left: 2,
                              child: Card(
                                elevation: 10,
                                shadowColor: Colors.grey.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        "http://192.168.109.73:8000/uploads/" +
                                            (articles[i].img ?? ''),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 45,
                              left: width * 0.4,
                              child: Container(
                                height: 200,
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: articles[i].title ?? '',
                                      fontSize: 20,
                                    ),
                                    TextWidget(
                                      color: Colors.grey,
                                      text: articles[i].author == null
                                          ? "Lucky"
                                          : articles[i].author ?? '',
                                      fontSize: 16,
                                    ),
                                    Divider(color: Colors.black),
                                    TextWidget(
                                      text: articles[i].description ?? '',
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
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
                Row(
                  children: [
                    TextWidget(
                      text: "Lihat Semua",
                      fontSize: 14,
                      color: Color(0xFFF76C5E),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFFF76C5E),
                        size: 16,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: height * 0.4,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allarticles.length,
                  itemBuilder: (_, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailBookPage(index: 1),
                          ),
                        );
                      },
                      child: allarticles.isEmpty
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
                                    child: Image.network(
                                      "http://192.168.109.73:8000/uploads/" +
                                          allarticles[i].img.toString(),
                                      fit: BoxFit.contain,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 5,
                                  ),
                                  TextWidget(
                                    text: allarticles[i].title ?? '',
                                    fontSize: 20,
                                  ),
                                  TextWidget(
                                    text: allarticles[i].author == null
                                        ? "Lucky D."
                                        : "" + (allarticles[i].author ?? ''),
                                    fontSize: 16,
                                    color: Color(0xFFa9b3bd),
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
