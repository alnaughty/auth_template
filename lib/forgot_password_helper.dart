import 'dart:convert';

import 'package:auth_template/forgot_password_helper_helper.dart';
import 'package:http/http.dart' as http;

class ForgotPassword{
  final bool? enable;
  final ForgotPasswordEmailComponent emailComponent;
  final ForgotPasswordCodeComponent codeComponent;
  ForgotPassword({
    this.enable = false,
    required this.codeComponent,
    required this.emailComponent
  });


  Future<void> sendToEmail({required String email}) async {
    try{
      Uri url = Uri.parse(this.emailComponent.endpoint);
      await http.post(url,headers: {
        "accept" : "application/json"
      }, body: {
        "${this.emailComponent.emailKey}" : "$email"
      }).then((response) {
        var data = json.decode(response.body);
        this.emailComponent.callback!(data);
      });
    }catch(e){
      this.emailComponent.callback!(e);
    }
  }

  Future<void> sendCode({required String code}) async {
    try{
      Uri url = Uri.parse(this.codeComponent.endpoint);
      await http.post(url, headers: {
        "accept" : "application/json"
      },body: {
        "${this.codeComponent.codeKey}" : "$code"
      }).then((value) {
        var data = json.decode(value.body);
        this.codeComponent.callback!(data);
      });
    }catch(e){
      this.codeComponent.callback!(e);
    }
  }
}