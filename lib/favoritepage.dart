import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteRecipes;
  final Function(int) onLikeRecipe; // Callback untuk mengubah status like

  FavoritePage({required this.favoriteRecipes, required this.onLikeRecipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Resep Favorit'),
      ),
      body: favoriteRecipes.isEmpty
          ? Center(child: Text('Tidak ada resep favorit'))
          : ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          final recipe = favoriteRecipes[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(recipe['name'] ?? 'Nama Resep'),
              subtitle: Text(recipe['description'] ?? 'Deskripsi resep'),
              trailing: IconButton(
                icon: Icon(
                  recipe['liked'] ?? false
                      ? Icons.thumb_up
                      : Icons.thumb_up_off_alt,
                  color: recipe['liked'] ?? false
                      ? Colors.blue
                      : Colors.grey,
                ),
                onPressed: () {
                  onLikeRecipe(index); // Mengubah status like
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
