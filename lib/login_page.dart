
import 'package:flutter/material.dart';

typedef LoginCallback(String login);

class LoginModel {
  final TextEditingController controller = TextEditingController();

  kill() {
    controller.dispose();
  }
}

class LoginPage extends StatelessWidget {
  final LoginCallback _loginCallback;
  final TextEditingController _controller;

  LoginPage(this._loginCallback, this._controller);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _controller,
            enableSuggestions: false,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: "your chat name...",
            ),
          ),
          FlatButton(
            onPressed: () => _loginCallback(_controller.text),
            child: Text("Log in"),
          )
        ],
      ),
    );
  }
}
