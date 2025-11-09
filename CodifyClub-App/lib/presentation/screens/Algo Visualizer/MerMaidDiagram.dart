import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MermaidDiagramWebView extends StatefulWidget {
  @override
  _MermaidDiagramWebViewState createState() => _MermaidDiagramWebViewState();
}

class _MermaidDiagramWebViewState extends State<MermaidDiagramWebView> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(_generateMermaidHTML());
  }

  String _generateMermaidHTML() {
    return '''
    <!DOCTYPE html>
    <html>
    <head>
      <script src="https://cdn.jsdelivr.net/npm/mermaid@11.3.0/dist/mermaid.min.js" integrity="sha256-DStvI2Hn4M5Gam7UWOA9qlWEtC72kmw762LrZGcMomE=" crossorigin="anonymous"></script>
      <script>
        mermaid.initialize({ startOnLoad: true });
      </script>
    </head>
    <body>
    <h1>Hello</h1>
      <div class="mermaid">
        graph TD;
          A[Start] --> B{Is it working?};
          B -->|Yes| C[Proceed];
          B -->|No| D[Fix it];
      </div>
    </body>
    </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mermaid Diagram'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
