library auth_template;

import 'package:auth_template/pack/main_exporter.dart';
export 'package:auth_template/pack/main_exporter.dart';

class AuthTemplate extends StatefulWidget {
  final AuthSettings authSettings;
  final Color? buttonColor, backgroundColor;
  final Widget buttonChild;
  AuthTemplate({required this.authSettings, this.buttonColor= Colors.red, required this.buttonChild, this.backgroundColor = Colors.transparent,});

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
        color: widget.backgroundColor,
        elevation: 0,
        shadowColor: widget.backgroundColor,
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
                      style: TextButton.styleFrom(primary: widget.buttonColor),
                      onPressed: (){
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (_) => ForgotPasswordPage(
                                  settings: authSettings,
                                  buttonColor: widget.buttonColor,
                                )
                            )
                        );
                      },
                      child: Text("Forgot password ?",style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic,
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
                      authSettings.apiCallback!({"status" : "loading"});
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


