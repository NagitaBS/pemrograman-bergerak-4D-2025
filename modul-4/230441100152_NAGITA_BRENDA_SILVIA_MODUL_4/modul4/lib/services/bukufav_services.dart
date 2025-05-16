import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/bukufav.dart';

class BookService {
  static const String baseUrl = 'http://172.16.15.1/bukufavorit-api';

  // Ambil semua buku
  static Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/get.php'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map(
            (item) => Book(
              id: item['id'].toString(),
              judul: item['judul'],
              penulis: item['penulis'],
              tahun: int.parse(item['tahun'].toString()),
              genre: item['genre'],
              rating: double.parse(item['rating'].toString()),
            ),
          )
          .toList();
    } else {
      throw Exception('Gagal memuat data buku');
    }
  }

  static Future<void> addBook(Book book) async {
    final response = await http.post(
      Uri.parse('$baseUrl/post.php'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'judul': book.judul,
        'penulis': book.penulis,
        'tahun': book.tahun.toString(),
        'genre': book.genre,
        'rating': book.rating.toString(),
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal menambahkan buku');
    }
  }

  static Future<void> deleteBook(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete.php?id=$id'));
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus buku');
    }
  }

  static Future<void> updateBook(Book book) async {
    final response = await http.put(
      Uri.parse('$baseUrl/put.php'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'id': book.id,
        'judul': book.judul,
        'penulis': book.penulis,
        'tahun': book.tahun.toString(),
        'genre': book.genre,
        'rating': book.rating.toString(),
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui buku');
    }
  }
}
