import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../translations/locale_keys.g.dart';

class CompilerWebView extends StatefulWidget {
  const CompilerWebView({Key? key, required this.compilerURL}) : super(key: key);

  final String compilerURL;

  @override
  State<CompilerWebView> createState() => _CompilerWebViewState();
}

class _CompilerWebViewState extends State<CompilerWebView> {
  late WebViewController _webViewController;
  double _loadingProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.LearnCompilerWebViewTitle.tr()),
        // Leading icon button to navigate back
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (_webViewController != null) {
              // Check if we can go back in WebView history
              _webViewController.canGoBack().then((canGoBack) {
                if (canGoBack) {
                  // If WebView can go back, navigate back
                  _webViewController.goBack();
                } else {
                  // If WebView cannot go back, navigate to previous screen
                  Navigator.pop(context);
                }
              });
            } else {
              // If WebView controller is not initialized, navigate to previous screen
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Stack(
        children: [
          // WebViewWidget
          WebView(
            initialUrl: widget.compilerURL,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _webViewController = controller;
            },
            onPageStarted: (String url) {
              setState(() {
                _loadingProgress = 0.0;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                _loadingProgress = 1.0;
              });
            },
            onProgress: (int progress) {
              setState(() {
                _loadingProgress = progress / 100;
              });
            },
          ),
          // Loading indicator
          if (_loadingProgress < 1.0)
            LinearProgressIndicator(
              value: _loadingProgress,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
        ],
      ),
    );
  }
}
