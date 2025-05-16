class Book {
  final String id;
  final String judul;
  final String penulis;
  final int tahun;
  final String genre;
  final double rating;
  Book({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.tahun,
    required this.genre,
    required this.rating,
  });

  factory Book.fromMap(String id, Map<String, dynamic> data) => Book(
    id: id,
    judul: data['judul'],
    penulis: data['penulis'],
    tahun: data['tahun'],
    genre: data['genre'],
    rating: data['rating'].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'judul': judul,
    'penulis': penulis,
    'tahun': tahun,
    'genre': genre,
    'rating': rating,
  };
}
