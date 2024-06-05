import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grindworks/api/my_api.dart';
import 'package:grindworks/components/text_widget.dart';
import 'package:grindworks/pages/homepage.dart';
import 'package:grindworks/regist_login/sing_up.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController textController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  _showMsg(msg) { //
    final snackBar = SnackBar(
      backgroundColor: const Color(0xFF363f93),
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _login() async {
    var data = {
      'email' : emailController.text,
      'password' : textController.text,
    };

    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
     localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
              builder: (context) => const ArticlePage()));
    }else{
      _showMsg(body['message']);
    }
  }
  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    return
      Scaffold(
        backgroundColor: const Color(0xFFffffff),

        body:
        Container(
          padding: const EdgeInsets.only(left: 30, right: 40),
          child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:height*0.1),
            Container(
              padding: const EdgeInsets.only(left:0, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      padding:EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon:

                      const Icon(Icons.arrow_back_ios, color:Color(0xFF363f93)),
                      onPressed:()=>Navigator.of(context, rootNavigator: true).pop(context))
                ],
              ),
            ),
            SizedBox(height:height*0.1),
          Container(
            // padding: const EdgeInsets.only(left: 20, right: 30),
            width: 150,
            height: 50,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
                Image.asset(
                    'assets/logo.png'),
              ],
            ),
          ),
            // TextWidget(text:"Here to Get", fontSize:26, isUnderLine:false),
            // TextWidget(text:"Welcomed !", fontSize:26, isUnderLine:false),
            SizedBox(height:height*0.1),
            TextInput(textString:"Email", textController:emailController, hint:"Email"),
            SizedBox(height: height*.05,),
            TextInput(textString:"Password", textController:textController, hint:"Password", obscureText: true,),
            SizedBox(height: height*.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              TextWidget(text:"Sign in", fontSize:22, isUnderLine:false),

                GestureDetector(

                  onTap: (){
                    _login();
                  },
                  child:
                Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    shape:BoxShape.circle,
                        color:Color(0xFF363f93),
                  ),
                  child: const Icon(Icons.arrow_forward, color:Colors.white, size:30),
                )
                )
              ],
            ),
            SizedBox(height:height*0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>const SignUp())
                    );
                  },
                  child:TextWidget(text:"Sign up", fontSize:16, isUnderLine:true),
                ),
                GestureDetector(
                  onTap: (){

                  },
                    child:TextWidget(text:"Forgot Password", fontSize:16, isUnderLine:true),

                )
              ],
            )
          ],
        ),
        )
        ),
      );
  }
}


// ignore: must_be_immutable
class TextInput extends StatelessWidget {
  final String textString;
  TextEditingController textController;
  final String hint;
  bool obscureText;
  TextInput({super.key, required this.textString, required this.textController, required this.hint, this.obscureText=false});


  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Color(0xFF000000)),
      cursorColor: const Color(0xFF9b9b9b),
      controller: textController,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(

        hintText: textString,
        hintStyle: const TextStyle(
            color: Color(0xFF9b9b9b),
            fontSize: 15,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
