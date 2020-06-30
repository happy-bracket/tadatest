import 'package:flutter/material.dart';

import 'either.dart';

class ChatModel {
  final List<Either<Message, SystemMessage>> _messages = [
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.right(SystemMessage("mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
    Either.left(Message("hehmda", "mdaheh")),
  ];
  final TextEditingController controller = TextEditingController();

  List<Either<Message, SystemMessage>> get messages => List.unmodifiable(_messages);

  addMessages(List<Either<Message, SystemMessage>> newMessages) {
    _messages.addAll(newMessages);
  }
}

@immutable
class Message {
  final String author;
  final String content;

  Message(this.author, this.content);
}

@immutable
class SystemMessage {
  final String content;

  SystemMessage(this.content);
}

typedef OnSend(String content);

class ChatPage extends StatelessWidget {
  final OnSend _onSend;
  final TextEditingController _controller;
  final List<Either<Message, SystemMessage>> _messages;

  ChatPage(this._onSend, this._controller, this._messages);

  @override
  Widget build(BuildContext context) {
    return _render(_messages, _controller, _onSend);
  }

  Widget _render(List<Either<Message, SystemMessage>> messages,
      TextEditingController controller, OnSend onSend) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (ctx, inx) =>
          messages[inx].fold(_renderMessage, _renderSystemMessage),
      itemCount: messages.length,
    );
  }

  Widget _renderMessage(Message message) {
    return Text(message.author + ": " + message.content);
  }

  Widget _renderSystemMessage(SystemMessage message) {
    return Text(message.content);
  }
}
