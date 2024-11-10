import 'package:flutter/material.dart';
import 'categorydetailpage.dart';
import 'addcategorypage.dart';
import 'addrecipepage.dart';
import 'favoritepage.dart';
import 'searchpage.dart'; // Import halaman Favorit

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, List<Map<String, dynamic>>> categoryRecipes = {}; // Menyimpan kategori dan resep terkait
  List<String> filteredCategories = [];
  String searchText = '';
  List<Map<String, dynamic>> favoriteRecipes = []; // Daftar resep favorit
  int _selectedIndex = 0; // Menyimpan index dari BottomNavigationBar

  @override
  void initState() {
    super.initState();
    filteredCategories = categoryRecipes.keys.toList();
  }

  void _addCategory(String category) {
    setState(() {
      categoryRecipes[category] = [];
      filteredCategories = categoryRecipes.keys.toList();
    });
  }

  void _addRecipe(String category, Map<String, dynamic> recipe) {
    setState(() {
      categoryRecipes[category]?.add(recipe);
      _filterCategories();
    });
  }

  void _deleteCategory(String category) {
    setState(() {
      categoryRecipes.remove(category);
      _filterCategories();
    });
  }

  void _deleteRecipe(String category, int index) {
    setState(() {
      categoryRecipes[category]?.removeAt(index);
      _filterCategories();
    });
  }

  void _filterCategories() {
    setState(() {
      filteredCategories = categoryRecipes.keys
          .where((category) =>
      category.toLowerCase().contains(searchText.toLowerCase()) ||
          categoryRecipes[category]!
              .any((recipe) =>
              recipe['name'].toLowerCase().contains(searchText.toLowerCase())))
          .toList();
    });
  }

  void _likeRecipe(int index, String category) {
    setState(() {
      bool isLiked = categoryRecipes[category]?[index]['liked'] ?? false;
      categoryRecipes[category]?[index]['liked'] = !isLiked;
      if (isLiked) {
        favoriteRecipes.remove(categoryRecipes[category]?[index]);
      } else {
        favoriteRecipes.add(categoryRecipes[category]![index]);
      }
    });
  }

  // Fungsi untuk mengganti halaman yang aktif di BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _currentPage;
    if (_selectedIndex == 1) {
      // Halaman Favorit
      _currentPage = FavoritePage(favoriteRecipes: favoriteRecipes, onLikeRecipe: (int index) {});
    } else if (_selectedIndex == 2) {
      // Halaman Pencarian
      _currentPage = SearchPage(); // Halaman Pencarian yang Anda buat sebelumnya
    } else {
      // Halaman Home (Kategori Resep)
      _currentPage = Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                  _filterCategories();
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari kategori atau resep...',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                final category = filteredCategories[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      category,
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryDetailPage(category: category),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Hapus Kategori'),
                            content: Text('Apakah Anda yakin ingin menghapus kategori ini?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _deleteCategory(category);
                                },
                                child: Text('Hapus'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Daftar Kategori Resep'),
      ),
      body: _currentPage, // Halaman yang akan ditampilkan
      // BottomAppBar untuk navigasi simetris
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Ikon Home di kiri
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            // Ikon Search di tengah
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Navigasi ke halaman pencarian
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
            // Ikon Favorit di kanan
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newCategory = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCategoryPage(
                onAddCategory: (String category) {
                  setState(() {
                    _addCategory(category);
                  });
                },
              ),
            ),
          );
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'categorydetailpage.dart';
// import 'addcategorypage.dart';
// import 'addrecipepage.dart';
// import 'favoritepage.dart'; // Import halaman Favorit
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Map<String, List<Map<String, dynamic>>> categoryRecipes = {}; // Menyimpan kategori dan resep terkait
//   List<String> filteredCategories = [];
//   String searchText = '';
//   List<Map<String, dynamic>> favoriteRecipes = []; // Daftar resep favorit
//   int _selectedIndex = 0; // Menyimpan index dari BottomNavigationBar
//
//   @override
//   void initState() {
//     super.initState();
//     filteredCategories = categoryRecipes.keys.toList();
//   }
//
//   void _addCategory(String category) {
//     setState(() {
//       categoryRecipes[category] = [];
//       filteredCategories = categoryRecipes.keys.toList();
//     });
//   }
//
//   void _addRecipe(String category, Map<String, dynamic> recipe) {
//     setState(() {
//       categoryRecipes[category]?.add(recipe);
//       _filterCategories();
//     });
//   }
//
//   void _deleteCategory(String category) {
//     setState(() {
//       categoryRecipes.remove(category);
//       _filterCategories();
//     });
//   }
//
//   void _deleteRecipe(String category, int index) {
//     setState(() {
//       categoryRecipes[category]?.removeAt(index);
//       _filterCategories();
//     });
//   }
//
//   void _filterCategories() {
//     setState(() {
//       filteredCategories = categoryRecipes.keys
//           .where((category) =>
//       category.toLowerCase().contains(searchText.toLowerCase()) ||
//           categoryRecipes[category]!
//               .any((recipe) =>
//               recipe['name'].toLowerCase().contains(searchText.toLowerCase())))
//           .toList();
//     });
//   }
//
//   void _likeRecipe(int index, String category) {
//     setState(() {
//       bool isLiked = categoryRecipes[category]?[index]['liked'] ?? false;
//       categoryRecipes[category]?[index]['liked'] = !isLiked;
//       if (isLiked) {
//         favoriteRecipes.remove(categoryRecipes[category]?[index]);
//       } else {
//         favoriteRecipes.add(categoryRecipes[category]![index]);
//       }
//     });
//   }
//
//   // Fungsi untuk mengganti halaman yang aktif di BottomNavigationBar
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget _currentPage;
//     if (_selectedIndex == 1) {
//       // Halaman Favorit
//       _currentPage = FavoritePage(favoriteRecipes: favoriteRecipes, onLikeRecipe: (int ) {  },);
//     } else {
//       // Halaman Home (Kategori Resep)
//       _currentPage = Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: (value) {
//                 setState(() {
//                   searchText = value;
//                   _filterCategories();
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: 'Cari kategori atau resep...',
//                 prefixIcon: Icon(Icons.search, color: Colors.grey),
//                 fillColor: Colors.white,
//                 filled: true,
//                 contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredCategories.length,
//               itemBuilder: (context, index) {
//                 final category = filteredCategories[index];
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: ListTile(
//                     title: Text(
//                       category,
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               CategoryDetailPage(category: category),
//                         ),
//                       );
//                     },
//                     trailing: IconButton(
//                       icon: Icon(Icons.delete, color: Colors.red),
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: Text('Hapus Kategori'),
//                             content: Text('Apakah Anda yakin ingin menghapus kategori ini?'),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 child: Text('Batal'),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                   _deleteCategory(category);
//                                 },
//                                 child: Text('Hapus'),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orangeAccent,
//         title: Text('Daftar Kategori Resep'),
//       ),
//       body: _currentPage, // Halaman yang akan ditampilkan
//       // BottomNavigationBar untuk navigasi
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favorit',
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final newCategory = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddCategoryPage(
//                 onAddCategory: (String category) {
//                   setState(() {
//                     _addCategory(category);
//                   });
//                 },
//               ),
//             ),
//           );
//         },
//         backgroundColor: Colors.orange,
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
