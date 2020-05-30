import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
            child: MessageListView(
              onThreadTap: (message, widget) {
                print(message.toString());
              },
              onFileAction: (Message mesage) async {
                print(mesage.toString());
                http.Response r =
                    await http.head(mesage.attachments[0].assetUrl);
                print(r.headers["content-length"]);
                String contentType = r.headers['content-type'];
                if (contentType.split("/")[0].compareTo("audio") == 0) {
                  print('Audio file');
                  AudioPlayer audioPlugin = AudioPlayer();
                  await audioPlugin.play(mesage.attachments[0].assetUrl);
                  audioPlugin.onPlayerStateChanged
                      .listen((AudioPlayerState event) {
                    print(event);
                    if (event == AudioPlayerState.COMPLETED) {
                      print('completed');
                    }
                  });
                }
              },
              onMessageActions: (BuildContext context, Message message) {
                print(message.toString());
              },
              onMentionTap: (user) {
                print(user);
              },
            ),
          ),
          CustomMessageInput(client, channel),
        ],
      ),
    );
  }
}
