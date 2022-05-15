import 'package:flutter/material.dart';
import 'package:flutter_webview_embeds/social_embeds/twitter_embeds/twitter_embed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Embeds',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TwitterEmbed(),
    );
  }
}
