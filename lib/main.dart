import 'package:flutter/material.dart';
import 'package:tadatest/chat_page.dart';
import 'package:tadatest/login_page.dart';

import 'either.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Either<ChatModel, LoginModel> _screen = Either.right(LoginModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _screen.fold((l) => AppBar(title: Text("The Chat")), (r) => null),
      body: _screen.fold((model) => ChatPage(_send, model.controller, model.messages), (model) => LoginPage(_loginToChat, model.controller)),
    );
  }

  _send(String content) {

  }

  _loginToChat(String login) {
    setState(() {
      _screen = Either.left(ChatModel());
    });
  }

}
