import 'package:flutter/material.dart';

class AddCategoryPage extends StatefulWidget {
  final Function(String) onAddCategory;

  AddCategoryPage({required this.onAddCategory});

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController _controller = TextEditingController();

  void _saveCategory() {
    final category = _controller.text;
    if (category.isNotEmpty) {
      widget.onAddCategory(category);  // Kirim kategori baru ke HomePage
      Navigator.pop(context);  // Kembali ke HomePage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Kategori'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nama Kategori',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveCategory,
              child: Text('Simpan Kategori'),
            ),
          ],
        ),
      ),
    );
  }
}
