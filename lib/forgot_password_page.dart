import 'package:auth_template/auth_template.dart';
import 'package:auth_template/forgot_password_helper.dart';
import 'package:auth_template/helper.dart';
import 'package:auth_template/send_code_page.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  final AuthSettings settings;
  final Color? buttonColor;
  ForgotPasswordPage({required this.settings, this.buttonColor = Colors.blue});
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  RegExp emailRegEx = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  String? cachedEmail;
  TextEditingController _controller = new TextEditingController();
  late AuthSettings settings = widget.settings;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Material(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Forgot Password",style: TextStyle(
                  color: widget.buttonColor,
                  fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                  fontWeight: FontWeight.bold
                ),),
                const SizedBox(
                  height: 40,
                ),
                settings.textField(
                    controller: _controller,
                  label: "Email"
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(primary: widget.buttonColor),
                      onPressed: (){
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (_) => SendCodePage(
                                    settings: settings,
                                  buttonColor: widget.buttonColor,
                                )
                            )
                        );
                      },
                      child: Text("Already got the code ?",style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic
                      ),),
                    ),
                    if(cachedEmail != null)...{
                      Row(
                        children: [
                          Text("Did not recieve a code ? "),
                          TextButton(
                              style: TextButton.styleFrom(primary: widget.buttonColor),
                              onPressed: () async {
                                settings.forgotPasswordSettings!.emailComponent.callback!({"status" : "loading"});
                                await settings.forgotPasswordSettings!.sendToEmail(email: "$cachedEmail");
                              },
                              child: Text("Resend",style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline
                              ),)
                          )
                        ],
                      ),
                    }
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
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
                    onPressed: () async{
                      if(_controller.text.isNotEmpty && emailRegEx.hasMatch(_controller.text)){
                        settings.forgotPasswordSettings!.emailComponent.callback!({"status" : "loading"});
                        await settings.forgotPasswordSettings!.sendToEmail(email: "${_controller.text}");
                        setState(() => cachedEmail = _controller.text);
                      }else{
                        settings.forgotPasswordSettings!.emailComponent.callback!({"error" : "Please enter a valid email"});
                      }
                    },
                    child: Center(
                      child: Text("Send",style: TextStyle(
                        color: widget.buttonColor!.computeLuminance() > 0.5 ? Colors.black : Colors.white
                      ),),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                          colors: [Colors.grey.shade900, Colors.grey.shade800],
                          begin: AlignmentDirectional.bottomCenter
                      )
                  ),
                  child: MaterialButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Center(
                      child: Text("Back",style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
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
