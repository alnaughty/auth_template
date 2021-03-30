import 'package:auth_template/auth_template.dart';
import 'package:flutter/material.dart';

class SendCodePage extends StatelessWidget {
  final AuthSettings settings;
  final Color? buttonColor;
  SendCodePage({this.buttonColor = Colors.blue,required this.settings});
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Forgot Password",style: TextStyle(
                  color: buttonColor,
                  fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                  fontWeight: FontWeight.bold
              ),),
              const SizedBox(
                height: 40,
              ),
              settings.textField(
                  controller: _controller,
                  label: "Code"
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
                        colors: [buttonColor!, buttonColor!.withOpacity(0.8)],
                        begin: AlignmentDirectional.bottomCenter
                    )
                ),
                child: MaterialButton(
                  onPressed: () async{
                    if(_controller.text.isNotEmpty){
                      settings.forgotPasswordSettings!.codeComponent.callback!({"status" : "loading"});
                      await settings.forgotPasswordSettings!.sendCode(code: _controller.text);
                    }else{
                      settings.forgotPasswordSettings!.codeComponent.callback!({"error" : "Code must contain a value"});
                    }
                  },
                  child: Center(
                    child: Text("Submit",style: TextStyle(
                        color: buttonColor!.computeLuminance() > 0.5 ? Colors.black : Colors.white
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
      ),
    );
  }
}
