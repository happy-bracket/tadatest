
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'either.dart';

@immutable
class Message {

  final String author;
  final String content;

  Message(
      this.author,
      this.content
      );

}

@immutable
class SystemMessage {

  final String content;

  SystemMessage(
      this.content
      );

}

typedef OnSend(String content);

class ChatPage extends StatelessWidget {

  final OnSend _onSend;
  final TextEditingController _controller = TextEditingController();

  Widget _render(List<Either<Message, SystemMessage>> messages) {
    return Column(
      children: [
        ListView.builder(
            itemBuilder: (ctx, inx) => messages[inx].fold(_renderMessage, _renderSystemMessage),
          itemCount: messages.length,
        ),
        Row(
          children: [
            TextField(
              controller: _controller,
            ),
            FlatButton(
              onPressed: _onSend,
              child: Text("Send"),
            )
          ],
        )
      ],
    );
  }

  Widget _renderMessage(Message message) {

  }

  Widget _renderSystemMessage(SystemMessage message) {

  }

}