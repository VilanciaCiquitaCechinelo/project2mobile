import 'package:flutter/material.dart';
import 'webviewpage.dart'; // Mengimpor WebViewPage

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Resep'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigasi langsung ke WebViewPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebViewPage(url: 'https://www.google.com'),
              ),
            );
          },
          child: Text('Buka Google'),
        ),
      ),
    );
  }
}
