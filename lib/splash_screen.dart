import 'dart:async';
import 'package:flutter/material.dart';
import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;
  int _currentFlower = 0; // Menyimpan indeks bunga yang aktif

  @override
  void initState() {
    super.initState();

    // Timer untuk berganti halaman ke HomePage setelah 3 detik
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });

    // Timer untuk animasi titik-titik berjalan
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _currentFlower = (_currentFlower + 1) % 3; // Ganti bunga aktif setiap 500ms
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              "Buku Resep Mami Chipu",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),

            // Baris untuk animasi bunga "berjalan"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFlowerIcon(0),
                SizedBox(width: 10),
                _buildFlowerIcon(1),
                SizedBox(width: 10),
                _buildFlowerIcon(2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun ikon bunga dengan animasi muncul/hilang
  Widget _buildFlowerIcon(int index) {
    return AnimatedOpacity(
      opacity: _currentFlower == index ? 1.0 : 0.3, // Bunga aktif lebih terang
      duration: Duration(milliseconds: 300),
      child: Icon(
        Icons.local_florist, // Ikon bunga
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
