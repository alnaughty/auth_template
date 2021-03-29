library auth_template;
import 'dart:io';

import 'package:flutter/material.dart';
import 'helper.dart';
import 'helper.dart';

class AuthTemplate extends StatefulWidget {
  final AuthSettings authSettings;
  final Color? buttonColor;
  final Widget buttonChild;
  AuthTemplate({required this.authSettings, this.buttonColor= Colors.red, required this.buttonChild});
  @override
  _AuthTemplateState createState() => _AuthTemplateState();
}

class _AuthTemplateState extends State<AuthTemplate> {
  late AuthSettings authSettings = widget.authSettings;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Material(
        child: Align(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if(authSettings.allowBack)...{
                  Container(
                    width: double.infinity,
                    height: 60,
                    alignment: AlignmentDirectional.centerStart,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(null),
                      icon: Icon(Platform.isMacOS || Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
                    ),
                  )
                },

                authSettings.emailTextField(),
                const SizedBox(
                  height: 10,
                ),
                authSettings.passwordTextField(
                    onPressed: (){
                      setState(() {
                        authSettings.hidePassword= !authSettings.hidePassword;
                      });
                    }
                ),
                if(authSettings.forgotPasswordSettings != null && authSettings.forgotPasswordSettings!.enable!)...{
                  Container(
                    width: double.infinity,
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: (){},
                      child: Text("Forgot password ?",style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic,
                        color: Colors.blue
                      ),),
                    ),
                  )
                },
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                          colors: [widget.buttonColor!, widget.buttonColor!.withOpacity(0.8)],
                          begin: AlignmentDirectional.bottomCenter
                      )
                  ),
                  child: MaterialButton(
                    onPressed: (){
                      authSettings.requestFromEndpoint();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: widget.buttonChild,
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}


