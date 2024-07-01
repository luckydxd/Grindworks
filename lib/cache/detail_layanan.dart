import 'package:flutter/material.dart';
import 'package:grindworks/components/text_widget.dart';
import 'package:grindworks/models/get_layanan_info.dart';

class DetailBookPage extends StatefulWidget {
  final LayananInfo? layananInfo;
  final int index;

  DetailBookPage({required this.layananInfo, required this.index});

  @override
  _DetailBookPageState createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
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
                  Container(
                    padding: const EdgeInsets.only(left: 0, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF363f93)),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: Row(
                      children: [
                        Material(
                          elevation: 0.0,
                          child: Container(
                            height: 180,
                            width: 150,
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
                                  "http://192.168.112.73:8000/uploads/" + (widget.layananInfo?.img ?? ''),
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth - 30 - 180 - 20,
                          margin: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              TextWidget(
                                text: this.widget.layananInfo?.judul ?? '',
                                fontSize: 20,
                              ),
                              TextWidget(
                                text: "Lucky D.",
                                fontSize: 14,
                                color: Color(0xFF7b8ea3),
                              ),
                              Divider(color: Colors.grey),
                              TextWidget(
                                text: this.widget.layananInfo?.judul ?? '',
                                fontSize: 16,
                                color: Color(0xFF7b8ea3),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Divider(color: Color(0xFF7b8ea3)),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      TextWidget(text: "Details", fontSize: 30),
                      Expanded(child: Container()),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 200,
                    child: TextWidget(
                      text: widget.layananInfo?.deskripsi ?? "",
                      fontSize: 16,
                      color: Colors.grey,
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