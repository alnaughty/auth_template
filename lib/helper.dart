import 'package:auth_template/forgot_password_helper.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthSettings{
  final String endpoint;
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final ValueChanged? apiCallback;
  final String? emailApiKey;
  final String? passwordApiKey;
  final Color? fieldColor;
  final ForgotPassword? forgotPasswordSettings;

  bool hidePassword = true;

  final bool allowBack;
  AuthSettings({this.fieldColor = Colors.blue,required this.endpoint,this.allowBack = false, this.apiCallback, this.emailApiKey = "email",this.passwordApiKey = "password", this.forgotPasswordSettings});


  Widget emailTextField({String label = "Email"}) {

    return Theme(data: ThemeData(
      primaryColor: this.fieldColor
    ), child: TextField(
      controller: this.email,
      cursorColor: this.fieldColor,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: (){
            this.email.clear();
          },
        )
      ),
    )
    );
  }
  Widget passwordTextField({String label = "Password",required  Function onPressed}){

    return Theme(
        data: ThemeData(
          primaryColor: this.fieldColor
        ),
        child: TextField(
          cursorColor: this.fieldColor,
          controller: this.password,
          obscureText: hidePassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            labelText: label,
            suffixIcon: IconButton(
              onPressed: ()=> onPressed(),
              icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
            )
          ),
        )
    );
  }

  Future<void> requestFromEndpoint() async {
    try{
      var url = Uri.parse(this.endpoint);
      await http.post(url, body: {
        "${this.emailApiKey}" : email.text.toString(),
        "${this.passwordApiKey}" : password.text.toString(),
      }).then((response) {
        var data = json.decode(response.body);
        this.apiCallback!(data);
      });
    }catch(e){
      this.apiCallback!(e);
    }
  }

}