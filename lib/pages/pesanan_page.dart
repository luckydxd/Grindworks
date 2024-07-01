import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grindworks/models/get_layanan_info.dart';
import 'package:grindworks/components/text_widget.dart';
import 'package:grindworks/utils/currency_format.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PesananPage extends StatefulWidget {
  final LayananInfo? layananInfo;

  PesananPage({required this.layananInfo});

  @override
  _PesananPageState createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  bool _isLoading = false;
  int? _userId;
  final TextEditingController _deskripsiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserId();
  }

  Future<void> _fetchUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('token');

    final response = await http.get(
      Uri.parse('http://192.168.112.73/laravel/public/api/user'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonRes = json.decode(response.body);
      setState(() {
        _userId = jsonRes['user']['id'];
      });
    } else {
      print('Failed to fetch user ID with status: ${response.statusCode}');
      print('Failed with body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch user ID')),
      );
    }
  }

  Future<void> _confirmOrder() async {
    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User ID not available')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://192.168.112.73:8000/api/pesanan'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': _userId,
        'layanan_id': widget.layananInfo?.id,
        'deskripsi': _deskripsiController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order confirmed!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to confirm order: ${responseData['message']}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to confirm order: ${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextWidget(
              text: widget.layananInfo?.judul ?? '',
              fontSize: 18,
            ),
            SizedBox(height: 10),
            TextWidget(
              text: widget.layananInfo?.fitur ?? '',
              fontSize: 16,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            TextWidget(
              text: 'Rp.${formatCurrency(widget.layananInfo?.hargaLayanan)}',
              fontSize: 16,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _deskripsiController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Deskripsi',
              ),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _confirmOrder,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Konfirmasi Pesanan'),
            ),
          ],
        ),
      ),
    );
  }
}
