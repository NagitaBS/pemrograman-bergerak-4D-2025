import 'package:flutter/material.dart';
import 'book_detail_page.dart';
import 'edit_book.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buku Favorit',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 228, 61, 139),
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: BookListPage(),
    );
  }
}

class Book {
  String id;
  String judul;
  String penulis;
  int tahun;
  String genre;
  double rating;
  String coverUrl;

  Book({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.tahun,
    required this.genre,
    required this.rating,
    required this.coverUrl,
  });
}

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Book> books = [
    Book(
      id: '1',
      judul: 'Laskar Pelangi',
      penulis: 'Andrea Hirata',
      tahun: 2005,
      genre: 'Fiksi Inspiratif',
      rating: 4.8,
      coverUrl: 'https://covers.openlibrary.org/b/id/10523346-L.jpg',
    ),
    Book(
      id: '2',
      judul: 'Perahu Kertas',
      penulis: 'Dee Lestari',
      tahun: 2009,
      genre: 'Romansa',
      rating: 4.5,
      coverUrl: 'https://covers.openlibrary.org/b/id/11812402-L.jpg',
    ),
    Book(
      id: '3',
      judul: 'Negeri 5 Menara',
      penulis: 'Ahmad Fuadi',
      tahun: 2009,
      genre: 'Fiksi Religi',
      rating: 4.7,
      coverUrl: 'https://covers.openlibrary.org/b/id/11459079-L.jpg',
    ),
    Book(
      id: '4',
      judul: 'Supernova: Ksatria, Puteri dan Bintang Jatuh',
      penulis: 'Dee Lestari',
      tahun: 2001,
      genre: 'Fiksi Sains Filosofis',
      rating: 4.6,
      coverUrl: 'https://covers.openlibrary.org/b/id/9879676-L.jpg',
    ),
    Book(
      id: '5',
      judul: 'Bumi',
      penulis: 'Tere Liye',
      tahun: 2014,
      genre: 'Fantasi',
      rating: 4.9,
      coverUrl: 'https://covers.openlibrary.org/b/id/12427028-L.jpg',
    ),
  ];

  void _addBook() async {
    final newBook = await showDialog<Book>(
      context: context,
      builder: (_) => EditBookDialog(),
    );

    if (newBook != null) {
      setState(() {
        books.add(newBook);
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Buku berhasil ditambahkan')));
    }
  }

  void _editBook(Book book) async {
    final updatedBook = await showDialog<Book>(
      context: context,
      builder: (_) => EditBookDialog(book: book),
    );

    if (updatedBook != null) {
      setState(() {
        int index = books.indexWhere((b) => b.id == updatedBook.id);
        if (index != -1) books[index] = updatedBook;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Buku berhasil diupdate')));
    }
  }

  void _deleteBook(String id) {
    setState(() {
      books.removeWhere((book) => book.id == id);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Buku berhasil dihapus')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Buku Favorit')),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return BookCard(
            book: book,
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BookDetailPage(book: book)),
                ),
            onEdit: () => _editBook(book),
            onDelete: () => _deleteBook(book.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addBook,
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const BookCard({
    required this.book,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book.coverUrl,
                  width: 80,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          Icon(Icons.broken_image, size: 80),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.judul,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(book.penulis),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Text('${book.rating}'),
                        SizedBox(width: 8),
                        Icon(Icons.category, size: 16),
                        Text(book.genre),
                      ],
                    ),
                    Text('Tahun: ${book.tahun}'),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') onEdit();
                  if (value == 'delete') onDelete();
                },
                itemBuilder:
                    (_) => [
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(value: 'delete', child: Text('Hapus')),
                    ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
