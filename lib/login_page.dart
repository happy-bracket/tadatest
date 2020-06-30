import 'package:flutter/material.dart';

typedef LoginCallback(String login);

class LoginModel {
  final TextEditingController controller = TextEditingController();
  bool emptyError = false;

  kill() {
    controller.dispose();
  }
}

class LoginPage extends StatelessWidget {
  final LoginCallback _loginCallback;
  final TextEditingController _controller;
  final bool _emptyError;

  LoginPage(this._loginCallback, this._controller, this._emptyError);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            Spacer(flex: 2),
            Expanded(
                flex: 5,
                child: TextField(
                  controller: _controller,
                  enableSuggestions: false,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  decoration: InputDecoration(
                    hintText: "Your chat name...",
                    errorText: _emptyError ? "Name cannot be empty" : null,
                  ),
                )),
            Spacer(flex: 2)
          ]),
          FlatButton(
            onPressed: () => _loginCallback(_controller.text),
            color: Theme.of(context).accentColor,
            child: Text("LOG IN"),
          )
        ],
      ),
    );
  }
}
