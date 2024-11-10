import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final Map<String, dynamic> recipe;

  RecipeDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name']),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            recipe['image'] != null
                ? Image.file(
              recipe['image'],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            )
                : Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(child: Text("No Image")),
            ),
            SizedBox(height: 16),
            Text(
              'Deskripsi:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(recipe['description'] ?? '', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text(
              'Bahan-bahan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(recipe['ingredients'] ?? '', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text(
              'Cara Pembuatan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(recipe['instructions'] ?? '', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
