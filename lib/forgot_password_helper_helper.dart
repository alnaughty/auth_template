import 'package:flutter/material.dart';

class ForgotPasswordEmailComponent {
  final String endpoint;
  final String? emailKey;
  final ValueChanged? callback;
  ForgotPasswordEmailComponent({this.emailKey = "email",required this.endpoint, this.callback});
}

class ForgotPasswordCodeComponent{
  final String? codeKey;
  final String endpoint;
  final ValueChanged? callback;
  ForgotPasswordCodeComponent({this.codeKey = "verification_code",required this.endpoint, this.callback});
}