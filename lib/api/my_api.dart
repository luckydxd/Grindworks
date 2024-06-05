import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CallApi{
  final String _url = 'http://192.168.109.73/laravel/public/api/';
  final String _imgUrl='http://192.168.109.73:8000/uploads/';
  // final String _url = 'http://192.168.11.73/api/';
  // final String _imgUrl='http://192.168.11.73/uploads/';
  getImage(){
    return _imgUrl;
  }
  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }
  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken() ;
    return await http.get(
        Uri.parse(fullUrl),
        headers: _setHeaders()
    );
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }


  getArticles(apiUrl) async {

  }
  getPublicData(apiUrl) async {
    http.Response response = await http.get(
      Uri.parse(_url+apiUrl));
      try {
        if (response.statusCode == 200) {
          return response;
        } else {
          return 'failed';
        }
      } catch (e) {
        print(e);
        return 'failed';
      }
  }

  
}