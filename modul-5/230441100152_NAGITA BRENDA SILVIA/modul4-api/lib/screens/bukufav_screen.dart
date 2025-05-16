import 'package:flutter/material.dart';
import '../models/bukufav.dart';
import '../services/bukufav_services.dart';

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  late Future<List<Book>> _futureBooks;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _futureBooks = BookService.fetchBooks();
    });
  }

  void _addBook() async {
    final book = Book(
      id: '',
      judul: 'Laskar Pelangi',
      penulis: 'Andrea Hirata',
      tahun: 2005,
      genre: 'Fiksi Inspiratif',
      rating: 4.8,
    );
    await BookService.addBook(book);
    _refresh();
  }

  void _deleteBook(String id) async {
    await BookService.deleteBook(id);
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Buku Favorit')),
      body: FutureBuilder<List<Book>>(
        future: _futureBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada data buku'));
          } else {
            final books = snapshot.data!;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  title: Text(book.judul),
                  subtitle: Text(
                    '${book.penulis} • ${book.genre} • ${book.tahun}',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteBook(book.id),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addBook,
      ),
    );
  }
}
