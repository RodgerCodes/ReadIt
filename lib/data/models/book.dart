import 'dart:typed_data';

class Book {
  final String path;
  final String? title;
  final String? author;
  final Uint8List? cover;

  Book({required this.path, this.title, this.author, this.cover});

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      path: map['path'],
      title: map['title'],
      author: map['author'],
      cover: map['cover'],
    );
  }
}
