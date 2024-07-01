import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:grindworks/api/my_api.dart';
import 'package:grindworks/models/get_pesanan_info.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({Key? key}) : super(key: key);

  @override
  _PesananPageState createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  late Future<List<Pesanan>> futurePesanan;

  @override
  void initState() {
    super.initState();
    futurePesanan = fetchPesanan();
  }

  Future<List<Pesanan>> fetchPesanan() async {
    try {
      final response = await CallApi().getPesanan("getPesanan/");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("API Response: $data");

        if (data is List) {
          List<Pesanan> pesananObjects =
              data.map((json) => Pesanan.fromJson(json)).toList();
          return pesananObjects;
        } else {
          throw Exception('Unexpected response format: data is not a list');
        }
      } else {
        throw Exception('Failed to load pesanan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching pesanan: $e');
    }
  }

  void launchDriveLink(String? fileProject) async {
    if (fileProject != null) {
      final Uri url = Uri.parse(fileProject);

      // Show dialog to let user choose how to open the link
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Open Link'),
            content: Text('Would you like to open this link with an app or in the browser?'),
            actions: <Widget>[
              TextButton(
                child: Text('App'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    showErrorDialog(fileProject);
                  }
                },
              ),
              TextButton(
                child: Text('Browser'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    showErrorDialog(fileProject);
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }

  void showErrorDialog(String? fileProject) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Could not launch $fileProject'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesanan',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 107, 107, 107),
        elevation: 0,
        centerTitle: false,
      ),
      body: FutureBuilder<List<Pesanan>>(
        future: futurePesanan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Belum ada pesanan'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var pesanan = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        pesanan.deskripsi ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text('Status: ${pesanan.status ?? ""}'),
                          SizedBox(height: 4),
                          Text('Tanggal: ${pesanan.tanggal ?? ""}'),
                          SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              launchDriveLink(pesanan.fileProject);
                            },
                            child: Text(
                              '${pesanan.fileProject ?? "Belum diunggah"}',
                              style: TextStyle(
                                color: Colors.blue, // Change text color to blue for indication
                                decoration: TextDecoration.underline, // Add underline to text
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          // Handle tap on each pesanan item
                          // For example, navigate to detail page
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => PesananDetailPage(pesanan: pesanan)));
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
