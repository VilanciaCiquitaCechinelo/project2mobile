import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddRecipePage extends StatefulWidget {
  final String category;

  AddRecipePage({required this.category});

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveRecipe() {
    if (_nameController.text.isEmpty || _descriptionController.text.isEmpty) {
      // Validasi input jika kosong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Semua kolom harus diisi")),
      );
      return;
    }

    // Buat objek resep
    final newRecipe = {
      'name': _nameController.text,
      'description': _descriptionController.text,
      'ingredients': _ingredientsController.text,
      'instructions': _instructionsController.text,
      'image': _image,
    };

    // Kembali ke halaman sebelumnya dengan membawa data resep baru
    Navigator.pop(context, newRecipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Resep'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama Resep'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi Resep'),
            ),
            TextField(
              controller: _ingredientsController,
              decoration: InputDecoration(labelText: 'Bahan-bahan'),
            ),
            TextField(
              controller: _instructionsController,
              decoration: InputDecoration(labelText: 'Cara Pembuatan'),
            ),
            SizedBox(height: 10),
            _image != null
                ? Image.file(_image!, height: 200, width: double.infinity, fit: BoxFit.cover)
                : Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(child: Text("No Image Selected")),
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Pilih Gambar"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveRecipe,
              child: Text("Simpan Resep"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
