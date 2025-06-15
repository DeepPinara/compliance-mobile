import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  final String url;

  const WebView({super.key, required this.url});

  @override
  SDWebViewState createState() => SDWebViewState();
}

class SDWebViewState extends State<WebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            _controller.runJavaScript('''
              document.getElementsByTagName('body')[0].style.overflow = 'scroll';
              document.getElementsByTagName('body')[0].style.position = 'relative';
              document.getElementsByTagName('body')[0].style.height = 'auto';
              document.getElementsByTagName('body')[0].style.webkitOverflowScrolling = 'touch';
            ''');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _controller,
      gestureRecognizers: {}..add(
          Factory<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer(),
          ),
        ),
    );
  }
}