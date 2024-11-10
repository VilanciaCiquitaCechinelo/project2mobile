import 'package:flutter/material.dart';
import 'addrecipepage.dart';
import 'recipedetailpage.dart';
import 'favoritepage.dart'; // Impor halaman favorit

class CategoryDetailPage extends StatefulWidget {
  final String category;

  CategoryDetailPage({required this.category});

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  List<Map<String, dynamic>> recipes = [];
  List<Map<String, dynamic>> favoriteRecipes = []; // Daftar resep favorit

  void _addRecipe(Map<String, dynamic> recipe) {
    setState(() {
      recipes.add(recipe);
    });
  }

  void _deleteRecipe(int index) {
    setState(() {
      recipes.removeAt(index);
    });
  }

  // Fungsi untuk menyukai resep dan menambahkannya ke favorit
  void _likeRecipe(int index) {
    setState(() {
      recipes[index]['liked'] = !(recipes[index]['liked'] ?? false);
      if (recipes[index]['liked']) {
        favoriteRecipes.add(recipes[index]);
      } else {
        favoriteRecipes.remove(recipes[index]);
      }
    });
    print(favoriteRecipes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Detail Kategori: ${widget.category}'),
        actions: [
          // Ikon untuk membuka halaman favorit
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              // Pindah ke halaman favorit
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritePage(
                    favoriteRecipes: favoriteRecipes,
                    onLikeRecipe: _likeRecipe, // Kirimkan fungsi onLikeRecipe
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailPage(recipe: recipe),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  recipe['image'] != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.file(
                      recipe['image'],
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: Center(child: Text("No Image")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipe['name'] ?? 'Nama Resep',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              recipe['description'] ?? 'Deskripsi singkat resep',
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Tombol Like
                            IconButton(
                              icon: Icon(
                                recipe['liked'] ?? false ? Icons.thumb_up : Icons.thumb_up_off_alt,
                                color: recipe['liked'] ?? false ? Colors.blue : Colors.grey,
                              ),
                              onPressed: () {
                                _likeRecipe(index); // Toggle Like
                              },
                            ),
                            // Tombol Hapus
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Hapus Resep'),
                                    content: Text('Apakah Anda yakin ingin menghapus resep ini?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Batal'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _deleteRecipe(index); // Hapus resep dari daftar
                                        },
                                        child: Text('Hapus'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newRecipe = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRecipePage(category: widget.category)),
          );
          if (newRecipe != null) {
            _addRecipe(newRecipe);
          }
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
    );
  }
}
