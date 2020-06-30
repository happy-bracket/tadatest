
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef LoginCallback(string);

class LoginPage extends StatelessWidget {

  final LoginCallback _loginCallback;
  final TextEditingController controller = TextEditingController();

  LoginPage(this._loginCallback);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: controller,
            enableSuggestions: false,
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: () => _loginCallback(controller.text),
            child: Text("Войти"),
          )
        ],
      ),
    );
  }



}