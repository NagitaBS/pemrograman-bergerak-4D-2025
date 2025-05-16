import 'package:flutter/material.dart';
import 'main.dart';

class EditBookDialog extends StatefulWidget {
  final Book? book;

  const EditBookDialog({this.book});

  @override
  _EditBookDialogState createState() => _EditBookDialogState();
}

class _EditBookDialogState extends State<EditBookDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _judulController;
  late TextEditingController _penulisController;
  late TextEditingController _tahunController;
  late TextEditingController _genreController;
  late TextEditingController _ratingController;
  late TextEditingController _coverUrlController;

  @override
  void initState() {
    super.initState();
    final book = widget.book;
    _judulController = TextEditingController(text: book?.judul ?? '');
    _penulisController = TextEditingController(text: book?.penulis ?? '');
    _tahunController = TextEditingController(
      text: book?.tahun.toString() ?? '',
    );
    _genreController = TextEditingController(text: book?.genre ?? '');
    _ratingController = TextEditingController(
      text: book?.rating.toString() ?? '',
    );
    _coverUrlController = TextEditingController(text: book?.coverUrl ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.book == null ? 'Tambah Buku' : 'Edit Buku'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: InputDecoration(labelText: 'Judul'),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _penulisController,
                decoration: InputDecoration(labelText: 'Penulis'),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _tahunController,
                decoration: InputDecoration(labelText: 'Tahun'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _genreController,
                decoration: InputDecoration(labelText: 'Genre'),
              ),
              TextFormField(
                controller: _ratingController,
                decoration: InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _coverUrlController,
                decoration: InputDecoration(labelText: 'URL Cover'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Batal'),
        ),
        ElevatedButton(
          child: Text('Simpan'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newBook = Book(
                id:
                    widget.book?.id ??
                    DateTime.now().millisecondsSinceEpoch.toString(),
                judul: _judulController.text,
                penulis: _penulisController.text,
                tahun: int.parse(_tahunController.text),
                genre: _genreController.text,
                rating: double.tryParse(_ratingController.text) ?? 0,
                coverUrl: _coverUrlController.text,
              );
              Navigator.pop(context, newBook);
            }
          },
        ),
      ],
    );
  }
}
