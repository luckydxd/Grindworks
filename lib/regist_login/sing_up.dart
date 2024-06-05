import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grindworks/api/my_api.dart';
import 'package:grindworks/pages/homepage.dart';
import 'package:grindworks/components/text_widget.dart';
import 'package:grindworks/regist_login/sing_in.dart';




class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController passController = TextEditingController();
  TextEditingController repassController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // ignore: unused_element
  _register() async {
    var data = {
      'name'  :nameController.text,
      'email' : emailController.text,
      'password' : passController.text,
    };
    debugPrint(nameController.text);
    debugPrint(emailController.text);
    debugPrint(passController.text);
    debugPrint(repassController.text);

    var res = await CallApi().postData(data, 'register');
    var body = json.decode(res.body);
    print(body);
    if(body['success']){
      //SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString('token', body['token']);
      //localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ArticlePage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
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
            SizedBox(height:height*0.05),
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
            SizedBox(height:height*0.05),
            TextInput(textString:"Nama", textController:nameController,obscureText: false ),
            SizedBox(height: height*.02),
            TextInput(textString:"Email", textController:emailController,obscureText: false ),
            SizedBox(height: height*.02,),
            TextInput(textString:"Password", textController:passController, obscureText: true,),
            SizedBox(height: height*.02,),
            TextInput(textString:"Password", textController:repassController, obscureText: true,),
            SizedBox(height: height*.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              TextWidget(text:"Registrasi", fontSize:22, isUnderLine:false),

                GestureDetector(

                  onTap: (){
                    _register();
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
                        MaterialPageRoute(builder: (context)=>const SignIn())
                    );
                  },
                  child:TextWidget(text:"Login", fontSize:16, isUnderLine:true),
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
        ),
        ),
      );


  }
}


// ignore: must_be_immutable
class TextInput extends StatelessWidget {
  final String textString;
  TextEditingController textController;
  final bool obscureText;
  TextInput({super.key, required this.textString, required this.textController, required this.obscureText});

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

