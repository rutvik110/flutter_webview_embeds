import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TwitterEmbed extends StatefulWidget {
  const TwitterEmbed({Key? key}) : super(key: key);

  @override
  State<TwitterEmbed> createState() => _TwitterEmbedState();
}

class _TwitterEmbedState extends State<TwitterEmbed> {
  late bool isLoaded;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoaded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Twitter Embed"),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: Uri.dataFromString(
              getHtmlString("1524510341165576192"),
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ).toString(),
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: <JavascriptChannel>{}..add(
                JavascriptChannel(
                  name: 'Twitter',
                  onMessageReceived: (JavascriptMessage message) {
                    setState(() {
                      isLoaded = true;
                      final previewHeight = double.parse(message.message);
                    });
                  },
                ),
              ),
          ),
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(
                milliseconds: 300,
              ),
              child: isLoaded
                  ? const SizedBox.shrink()
                  : const CircularProgressIndicator(),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

String getHtmlString(String tweetId) {
  return """
      <html>
      
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <style>
           
            *{box-sizing: border-box;margin:0px; padding:0px;}
              #container {
                        display: flex;
                        justify-content: center;
                        margin: 0 auto;
                        max-width:100%;
                        max-height:100%;
                    }      
          </style>
        </head>

        <body>

            <div id="container"></div>
                
        </body>

        <script id="twitter-wjs" type="text/javascript" async defer src="https://platform.twitter.com/widgets.js" onload="createMyTweet()"></script>

        <script>
        
       

      function  createMyTweet() {  

         var twtter = window.twttr;
  
         twttr.widgets.createTweet(
          '$tweetId',
          document.getElementById('container'),
          {
            theme:"dark",
          }
        ).then( function( el ) {

              const widget = document.getElementById('container');
              Twitter.postMessage(widget.clientHeight);

        });
      }

        </script>
        
      </html>
    """;
}
