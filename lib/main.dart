import 'package:flutter/material.dart';
import 'package:localwebchat/stream/custom_message_input.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {
  final client = Client(
    '22fbtm2sqfhy',
    logLevel: Level.INFO,
  );

  await client.setUser(
    User(id: 'square-bonus-8'),
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic3F1YXJlLWJvbnVzLTgifQ.kazfpMHaAwcMUDxKnB5YaPsorC3ODRO0GDnmMNU2LPs',
  );

  final channel = client.channel('messaging', id: 'godevs');

  // ignore: unawaited_futures
  channel.watch();

  runApp(MyApp(client, channel));
}

class MyApp extends StatelessWidget {
  final Client client;
  final Channel channel;

  MyApp(this.client, this.channel);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamChat(
        client: client,
        child: StreamChannel(
          channel: channel,
          child: ChannelPage(client, channel),
        ),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  final Client client;
  final Channel channel;

  const ChannelPage(
    this.client,
    this.channel, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(),
          ),
          CustomMessageInput(client,channel),
        ],
      ),
    );
  }
}
