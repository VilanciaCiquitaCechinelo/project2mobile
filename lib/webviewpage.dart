import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  // Konstruktor untuk menerima URL
  WebViewPage({required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _webViewController;
  bool isLoading = true; // Menyimpan status loading

  @override
  void initState() {
    super.initState();
    WebView.platform = SurfaceAndroidWebView(); // Platform WebView untuk Android
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('WebView - ${widget.url}'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _webViewController.reload(); // Reload halaman WebView
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url, // Menggunakan URL yang diterima dari constructor
            javascriptMode: JavascriptMode.unrestricted, // Menyalakan Javascript
            onWebViewCreated: (WebViewController webViewController) {
              _webViewController = webViewController;
            },
            onPageStarted: (String url) {
              setState(() {
                isLoading = true; // Menampilkan indikator loading
              });
            },
            onPageFinished: (String url) {
              setState(() {
                isLoading = false; // Menyembunyikan indikator loading
              });
            },
            onWebResourceError: (WebResourceError error) {
              setState(() {
                isLoading = false; // Menyembunyikan indikator loading
              });
              print('Terjadi kesalahan: ${error.description}');
            },
          ),
          if (isLoading) // Menampilkan CircularProgressIndicator saat loading
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
