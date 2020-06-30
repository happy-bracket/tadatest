import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tadatest/chat_page.dart';
import 'package:tadatest/login_page.dart';
import 'package:web_socket_channel/io.dart';

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
  IOWebSocketChannel chatChannel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _screen.fold((l) => AppBar(title: Text("The Chat")), (r) => null),
      body: _screen.fold(
          (model) => ChatPage(_send, model.controller, model.messages),
          (model) => LoginPage(_loginToChat, model.controller)),
    );
  }

  _send(String content) {
    chatChannel.sink.add(jsonEncode({"text": content}));
    setState(() {
      _screen.apply((l) => {l.controller.text = ""}, (r) => {});
    });
  }

  _loginToChat(String login) {
    chatChannel =
        IOWebSocketChannel.connect("ws://pm.tada.team/ws?name=$login");
    chatChannel.stream.listen((event) {
      final result = jsonDecode(event);

      if (!(result is Map)) return;

      if (result.containsKey("name") && Message.sanityCheck(result)) {
        setState(() {
          _screen.apply(
              (l) => l.addMessages([Either.left(Message.fromJson(result))]),
              (r) => {});
        });
      } else {
        if (SystemMessage.sanityCheck(result)) {
          setState(() {
            _screen.apply(
                (l) => l.addMessages(
                    [Either.right(SystemMessage.fromJson(result))]),
                (r) => {});
          });
        }
      }
    });

    setState(() {
      _screen = Either.left(ChatModel());
    });
  }
}
