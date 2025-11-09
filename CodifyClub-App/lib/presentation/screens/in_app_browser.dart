import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppBrowser extends StatefulWidget {
  final String url;
  final String title;

  InAppBrowser({ required this.url,this.title=""});

  @override
  _InAppBrowserState createState() => _InAppBrowserState();
}

class _InAppBrowserState extends State<InAppBrowser> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      // //  title: Text('Map'),
      // ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
