import 'package:flutter/material.dart';

import 'either.dart';

class ChatModel {
  final List<Either<Message, SystemMessage>> _messages = [];
  final TextEditingController controller = TextEditingController();

  List<Either<Message, SystemMessage>> get messages =>
      List.unmodifiable(_messages);

  addMessages(List<Either<Message, SystemMessage>> newMessages) {
    _messages.addAll(newMessages);
  }
}

@immutable
class Message {
  final String author;
  final String content;

  Message(this.author, this.content);

  static bool sanityCheck(Map<dynamic, dynamic> json) {
    return json.containsKey("name") && json.containsKey("text");
  }

  factory Message.fromJson(Map<dynamic, dynamic> json) {
    return Message(json["name"], json["text"]);
  }
}

@immutable
class SystemMessage {
  final String content;

  SystemMessage(this.content);

  static bool sanityCheck(Map<dynamic, dynamic> json) {
    return json.containsKey("text");
  }

  factory SystemMessage.fromJson(Map<dynamic, dynamic> json) {
    return SystemMessage(json["text"]);
  }
}

typedef OnSend(String content);

class ChatPage extends StatelessWidget {
  final OnSend _onSend;
  final TextEditingController _controller;
  final List<Either<Message, SystemMessage>> _messages;

  ChatPage(this._onSend, this._controller, this._messages);

  @override
  Widget build(BuildContext context) {
    return _render(context, _messages, _controller, _onSend);
  }

  Widget _render(
      BuildContext context,
      List<Either<Message, SystemMessage>> messages,
      TextEditingController controller,
      OnSend onSend) {
    return Column(
      children: [
        Expanded(child: _renderChat(context, messages)),
        Card(
            elevation: 8.0,
            shape: Border(),
            margin: EdgeInsets.zero,
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                        child: TextField(
                          controller: controller,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ))),
                Padding(
                    padding: EdgeInsets.all(4.0),
                    child: IconButton(
                      icon: Icon(Icons.send,
                          color: Theme.of(context).accentColor),
                      onPressed: () => onSend(controller.text),
                    )),
              ],
            )),
      ],
    );
  }

  Widget _renderChat(
      BuildContext context, List<Either<Message, SystemMessage>> messages) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: ListView.builder(
          itemBuilder: (ctx, inx) =>
              messages[inx].fold(_renderMessage, _renderSystemMessage),
          itemCount: messages.length,
        ));
  }

  Widget _renderMessage(Message message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: message.author + ": ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            TextSpan(
                text: message.content,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }

  Widget _renderSystemMessage(SystemMessage message) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        widthFactor: null,
        heightFactor: 1.0,
        child: Text(message.content,
            style: TextStyle(color: Colors.white54, fontStyle: FontStyle.italic)),
      ),
    );
  }
}
